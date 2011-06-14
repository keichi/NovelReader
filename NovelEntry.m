//
//  NovelEntry.m
//  NovelReader
//
//  Created by Keichi TAKAHASHI on 11/06/08.
//  Copyright 2011 familie takahashi. All rights reserved.
//

#import "NovelEntry.h"


@implementation NovelEntry

@synthesize title;
@synthesize ncode;
@synthesize writer;
@synthesize story;
@synthesize time;
@synthesize length;
@synthesize genre;
@synthesize global_point;
@synthesize fav_novel_cnt;
@synthesize review_cnt;
@synthesize all_point;
@synthesize all_hyoka_cnt;
@synthesize date;
@synthesize general_all_no;

@synthesize chapters;
@synthesize periods;

- (BOOL) parseTableOfContents {
    NSString* str = [[[NSString alloc] initWithFormat:@"http://ncode.syosetu.com/%@/", ncode, nil] autorelease];
    NSData* data = [[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:str]] autorelease];
    
    current = Others;
	chapters = [[NSMutableArray alloc] init];
	periods = [[NSMutableArray alloc] init];
    
    NSXMLParser* parser = [[[NSXMLParser alloc] initWithData:data] autorelease];
    parser.delegate = self;
    return [parser parse];
}

- (id)init {
    chapters = nil;
    periods = nil;
	return self;
}

- (void)dealloc {
    if (chapters != nil) {
        [chapters release];
    }
    if (periods != nil) {
        [periods release];
    }
}

- (void)parser:(NSXMLParser *)parser 
didStartElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qName 
	attributes:(NSDictionary *)attributeDict {
	
	if ([elementName isEqualToString:@"td"]) {
		NSString* class = [attributeDict objectForKey: @"class"];
        //節名のタグのとき
		if ([class isEqualToString: @"period_subtitle"] || [class isEqualToString: @"long_subtitle"]) {
			current = PeriodNameElement;
			buffer = [[NSMutableString alloc] init];
            //シリーズもの・短編の場合は章のタグがないので、ここでダミーを作成する
			if (periods.count == 0) {
				[chapters addObject:@"本編"];
				[periods addObject:[[[NSMutableArray alloc] init] autorelease]];
			}
            //章名のタグのとき
		} else if ([class isEqualToString: @"chapter"]) {
			current = ChapterNameElement;
			buffer = [[NSMutableString alloc] init];
		}
	}
}

- (void)parser:(NSXMLParser *)parser 
 didEndElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qName {
	switch (current) {
		case PeriodNameElement:
			//NSLog(buffer);
			[[periods lastObject] addObject: buffer];
			[buffer release];
			current = Others;
			break;
		case ChapterNameElement:
			//NSLog(buffer);
			[chapters addObject:buffer];
			[periods addObject:[[[NSMutableArray alloc] init] autorelease]];
			[buffer release];
			current = Others;
			break;
		default:
			break;
	}
}

- (void)parser:(NSXMLParser *)parser 
foundCharacters:(NSString *)string {
	if (current == ChapterNameElement || current == PeriodNameElement) {
		[buffer appendString:string];
	}
}

@end
