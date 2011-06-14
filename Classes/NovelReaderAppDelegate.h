//
//  NovelReaderAppDelegate.h
//  NovelReader
//
//  Created by Keichi TAKAHASHI on 11/06/08.
//  Copyright 2011 familie takahashi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NovelReaderViewController;

@interface NovelReaderAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    //NovelReaderViewController *viewController;
	UINavigationController* navController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
//@property (nonatomic, retain) IBOutlet NovelReaderViewController *viewController;
@property (nonatomic, retain) IBOutlet UINavigationController *navController;

@end

