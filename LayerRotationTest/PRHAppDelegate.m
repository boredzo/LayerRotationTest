//
//  PRHAppDelegate.m
//  LayerRotationTest
//
//  Created by Peter Hosey on 2013-12-24.
//  Copyright (c) 2013 Peter Hosey. All rights reserved.
//

#import "PRHAppDelegate.h"
#import "PRHCircleView.h"

static CGFloat radius = 250.0;

@interface PRHAppDelegate ()

@property (unsafe_unretained) IBOutlet NSWindow *window;

@property (weak) IBOutlet NSBox *horizontalLine;

- (IBAction)orderIn:(id)sender;
- (IBAction)orderOut:(id)sender;

- (IBAction) takeAngleInDegreesFrom:(id)sender;

@end

@implementation PRHAppDelegate
{
	NSPanel *_borderlessPanel;
	PRHCircleView *_circleView;
}

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
}

- (IBAction)orderIn:(id)sender {
	if (_borderlessPanel == nil) {
		NSRect contentViewFrame = { NSZeroPoint, { radius * 2.0, radius * 2.0 }};
		_borderlessPanel = [[NSPanel alloc] initWithContentRect:contentViewFrame
			styleMask:NSBorderlessWindowMask | NSUtilityWindowMask
			backing:NSBackingStoreBuffered
			defer:YES
			screen:self.window.screen];
		_borderlessPanel.backgroundColor = [NSColor clearColor];
		_borderlessPanel.opaque = NO;

		_circleView = [[PRHCircleView alloc] initWithFrame:contentViewFrame];
		_borderlessPanel.contentView = _circleView;
	}

	NSRect frameOfHLine = _horizontalLine.frame;
	NSPoint centerPointWithinWindowContentView = { NSMidX(frameOfHLine), NSMidY(frameOfHLine) };
	NSRect panelFrame = { centerPointWithinWindowContentView, _borderlessPanel.frame.size };
	panelFrame.origin.x -= NSWidth(panelFrame) / 2.0;
	panelFrame.origin.y -= NSHeight(panelFrame) / 2.0;
	panelFrame = [self.window convertRectToScreen:panelFrame];

	[_borderlessPanel setFrame:panelFrame display:NO];
	[self.window addChildWindow:_borderlessPanel ordered:NSWindowAbove];
}

- (IBAction)orderOut:(id)sender {
	[self.window removeChildWindow:_borderlessPanel];
	[_borderlessPanel orderOut:sender];
}

- (IBAction) takeAngleInDegreesFrom:(id)sender {
	NSSlider *slider = sender;
	double degrees = 360.0 - slider.doubleValue;
	_circleView.rotationAngleInDegrees = degrees;
}

@end
