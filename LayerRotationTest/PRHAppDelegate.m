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
	NSLog(@"--- Ordered in");
	[self logGeometry];
}

- (IBAction)orderOut:(id)sender {
	[self.window removeChildWindow:_borderlessPanel];
	[_borderlessPanel orderOut:sender];
	NSLog(@"--- Ordered out");
	[self logGeometry];
}

- (IBAction) takeAngleInDegreesFrom:(id)sender {
	NSSlider *slider = sender;
	double degrees = 360.0 - slider.doubleValue;
	_circleView.rotationAngleInDegrees = degrees;

	NSLog(@"--- Rotated to %f°", degrees);
	[self logGeometry];
}

- (void) logGeometry {
	NSLog(@"Window frame: %@", NSStringFromRect(_borderlessPanel.frame));
	NSLog(@"Circle view frame: %@", NSStringFromRect(_circleView.frame));
	NSLog(@"Circle view bounds: %@", NSStringFromRect(_circleView.bounds));
	NSLog(@"Circle view frame center rot: %f", _circleView.frameCenterRotation);
	NSLog(@"Circle view layer bounds: %@", NSStringFromRect(_circleView.layer.bounds));
	NSLog(@"Circle view layer pos: %@", NSStringFromPoint(_circleView.layer.position));
	NSLog(@"Circle view layer frame: %@", NSStringFromRect(_circleView.layer.frame));
	NSLog(@"Circle view layer rot Z: %@", [_circleView.layer valueForKeyPath:@"transform.rotation.z"]);
	NSLog(@"Circle view layer rot Y: %@", [_circleView.layer valueForKeyPath:@"transform.rotation.y"]);
}

@end
