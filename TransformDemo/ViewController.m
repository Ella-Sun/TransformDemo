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

@property (nonatomic, strong) UIImageView * leaf;

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
                                                         CGAffineTransformMakeScale(1, 0),
                                                         CGAffineTransformTranslate(self.summerLabel.transform, 0, -offset));
    
    self.summerLabel.alpha = 0;
    
    [UIView animateWithDuration:4 animations:^{
        //还原summerlabel的变换状态并形变和偏移autumnlabel
        self.summerLabel.transform = CGAffineTransformIdentity;
        self.autumnLabel.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1, 0.1), CGAffineTransformTranslate(self.autumnLabel.transform, 0, offset));
        self.summerLabel.alpha = 1;
        self.autumnLabel.alpha = 0;
    }];
    
    //1.落叶的移动非常的生硬
    //2.其次，这段代码中的duration传入是没有任何意义的（传入一个固定的动画时长无法体现出在落叶飘下这一过程中的层次步骤）
    /*
    [self moveLeafWithOffset: (CGPoint){ 15, 80 } completion: ^(BOOL finished) {
        [self moveLeafWithOffset: (CGPoint){ 30, 105 } completion: ^(BOOL finished) {
            [self moveLeafWithOffset: (CGPoint){ 40, 110 } completion: ^(BOOL finished) {
                [self moveLeafWithOffset: (CGPoint){ 90, 80 } completion: ^(BOOL finished) {
                    [self moveLeafWithOffset: (CGPoint){ 80, 60 } completion: nil duration: 0.6];
                } duration: 1.2];
            } duration: 1.2];
        } duration: 0.6];
    } duration: 0.4];
    
    [UIView animateWithDuration:4 animations: ^{
        _leaf.transform = CGAffineTransformMakeRotation(M_PI);
    }];
     */
    
    //对于这两个问题，UIView也提供了另一种动画方式来帮助我们解决这两个问题 —— keyframe动画：
    /*
     创建一个关键帧动画
    + (void)animateKeyframesWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(UIViewKeyframeAnimationOptions)options animations:(void (^)(void))animations completion:(void (^ __nullable)(BOOL finished))completion
     用于在动画的代码块中插入关键帧动画信息
     frameStartTime  表示关键帧动画开始的时刻在整个动画中的百分比
     frameDuration  表示这个关键帧动画占用整个动画时长的百分比。
    + (void)addKeyframeWithRelativeStartTime:(double)frameStartTime relativeDuration:(double)frameDuration animations:(void (^)(void))animations
     */
    [UIView animateKeyframesWithDuration: 4 delay: 0 options: UIViewKeyframeAnimationOptionCalculationModeLinear animations: ^{
        __block CGPoint center = _leaf.center;
        [UIView addKeyframeWithRelativeStartTime: 0 relativeDuration: 0.1 animations: ^{
            _leaf.center = (CGPoint){ center.x + 15, center.y + 80 };
        }];
        [UIView addKeyframeWithRelativeStartTime: 0.1 relativeDuration: 0.15 animations: ^{
            _leaf.center = (CGPoint){ center.x + 45, center.y + 185 };
        }];
        [UIView addKeyframeWithRelativeStartTime: 0.25 relativeDuration: 0.3 animations: ^{
            _leaf.center = (CGPoint){ center.x + 90, center.y + 295 };
        }];
        [UIView addKeyframeWithRelativeStartTime: 0.55 relativeDuration: 0.3 animations: ^{
            _leaf.center = (CGPoint){ center.x + 180, center.y + 375 };
        }];
        [UIView addKeyframeWithRelativeStartTime: 0.85 relativeDuration: 0.15 animations: ^{
            _leaf.center = (CGPoint){ center.x + 260, center.y + 435 };
        }];
        [UIView addKeyframeWithRelativeStartTime: 0 relativeDuration: 1 animations: ^{
            _leaf.transform = CGAffineTransformMakeRotation(M_PI);
        }];
    } completion: nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIImage * bgImage = [UIImage imageNamed:@"bg"];
    self.view.layer.contents = (id)bgImage.CGImage;
    
    self.summerLabel = [self createSimilerLabel];
    self.summerLabel.text = @"summer";
    [self.view addSubview:self.summerLabel];
    
    self.autumnLabel = [self createSimilerLabel];
    self.autumnLabel.text = @"autumn";
    [self.view addSubview:self.autumnLabel];
    
    CGRect imageFrame = CGRectMake(50, 100, 30, 25);
    self.leaf = [[UIImageView alloc] initWithFrame:imageFrame];
    self.leaf.image = [UIImage imageNamed:@"yezi.jpg"];
    [self.view addSubview:self.leaf];
}

- (UILabel *)createSimilerLabel {
    CGFloat height = [UIScreen mainScreen].bounds.size.height*.8;
    CGRect frame = CGRectMake(10, height, 200, 40);
    UILabel * label = [[UILabel alloc] initWithFrame:frame];
    label.font = [UIFont fontWithName:@"Chalkduster" size:30.0];
    label.textColor = [UIColor colorWithRed:0.502 green:0.251 blue:0.000 alpha:1.000];
    [self.view addSubview:label];
    return label;
}

/*
- (void)moveLeafWithOffset:(CGPoint)offset completion:(void(^)(bool finished))completion duration:(NSTimeInterval)duration {
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         CGPoint center = _leaf.center;
                         center.x += offset.x;
                         center.y += offset.y;
                         _leaf.center = center;
                     } completion:completion];
}
 */

@end
