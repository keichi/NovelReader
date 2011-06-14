//
//  NovelReaderViewController.m
//  NovelReader
//
//  Created by Keichi TAKAHASHI on 11/06/08.
//  Copyright 2011 familie takahashi. All rights reserved.
//

#import "NovelReaderViewController.h"
#import "SBJsonParser.h"
#import "NovelEntryCell.h"
#import "NovelDetailView.h"
#import "NovelEntry.h"

@implementation NovelReaderViewController

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
	genreNameArray = [[NSArray alloc]
					  initWithObjects: @"不明", @"文学", @"恋愛", @"歴史", @"推理", @"ファンタジー",
					  @"SF", @"ホラー", @"コメディー", @"冒険", @"学園", @"戦記", @"童話", @"詩", @"エッセイ", @"その他", nil];
	
	novelArray = [[NSMutableArray alloc] init];
	self.title = @"小説検索";
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[novelArray release];
	[genreNameArray release];
    [super dealloc];
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section {
	return novelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
	NovelEntryCell *cell = (NovelEntryCell*)[tableView 
													dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        UIViewController *viewController;
        viewController = [[UIViewController alloc]
						  initWithNibName: @"NovelEntryCell" 
						  bundle: nil];
        cell = (NovelEntryCell *)viewController.view;
        [viewController release];
    }
    
	NovelEntry* novel = [novelArray objectAtIndex: indexPath.row];
	cell.Novel = novel;
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
    return cell;
}

-(void) searchNovelsWithKeyword:(NSString*)keyword {
	NSAutoreleasePool *pool;
    pool = [[NSAutoreleasePool alloc] init];
	
	searchBar.userInteractionEnabled = NO;
	
	NSMutableString *url = [@"http://api.syosetu.com/novelapi/api/?out=json&word=" mutableCopy];
	NSLog(@"started download.");
	[url appendString:
	 [searchBar.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
		NSString *jsonString = [[NSString alloc]
							initWithContentsOfURL:[NSURL URLWithString:url]  
							encoding:NSUTF8StringEncoding error:nil];
	NSLog(@"finished download.");
	NSArray* jsonData = [jsonString JSONValue];
	NSLog(@"finished json parse.");
	
	[novelArray removeAllObjects];
	for (int i = 1; i < jsonData.count; i++) {
		NSString* tmp;
		NovelEntry* entry = [[[NovelEntry alloc] init] autorelease];
		NSDictionary* novel = [jsonData objectAtIndex: i];
		
		entry.title = [novel objectForKey:@"title"];
		entry.writer = [novel objectForKey:@"writer"];
		entry.genre = [genreNameArray objectAtIndex:[[novel objectForKey:@"genre"] intValue]];
		entry.story = [novel objectForKey:@"story"];
		entry.time = [[novel objectForKey:@"time"] intValue];
		entry.length = [[novel objectForKey:@"length"] intValue];
		entry.ncode = [novel objectForKey:@"ncode"];
		entry.general_all_no = [[novel objectForKey:@"general_all_no"] intValue];
		

		tmp = [novel objectForKey:@"novelupdated_at"];
		if ((NSNull*)tmp == [NSNull null]) {
			entry.date = @"不明";
		} else {
			NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
			[formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
			NSDate* tmpdate = [formatter dateFromString:[novel objectForKey:@"novelupdated_at"]];
			[formatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
			entry.date = [formatter stringFromDate:tmpdate];
			[formatter release];
		}

		tmp = [novel objectForKey:@"global_point"];
		if ((NSNull*)tmp == [NSNull null]) {
			entry.global_point = 0;
		} else {
			entry.global_point = [tmp intValue];
		}
		tmp = [novel objectForKey:@"fav_novel_cnt"];
		if ((NSNull*)tmp == [NSNull null]) {
			entry.fav_novel_cnt = 0;
		} else {
			entry.fav_novel_cnt = [tmp intValue];
		}
		tmp = [novel objectForKey:@"review_cnt"];
		if ((NSNull*)tmp == [NSNull null]) {
			entry.review_cnt = 0;
		} else {
			entry.review_cnt = [tmp intValue];
		}
		tmp = [novel objectForKey:@"all_point"];
		if ((NSNull*)tmp == [NSNull null]) {
			entry.all_point = 0;
		} else {
			entry.all_point = [tmp intValue];
		}
		tmp = [novel objectForKey:@"all_hyoka_cnt"];
		if ((NSNull*)tmp == [NSNull null]) {
			entry.all_hyoka_cnt = 0;
		} else {
			entry.all_hyoka_cnt = [tmp intValue];
		}
		
		[novelArray addObject:entry];
		//[entry release];
	}
	
	//[jsonData release];
	[jsonString release];
	
	[novelTableView reloadData];
	[indicator stopAnimating];
	
	searchBar.userInteractionEnabled = YES;
	
	[pool drain];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	int index = indexPath.row;
	
	NovelDetailView* detailView = [[NovelDetailView alloc] init];
	detailView.novel = [novelArray objectAtIndex: index];
	
	//[self presentModalViewController:detailView animated:YES];
	[self.navigationController pushViewController:detailView animated:YES];
	[detailView release];
}

- (void)searchBarSearchButtonClicked:(UISearchBar*)search {
	[searchBar resignFirstResponder];
	indicator = [[[UIActivityIndicatorView alloc]
										   initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] autorelease];
	indicator.frame = CGRectMake(0, 0, 50, 50);
	indicator.center = self.view.center;
	[self.view addSubview:indicator];
	[indicator startAnimating];
	
	[self performSelectorInBackground:@selector(searchNovelsWithKeyword:) withObject:searchBar.text];
}

- (void)searchBarCancelButtonClicked:(UISearchBar*)search {
	[searchBar resignFirstResponder];
}

@end
