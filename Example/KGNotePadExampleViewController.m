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
@end

@implementation KGNotePadExampleViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self fontSliderAction:nil];
}

- (IBAction)fontSliderAction:(id)sender{
    self.notePad.font = [UIFont systemFontOfSize:[self.fontSlider value]];
}

@end
