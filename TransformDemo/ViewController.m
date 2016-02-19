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

    /* 
     //形变
    self.summerLabel.transform = CGAffineTransformMakeScale(1, 0.1);
    self.summerLabel.alpha = 0;
    [UIView animateWithDuration:4 animations:^{
        self.summerLabel.transform = CGAffineTransformMakeScale(1, 1);
        self.autumnLabel.transform = CGAffineTransformMakeScale(1, 0.1);
        self.summerLabel.alpha = 1;
        self.autumnLabel.alpha = 0;
    }];
     */
    
    //初始化动画开始前label的位置
    CGFloat offset = self.summerLabel.frame.size.height * .5;
    
    self.summerLabel.transform = CGAffineTransformConcat(
                                                         CGAffineTransformMakeScale(1, 0.1),
                                                         CGAffineTransformTranslate(self.summerLabel.transform, 0, -offset));
    
    self.summerLabel.alpha = 0;
    
    [UIView animateWithDuration:4 animations:^{
        //还原summerlabel的变换状态并形变和偏移autumnlabel
        self.summerLabel.transform = CGAffineTransformIdentity;
        self.autumnLabel.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1, 0.1), CGAffineTransformTranslate(self.autumnLabel.transform, 0, offset));
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
    CGRect frame = CGRectMake(50, 100, 100, 50);
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
