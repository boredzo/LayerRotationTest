//
//  PRHCircleView.m
//  LayerRotationTest
//
//  Created by Peter Hosey on 2013-12-24.
//  Copyright (c) 2013 Peter Hosey. All rights reserved.
//

#import "PRHCircleView.h"

#import <QuartzCore/QuartzCore.h>

static CGFloat degreesToRadians(CGFloat d);
static CGFloat radiansToDegrees(CGFloat radians);

@implementation PRHCircleView

- (id) initWithFrame:(NSRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		CALayer *rootLayer = [[CALayer alloc] init];
		rootLayer.borderColor = CGColorGetConstantColor(kCGColorWhite);
		rootLayer.borderWidth = 1.0;
		self.layer = rootLayer;
		self.wantsLayer = YES;
		rootLayer.anchorPoint = (NSPoint){ 0.5, 0.5 };

		NSPoint position = (NSPoint){ 250.0, 250.0 };
		CAShapeLayer *outerStrokeLayer = [[CAShapeLayer alloc] init];
		[self configureShapeLayer:outerStrokeLayer position:position withRadius:250.0 offset:0.0];
		[rootLayer addSublayer:outerStrokeLayer];
		CAShapeLayer *innerStrokeLayer = [[CAShapeLayer alloc] init];
		[self configureShapeLayer:innerStrokeLayer position:position withRadius:25.0 offset:175.0];
		[rootLayer addSublayer:innerStrokeLayer];
	}
	return self;
}

- (void) configureShapeLayer:(CAShapeLayer *)shapeLayer position:(NSPoint)position withRadius:(float)radius
	offset:(float)offset {
	shapeLayer.fillColor = CGColorGetConstantColor(kCGColorClear);
	shapeLayer.strokeColor = CGColorGetConstantColor(kCGColorBlack);
	shapeLayer.lineWidth = 1.0;

	CGFloat diameter = radius * 2.0;
	CGRect rect = { NSZeroPoint, { diameter, diameter } };
	CGPathRef path = CGPathCreateWithEllipseInRect(rect, /*transform*/ NULL);
	shapeLayer.path = path;
	CGPathRelease(path);

	rect.origin = CGPointZero;
	shapeLayer.bounds = rect;
	shapeLayer.position = (NSPoint){ position.x, position.y + offset };

	shapeLayer.borderWidth = 1.0;
	shapeLayer.borderColor = CGColorCreateGenericRGB(0.0, 0.0, 1.0, 1.0);
}

- (double) rotationAngleInDegrees {
	return radiansToDegrees([[self.layer valueForKeyPath:@"transform.rotation.z"] doubleValue]);
}
- (void) setRotationAngleInDegrees:(double)rotationAngleInDegrees {
	CGFloat rotationAngleInRadians = degreesToRadians(rotationAngleInDegrees);
	[self.layer setValue:@(rotationAngleInRadians) forKeyPath:@"transform.rotation.z"];
}

@end

static CGFloat degreesToRadians(CGFloat d) {
	CGFloat fractionOfACircle = d / 360.0;
	return (M_PI * 2.0) * fractionOfACircle;
}
static CGFloat radiansToDegrees(CGFloat radians) {
	CGFloat fractionOfACircle = radians / (M_PI * 2.0);
	return 360.0 * fractionOfACircle;
}
