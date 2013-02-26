//
//  KGNotePad.m
//  KGNotePad
//
//  Created by David Keegan on 2/23/13.
//  Copyright (c) 2013 David Keegan. All rights reserved.
//

#import "KGNotePad.h"

@interface KGNotePad()
@end

@implementation KGNotePad

@synthesize verticalLineColor = _verticalLineColor;
@synthesize horizontalLineColor = _horizontalLineColor;
@synthesize paperBackgroundColor = _paperBackgroundColor;

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

- (void)setFont:(UIFont *)font{
    [super setFont:font];
    [self updateLines];
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    [self updateLines];
}

- (void)updateLines{
//    NSLog(@"%f,%f,%f,%f", self.font.lineHeight, self.font.descender, self.font.ascender, self.font.xHeight);
    CGFloat width = MAX(CGRectGetWidth([[UIScreen mainScreen] bounds]), CGRectGetHeight([[UIScreen mainScreen] bounds]));
    CGSize size = CGSizeMake(width, self.font.lineHeight);
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);

    // TODO: change this to just a standard fill
    UIBezierPath *backgroundPath = [UIBezierPath bezierPathWithRect:(CGRect){CGPointZero, size}];
    [self.paperBackgroundColor setFill];
    [backgroundPath fill];

    CGRect lineRect = CGRectZero;
    lineRect.size = CGSizeMake(size.width, 1);
    //TODO: figure out how to calculate this "8"
    lineRect.origin.y = floor(self.font.descender)+8;
    if(lineRect.origin.y < 0){
        lineRect.origin.y = self.font.lineHeight+lineRect.origin.y;
    }
    NSLog(@"%f", self.font.pointSize);
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

    self.backgroundColor = [UIColor colorWithPatternImage:image];
}

@end
