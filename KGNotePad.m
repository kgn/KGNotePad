//
//  KGNotePad.m
//  KGNotePad
//
//  Created by David Keegan on 2/23/13.
//  Copyright (c) 2013 David Keegan. All rights reserved.
//

#import "KGNotePad.h"
#import <QuartzCore/QuartzCore.h>

@interface KGNotePad()
@property (weak, nonatomic, readwrite) KGNotePadTextView *textView;
@end

@interface KGNotePadTextView()
@property (weak, nonatomic) KGNotePad *parentView;
@end

@implementation KGNotePad

@synthesize verticalLineColor = _verticalLineColor;
@synthesize horizontalLineColor = _horizontalLineColor;
@synthesize paperBackgroundColor = _paperBackgroundColor;

- (id)initWithCoder:(NSCoder *)aDecoder{
    if((self = [super initWithCoder:aDecoder])){
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    if((self = [super initWithFrame:frame])){
        [self setup];
    }
    return self;
}

- (void)setup{
    self.lineOffset = 8;
    KGNotePadTextView *textView = [[KGNotePadTextView alloc] initWithFrame:self.bounds];
    textView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    textView.parentView = self;
    [self addSubview:textView];
    self.textView = textView;
    self.backgroundColor = [UIColor clearColor];
    [self.layer addSublayer:[self tornPaperLayerWithHeight:12]];
    [self.layer addSublayer:[self tornPaperLayerWithHeight:9]];
}

- (void)setVerticalLineColor:(UIColor *)verticalLineColor{
    if(_verticalLineColor != verticalLineColor){
        _verticalLineColor = verticalLineColor;
        [self updateLines];
    }
}

- (UIColor *)verticalLineColor{
    if(_verticalLineColor == nil){
        self.verticalLineColor = [UIColor colorWithRed:0.8 green:0.863 blue:1 alpha:1];
    }
    return _verticalLineColor;
}

- (void)setHorizontalLineColor:(UIColor *)horizontalLineColor{
    if(_horizontalLineColor != horizontalLineColor){
        _horizontalLineColor = horizontalLineColor;
        [self updateLines];
    }
}

- (UIColor *)horizontalLineColor{
    if(_horizontalLineColor == nil){
        self.horizontalLineColor = [UIColor colorWithRed:1 green:0.718 blue:0.718 alpha:1];
    }
    return _horizontalLineColor;
}

- (void)setPaperBackgroundColor:(UIColor *)paperBackgroundColor{
    if(_paperBackgroundColor != paperBackgroundColor){
        _paperBackgroundColor = paperBackgroundColor;
        [self updateLines];
    }
}

- (UIColor *)paperBackgroundColor{
    if(_paperBackgroundColor == nil){
        self.paperBackgroundColor = [UIColor whiteColor];
    }
    return _paperBackgroundColor;
}

- (void)setLineOffset:(CGFloat)lineOffset{
    if(_lineOffset != lineOffset){
        _lineOffset = lineOffset;
        [self updateLines];
    }
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    [self updateLines];
}

- (void)updateLines{
    CGFloat width = MAX(CGRectGetWidth([[UIScreen mainScreen] bounds]), CGRectGetHeight([[UIScreen mainScreen] bounds]));
    CGSize size = CGSizeMake(width, self.textView.font.lineHeight);
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);

    [self.paperBackgroundColor set];
    UIRectFill((CGRect){CGPointZero, size});

    CGRect lineRect = CGRectZero;
    lineRect.size = CGSizeMake(size.width, 1);
    lineRect.origin.y = floor(self.textView.font.descender)+self.lineOffset;
    if(lineRect.origin.y < 0){
        lineRect.origin.y = self.textView.font.lineHeight+lineRect.origin.y;
    }

    UIBezierPath *rectanglePath = [UIBezierPath bezierPathWithRect:lineRect];
    [self.verticalLineColor setFill];
    [rectanglePath fill];

    CGRect redLineRect = CGRectZero;
    redLineRect.size = CGSizeMake(1, size.width);
    redLineRect.origin.x = 1;
    UIBezierPath *rectangle2Path = [UIBezierPath bezierPathWithRect:redLineRect];
    [self.horizontalLineColor setFill];
    [rectangle2Path fill];

    redLineRect.origin.x += 2;
    UIBezierPath *rectangle3Path = [UIBezierPath bezierPathWithRect:redLineRect];
    [self.horizontalLineColor setFill];
    [rectangle3Path fill];

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    self.textView.backgroundColor = [UIColor colorWithPatternImage:image];
}

- (CAShapeLayer *)tornPaperLayerWithHeight:(CGFloat)height{
    CGFloat width = MAX(CGRectGetWidth([[UIScreen mainScreen] bounds]), CGRectGetHeight([[UIScreen mainScreen] bounds]));
    CGFloat overshoot = 4;
    CGFloat maxY = height-overshoot;
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(-overshoot, 0)];
    CGFloat x = -overshoot;
    CGFloat y = arc4random_uniform(maxY);
    [bezierPath addLineToPoint: CGPointMake(-overshoot, y)];
    while(x < width+overshoot){
        y = MAX(maxY-3, arc4random_uniform(maxY));
        x += MAX(4.5, arc4random_uniform(12.5));
        [bezierPath addLineToPoint: CGPointMake(x, y)];
    }
    y = arc4random_uniform(maxY);
    [bezierPath addLineToPoint: CGPointMake(width+overshoot, y)];
    [bezierPath addLineToPoint: CGPointMake(width+overshoot, 0)];
    [bezierPath addLineToPoint: CGPointMake(-overshoot, 0)];
    [bezierPath closePath];

    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.fillColor = [self.paperBackgroundColor CGColor];
    shapeLayer.shadowColor = [[UIColor blackColor] CGColor];
    shapeLayer.shadowOffset = CGSizeMake(0, 0);
    shapeLayer.shadowOpacity = 0.5;
    shapeLayer.shadowRadius = 1.5;
    shapeLayer.shadowPath = [bezierPath CGPath];
    shapeLayer.path = [bezierPath CGPath];
    return shapeLayer;
}

@end

@implementation KGNotePadTextView

- (void)setFont:(UIFont *)font{
    [super setFont:font];
    [self.parentView updateLines];
}

@end
