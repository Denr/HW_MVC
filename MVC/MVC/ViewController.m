//
//  ViewController.m
//  MVC
//
//  Created by Admin on 11/14/14.
//  Copyright (c) 2014 Dinar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (weak, nonatomic) IBOutlet UISwitch *switched;
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *textField = [[NSUserDefaults standardUserDefaults] objectForKey:@"textField"];
    self.textField.text = textField;
    NSNumber *slider = [[NSUserDefaults standardUserDefaults] objectForKey:@"slider"];
    self.slider.value = slider.floatValue;
    NSNumber *segment = [[NSUserDefaults standardUserDefaults]objectForKey:@"segment"];
    self.segment.selectedSegmentIndex = segment.integerValue;
    NSNumber *switched = [[NSUserDefaults standardUserDefaults] objectForKey:@"switch"];
    [self.switched setOn:switched.boolValue];
    NSData *color = [[NSUserDefaults standardUserDefaults] objectForKey:@"color"];
    self.button.backgroundColor = [NSKeyedUnarchiver unarchiveObjectWithData:color];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)textChanged:(id)sender {
    NSString *textField= self.textField.text;
    [[NSUserDefaults standardUserDefaults] setObject:textField forKey:@"textField"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (IBAction)sliderChanged:(id)sender {
    float sliderValue = self.slider.value;
    [[NSUserDefaults standardUserDefaults] setObject:@(sliderValue) forKey:@"slider"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (IBAction)segmentChanged:(id)sender {
    NSInteger segment= self.segment.selectedSegmentIndex;
    [[NSUserDefaults standardUserDefaults] setObject:@(segment) forKey:@"segment"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (IBAction)switchChanged:(id)sender {
    BOOL swithed = self.switched.isOn;
    [[NSUserDefaults standardUserDefaults] setObject:@(swithed) forKey:@"switch"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(UIColor *)randColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    return color;
}
- (IBAction)ChangeColor:(id)sender {
    UIColor *color = [self randColor];
    self.button.backgroundColor = color;
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:color] forKey:@"color"];
    [[NSUserDefaults standardUserDefaults] synchronize]; // обычно сохранить не получалось поэтому погуглив нашел вот это http://stackoverflow.com/questions/23324723/save-cccolor-to-nsuser-defaults . С ним работает)
}

@end