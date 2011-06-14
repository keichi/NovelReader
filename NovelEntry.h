//
//  NovelEntry.h
//  NovelReader
//
//  Created by Keichi TAKAHASHI on 11/06/08.
//  Copyright 2011 familie takahashi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
	ChapterNameElement,
	PeriodNameElement,
	Others,
} CurrentElement;

@interface NovelEntry : NSObject <NSXMLParserDelegate> {
	NSString* title;
	NSString* ncode;
	NSString* writer;
	NSString* story;
	NSString* genre;
	int length;
	int time;
	int global_point;
	int fav_novel_cnt;
	int review_cnt;
	int all_point;
	int all_hyoka_cnt;
	NSString* date;
	int general_all_no;
    
    NSMutableString* buffer;
	//各章が順に格納されている
	NSMutableArray* chapters;
	//各章の節がNSMutableArrayに格納され、それがさらにNSMutableArrayに格納されている
	NSMutableArray* periods;
	CurrentElement current;
}

@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) NSString* ncode;
@property (nonatomic, retain) NSString* writer;
@property (nonatomic, retain) NSString* story;
@property (nonatomic, retain) NSString* genre;
@property (nonatomic, assign) int length;
@property (nonatomic, assign) int time;
@property (nonatomic, assign) int global_point;
@property (nonatomic, assign) int fav_novel_cnt;
@property (nonatomic, assign) int review_cnt;
@property (nonatomic, assign) int all_point;
@property (nonatomic, assign) int all_hyoka_cnt;
@property (nonatomic, retain) NSString* date;
@property (nonatomic, assign) int general_all_no;

@property (nonatomic, retain) NSMutableArray* chapters;
@property (nonatomic, retain) NSMutableArray* periods;

- (BOOL) parseTableOfContents;

@end
