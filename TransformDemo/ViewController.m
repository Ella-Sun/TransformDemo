//
//  ViewController.m
//  TransformDemo
//
//  Created by IOS-Sun on 16/2/19.
//  Copyright © 2016年 IOS-Sun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UILabel * summerLabel;

@property (nonatomic, strong) UILabel * autumnLabel;

@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated {
    self.summerLabel.transform = CGAffineTransformMakeScale(1, 0.1);
    self.summerLabel.alpha = 0;
    [UIView animateWithDuration:4 animations:^{
        self.summerLabel.transform = CGAffineTransformMakeScale(1, 1);
        self.autumnLabel.transform = CGAffineTransformMakeScale(1, 0.1);
        self.summerLabel.alpha = 1;
        self.autumnLabel.alpha = 0;
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor cyanColor];
    
    self.summerLabel = [self createSimilerLabel];
    self.summerLabel.text = @"summer";
    [self.view addSubview:self.summerLabel];
    
    self.autumnLabel = [self createSimilerLabel];
    self.autumnLabel.text = @"autumn";
    [self.view addSubview:self.autumnLabel];
}

- (UILabel *)createSimilerLabel {
    CGRect frame = CGRectMake(50, 100, 200, 100);
    UILabel * label = [[UILabel alloc] initWithFrame:frame];
    label.font = [UIFont fontWithName:@"Chalkduster" size:40.0];
    label.textColor = [UIColor yellowColor];
    [self.view addSubview:label];
    return label;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
