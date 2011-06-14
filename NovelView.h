//
//  NovelView.h
//  NovelReader
//
//  Created by Keichi TAKAHASHI on 11/06/10.
//  Copyright 2011 familie takahashi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NovelView : UIViewController {
    IBOutlet UITextView *novelTextView;
    NSString* novelText;
}

@property (nonatomic, retain) NSString* novelText;

@end
