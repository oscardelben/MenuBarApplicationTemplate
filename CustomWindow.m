#import "CustomWindow.h"

@implementation CustomWindow

@synthesize attachPoint;

- (CustomWindow *)initWithView:(NSView *)view
{
    NSRect contentRect = NSZeroRect;
	contentRect.size = [view frame].size;
    	
	if ((self = [super initWithContentRect:contentRect
                                 styleMask:NSBorderlessWindowMask 
                                   backing:NSBackingStoreBuffered 
                                     defer:NO])) {
		
		[[self contentView] addSubview:view];
        
        [self setBackgroundColor:[NSColor darkGrayColor]];
#ifdef kWindowCanFloat
        [self setMovableByWindowBackground:YES];
#endif
        [self setExcludedFromWindowsMenu:YES];
        [self setOpaque:NO];
        [self setHasShadow:YES];
        [self setDelegate:self];
	}
	return self;
}

#pragma mark Util

- (void)setAttachPoint:(NSPoint)point {
#ifdef kWindowCanFloat
    NSPoint origin;
    
    // remember positions
    if ([[NSUserDefaults standardUserDefaults] valueForKey:kUserDefaultsFrameOriginX]) {
        float x = [[[NSUserDefaults standardUserDefaults] valueForKey:kUserDefaultsFrameOriginX] floatValue];
        float y = [[[NSUserDefaults standardUserDefaults] valueForKey:kUserDefaultsFrameOriginY] floatValue];
        
        origin = NSMakePoint(x, y);
    } else
    {
        attachPoint = point;
        
        float windowRightEdge = point.x + ([self frame].size.width / 2);
        float screenRightEdge = [[NSScreen mainScreen] frame].size.width;
        if ((windowRightEdge - screenRightEdge) > 0) {
            point.x -= windowRightEdge - screenRightEdge + 10.0f; // 10.0f of margin
        }
        
        origin = NSZeroPoint;
        origin.x = point.x - ([self frame].size.width / 2);
        origin.y = point.y - [self frame].size.height;
    }
    
    [self setFrameOrigin:origin];

#else
    
    NSPoint origin;
    
    attachPoint = point;
    
    float windowRightEdge = point.x + ([self frame].size.width / 2);
    float screenRightEdge = [[NSScreen mainScreen] frame].size.width;
    if ((windowRightEdge - screenRightEdge) > 0) {
        point.x -= windowRightEdge - screenRightEdge + 10.0f; // 10.0f of margin
    }
    
    origin = NSZeroPoint;
    origin.x = point.x - ([self frame].size.width / 2);
    origin.y = point.y - [self frame].size.height;
    
    [self setFrameOrigin:origin];
#endif
}


// This hides the window when the alpha is 0.0
- (void)setAlphaValue:(CGFloat)windowAlpha 
{
	[super setAlphaValue:windowAlpha];
	
    if (0.0f == windowAlpha)
		[self orderOut:self];
    else
        [self makeKeyAndOrderFront:self];
}

- (void)windowDidResignKey:(NSNotification *)notification 
{
	[[self animator] setAlphaValue:0.0f];
}

- (BOOL)canBecomeKeyWindow {
	return YES;
}

- (void)toggleVisibility 
{
	if (![self isVisible]) 
    {
		[self setAlphaValue:0.0f];
		[[self animator] setAlphaValue:1.0f];
	}
	else {
		[[self animator] setAlphaValue:0.0f];
	}
}

#pragma mark events

#ifdef kWindowCanFloat
- (void)windowDidMove:(NSNotification *)notification {
    float x = [[notification object] frame].origin.x;
    float y = [[notification object] frame].origin.y;
    
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithFloat:x] forKey:kUserDefaultsFrameOriginX];
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithFloat:y] forKey:kUserDefaultsFrameOriginY];
}
#endif

@end
