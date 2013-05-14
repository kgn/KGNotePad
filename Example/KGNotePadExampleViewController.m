//
//  KGNotePadExampleViewController.m
//  KGNotePadExample
//
//  Created by David Keegan on 2/25/13.
//  Copyright (c) 2013 David Keegan. All rights reserved.
//

#import "KGNotePadExampleViewController.h"

@interface KGNotePadExampleViewController()
@property (weak, nonatomic) IBOutlet KGNotePad *notePad;
@property (weak, nonatomic) IBOutlet UISlider *fontSlider;
@property (strong, nonatomic) NSString *fontName;
@end

@implementation KGNotePadExampleViewController


#pragma mark - KGNotePad Delegates
-(void)KGNotePadKeyboardUp{
  // set this value according the device you are using and its orientation:
  // iPhone
  //  Landscape: 162
  //  Portrait: 216
  // iPad
  //  Landscape: 308
  //  Portrait: 264
  
  float keyboardHeight = 216+44;
  // i had to add +44 due to the navigation bar on top
  
  // on keyboard up resize the notepad view in order to have the right feedback when you tap enter and reach the end of the visible area
  self.notePad.frame = CGRectMake(self.notePad.frame.origin.x, self.notePad.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height-keyboardHeight);


  NSLog(@"%@",self.notePad);
}

-(void)KGNotePadKeyboardDown{
  // on keyboard down restore the original size of the notepad
  self.notePad.frame = self.view.frame;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    NSString *textFile = [[NSBundle mainBundle] pathForResource:@"text" ofType:@"txt"];
  
  // set the delegate
  self.notePad.delegate = self;
  
    self.notePad.textView.text = [NSString stringWithContentsOfFile:textFile encoding:NSUTF8StringEncoding error:nil];
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
    self.notePad.textView.font = [UIFont fontWithName:self.fontName size:round([self.fontSlider value])];
    NSLog(@"%@", self.fontName);
//    NSLog(@"%f, %f, %f, %f, %f", self.notePad.font.pointSize, self.notePad.font.lineHeight, self.notePad.font.descender, self.notePad.font.ascender, self.notePad.font.xHeight);
}

- (IBAction)fontSliderAction:(id)sender{
    self.notePad.textView.font = [UIFont fontWithName:self.fontName size:round([self.fontSlider value])];
}

@end
