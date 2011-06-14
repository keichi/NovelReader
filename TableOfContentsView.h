//
//  TableOfContentsView.h
//  NovelReader
//
//  Created by Keichi TAKAHASHI on 11/06/10.
//  Copyright 2011 familie takahashi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NovelEntry.h"


@interface TableOfContentsView : UIViewController {
	NovelEntry* novelEntry;
    UIActivityIndicatorView* indicator;
}

@property (nonatomic, retain) NovelEntry* novelEntry;

@end
