#import "CustomStatusItem.h"
#import "ContentProvider.h"

@implementation CustomStatusItem

@synthesize delegate;
@synthesize freeMemory;

- (void)drawRect:(NSRect)dirtyRect
{
    // We change the width programmatically
    NSRect destRect = NSZeroRect;
    destRect.size = dirtyRect.size;
    
    NSString *aString = [ContentProvider content];
    
    // We can calculate the width of the menu bar icon here
    float width = [aString sizeWithAttributes:nil].width;
    
    destRect.size = NSMakeSize(width, dirtyRect.size.height);
    
    self.frame = destRect;
    
    // Actual drawing
    
    [aString drawInRect:dirtyRect withAttributes:nil];
}

#pragma mark toggleWindow

- (NSPoint)getAnchorPoint
{	
	NSRect frame = [[self window] frame];
	NSRect screen = [[NSScreen mainScreen] frame];
	NSPoint point = NSMakePoint(NSMidX(frame), screen.size.height - [[NSStatusBar systemStatusBar] thickness]);
    
	return point;
}

- (void)toggleShowWindow
{
    if ([(NSObject *)delegate respondsToSelector:@selector(toggleShowWindowFromPoint:)]) 
    {
        [delegate toggleShowWindowFromPoint:[self getAnchorPoint]];
    }
}

#pragma mark Events

// The icon was clicked, we toggle the window

- (void)mouseDown:(NSEvent *)event {
    [self toggleShowWindow];
}

@end
