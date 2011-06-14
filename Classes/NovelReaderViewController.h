//
//  NovelReaderViewController.h
//  NovelReader
//
//  Created by Keichi TAKAHASHI on 11/06/08.
//  Copyright 2011 familie takahashi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UITableViewCell.h>

@interface NovelReaderViewController : UIViewController {
	NSMutableArray* novelArray;
	NSArray* genreNameArray;
	
	IBOutlet UITableView* novelTableView;
	IBOutlet UISearchBar* searchBar;
	UIActivityIndicatorView* indicator;
}

@end

