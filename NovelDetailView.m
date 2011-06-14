//
//  NovelDetailView.m
//  NovelReader
//
//  Created by Keichi TAKAHASHI on 11/06/08.
//  Copyright 2011 familie takahashi. All rights reserved.
//

#import "NovelDetailView.h"
#import "TableOfContentsView.h"
#import "NovelEntry.h"


@implementation NovelDetailView

@synthesize novel;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = self.novel.title;
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

- (void)closeButtonPushed {
	[self dismissModalViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	switch (section) {
		case 0:
			return 7;
			break;
		case 1:
			return 5;
		case 2:
			return 1;
		default:
			return 0;
			break;
	}
}

- (NSString *) tableView:(UITableView *) tableView titleForHeaderInSection:(NSInteger) section {
	switch (section) {
		case 0:
			return @"作品情報";
			break;
		case 1:
			return @"評価";
		case 2:
			return @"本編";
		default:
			return @"";
			break;
	}
	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    static NSString *CellIdentifier = @"Cell";
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
									   reuseIdentifier:CellIdentifier] autorelease];
    }
	
	switch (indexPath.section) {
		case 0:
			switch (indexPath.row) {
				case 0:
					cell.textLabel.text = novel.title;
					cell.detailTextLabel.text = @"タイトル";
					break;
				case 1:
					cell.textLabel.text = novel.writer;
					cell.detailTextLabel.text = @"作者";
					break;
				case 2:
					cell.textLabel.text = novel.genre;
					cell.detailTextLabel.text = @"ジャンル";
					break;
				case 3:
					cell.textLabel.text = [[NSString alloc] initWithFormat:@"%d分", novel.time, nil];
					cell.detailTextLabel.text = @"読了時間";
					break;
				case 4:
					cell.textLabel.text = [[NSString alloc] initWithFormat:@"%d文字", novel.length, nil];
					cell.detailTextLabel.text = @"文字数";
					break;
				case 5:
				{
					cell.textLabel.text = novel.date;
					cell.detailTextLabel.text = @"最終更新";
				}
					break;
				case 6:
					cell.textLabel.text = [[NSString alloc] initWithFormat:@"%d話", novel.general_all_no, nil];
					cell.detailTextLabel.text = @"掲載話数";
					break;
				default:
					break;
			}
			break;
		case 1:
			switch (indexPath.row) {
				case 0:
					cell.textLabel.text = [[NSString alloc] initWithFormat:@"%d点", novel.global_point, nil];
					cell.detailTextLabel.text = @"総合得点";
					break;
				case 1:
					cell.textLabel.text = [[NSString alloc] initWithFormat:@"%d人", novel.fav_novel_cnt, nil];
					cell.detailTextLabel.text = @"お気に入り数";
					break;
				case 2:
					cell.textLabel.text = [[NSString alloc] initWithFormat:@"%d人", novel.review_cnt, nil];
					cell.detailTextLabel.text = @"レビュー数";
					break;
				case 3:
					cell.textLabel.text = [[NSString alloc] initWithFormat:@"%d点", novel.all_point, nil];
					cell.detailTextLabel.text = @"評価点";
					break;
				case 4:
					cell.textLabel.text = [[NSString alloc] initWithFormat:@"%d人", novel.all_hyoka_cnt, nil];
					cell.detailTextLabel.text = @"評価者数";
					break;
				default:
					break;
			}
			break;
		case 2:
			cell.textLabel.text = @"本編を読む";
			cell.detailTextLabel.text = @"";
			break;
		default:
			break;
	}

	
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 2) {
        [novel parseTableOfContents];
		NSLog(@"parse finished.");
		
		TableOfContentsView* tableContentsView = [[TableOfContentsView alloc] init];
		tableContentsView.novelEntry = novel;
		//[self presentModalViewController:tableContentsView animated:YES];
		[self.navigationController pushViewController:tableContentsView animated:YES];
		
		[tableContentsView release];
	}
}

@end
