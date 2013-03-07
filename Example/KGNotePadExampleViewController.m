//
//  KGNotePadExampleViewController.m
//  KGNotePadExample
//
//  Created by David Keegan on 2/25/13.
//  Copyright (c) 2013 David Keegan. All rights reserved.
//

#import "KGNotePadExampleViewController.h"
#import "KGNotePad.h"

@interface KGNotePadExampleViewController()
@property (weak, nonatomic) IBOutlet KGNotePad *notePad;
@property (weak, nonatomic) IBOutlet UISlider *fontSlider;
@property (strong, nonatomic) NSString *fontName;
@end

@implementation KGNotePadExampleViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self randFontAction:nil];
}

- (IBAction)randFontAction:(id)sender{
    NSMutableArray *fontNames = [NSMutableArray array];
    for(NSString *familyName in [UIFont familyNames]){
        for(NSString *fontName in [UIFont fontNamesForFamilyName:familyName]){
            [fontNames addObject:fontName];
        }
    }
    self.fontName = fontNames[arc4random_uniform([fontNames count])];
    self.notePad.font = [UIFont fontWithName:self.fontName size:round([self.fontSlider value])];
    self.notePad.lineOffset = 8;
    NSLog(@"%@", self.fontName);
    NSLog(@"%f, %f, %f, %f, %f", self.notePad.font.pointSize, self.notePad.font.lineHeight, self.notePad.font.descender, self.notePad.font.ascender, self.notePad.font.xHeight);
}

- (IBAction)fontSliderAction:(id)sender{
    self.notePad.font = [UIFont fontWithName:self.fontName size:round([self.fontSlider value])];    
}

@end
