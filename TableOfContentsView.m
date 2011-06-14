//
//  TableOfContentsView.m
//  NovelReader
//
//  Created by Keichi TAKAHASHI on 11/06/10.
//  Copyright 2011 familie takahashi. All rights reserved.
//

#import "TableOfContentsView.h"
#import "NovelView.h"


@implementation TableOfContentsView

@synthesize novelEntry;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
    indicator = [[[UIActivityIndicatorView alloc]
                  initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] autorelease];
	indicator.frame = CGRectMake(0, 0, 50, 50);
	indicator.center = self.view.center;
	[self.view addSubview:indicator];
	[indicator startAnimating];
	
	[self performSelectorInBackground:@selector(searchNovelsWithKeyword:) withObject:nil];
     */
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

//テーブルに含まれるセクションの数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	//NSLog(@"sections: %d", tableOfContents.chapters.count, nil);
	return novelEntry.chapters.count;
}

//セクションに含まれる行の数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	//NSLog(@"periods of section %d: %d", section, [[tableOfContents.periods objectAtIndex:section] count], nil);
	return [[novelEntry.periods objectAtIndex:section] count];
}

//セクションのタイトル
- (NSString *) tableView:(UITableView *) tableView titleForHeaderInSection:(NSInteger) section {
	return [novelEntry.chapters objectAtIndex:section];
}

//行に表示するデータの生成
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {	
	static NSString *CellIdentifier = @"Cell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
	}
	cell.textLabel.text = [[novelEntry.periods objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NovelView* nv = [[NovelView alloc] init];
    NSMutableString* s = [[NSMutableString alloc] initWithFormat:@"http://ncode.syosetu.com/"];
    [s appendString:novelEntry.ncode];
    [s appendString:@"/1/"];
    NSLog(@"dl novel from url: %@", s, nil);
    nv.novelText = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:s]];
    //nv.novelText = [[tableOfContents.periods objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:nv animated:YES];
    [nv release];
}


@end
