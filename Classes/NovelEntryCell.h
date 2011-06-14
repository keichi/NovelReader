//
//  NovelEntryCell.h
//  NovelReader
//
//  Created by Keichi TAKAHASHI on 11/06/08.
//  Copyright 2011 familie takahashi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NovelEntry.h"


@interface NovelEntryCell : UITableViewCell {
	IBOutlet UILabel* titleLabel;
	IBOutlet UILabel* writerLabel;
	IBOutlet UILabel* genreLabel;
	IBOutlet UILabel* storyCountLabel;
	NovelEntry* novel;
}

- (void)setNovel:(NovelEntry*)novel;
- (NovelEntry*)Novel;

@end
