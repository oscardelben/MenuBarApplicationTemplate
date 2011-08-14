//
//  SampleAppAppDelegate.h
//  SampleApp
//
//  Created by Oscar Del Ben on 8/3/11.
//  Copyright 2011 DibiStore. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SampleAppAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *_window;
}

@property (retain) IBOutlet NSWindow *window;

@end
