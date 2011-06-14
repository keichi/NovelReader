//
//  NovelEntryCell.m
//  NovelReader
//
//  Created by Keichi TAKAHASHI on 11/06/08.
//  Copyright 2011 familie takahashi. All rights reserved.
//

#import "NovelEntryCell.h"


@implementation NovelEntryCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


- (void)dealloc {
    [super dealloc];
}

- (void)setNovel:(NovelEntry*)n {
	novel = n;
	titleLabel.text = novel.title;
	writerLabel.text = novel.writer;
	genreLabel.text = novel.genre;
	storyCountLabel.text = [[NSString alloc] initWithFormat:@"%d話", novel.general_all_no, nil];
}
- (NovelEntry*)Novel {
	return novel;
}

@end
