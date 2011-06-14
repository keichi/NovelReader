//
//  NovelDetailView.h
//  NovelReader
//
//  Created by Keichi TAKAHASHI on 11/06/08.
//  Copyright 2011 familie takahashi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UITableViewCell.h>
#import "NovelEntry.h"

@interface NovelDetailView : UIViewController {
	NovelEntry* novel;
}

-(IBAction)closeButtonPushed;

@property (nonatomic, retain) NovelEntry* novel;

@end
