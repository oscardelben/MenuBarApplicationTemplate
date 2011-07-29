#import <Foundation/Foundation.h>
#import "CustomWindow.h"
#import "CustomStatusItem.h"

@interface AppController : NSObject <CustomStatusItemDelegate> {
    CustomWindow *window;
    NSStatusItem *statusItem;
    CustomStatusItem *statusItemView;
    NSView *view;
}

@property (retain) CustomWindow *window;
@property (retain) NSStatusItem *statusItem;
@property (retain) CustomStatusItem *statusItemView;
@property (retain) IBOutlet NSView *view;

- (void)toggleShowWindowFromPoint:(NSPoint)point;

@end
