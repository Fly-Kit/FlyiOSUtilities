//
//  LMSProgressHUD.m
//  LMS
//
//  Created by fengly on 16/4/18.
//  Copyright (c) 2016年 fengly. All rights reserved.
//

#import "LMSProgressHUD.h"

@interface LMSProgressHUD ()
@property (strong, nonatomic) UIImageView *susimgView;
@end

@implementation LMSProgressHUD


+ (instancetype)showHUDAddedTo:(UIView *)view animated:(BOOL)animated {
    LMSProgressHUD *hud = [[self alloc] initWithView:view];
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeCustomView;
    [view addSubview:hud];
    [hud showAnimated:animated];
    return hud;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.bezelView.color = [UIColor lightGrayColor];
        [self setupCustomView];
    }
    return self;
}

- (void)showAnimated:(BOOL)animated{
    
    [super showAnimated:animated];
    [self customViewAddAnimation];
}

- (void)hideAnimated:(BOOL)animated{
    [super hideAnimated:animated];
    [self customViewRemoveAnimation];
}

- (void)setupCustomView{
    // Set an image view with a checkmark.
    UIImageView *backView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"LoadingbackView"]];
    self.susimgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wheelloading"]];
    UIImageView *imgLoadingLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading_line"]];
    [backView addSubview:self.susimgView];
    [backView addSubview:imgLoadingLine];
    self.susimgView.frame = CGRectMake(10, -5, 40, 40);
    imgLoadingLine.frame = CGRectMake(0, 33, 60, 10);
    self.susimgView.contentMode = UIViewContentModeScaleAspectFit;
    imgLoadingLine.contentMode = UIViewContentModeScaleAspectFit;
    self.customView = backView;
}


- (void)customViewAddAnimation{
    [self.customView.layer removeAnimationForKey:@"customTransform"];
    CABasicAnimation *animation = [CABasicAnimation
                                   animationWithKeyPath: @"transform"];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.removedOnCompletion = NO;
    animation.toValue = [NSValue valueWithCATransform3D:
                         
                         CATransform3DMakeRotation(M_PI/2, 0.0, 0.0, 1.0) ];
    animation.duration = 0.2;
    animation.cumulative = YES;
    animation.repeatCount = GID_MAX;
    
    [self.susimgView.layer addAnimation:animation forKey:@"customTransform"];
}

- (void)customViewRemoveAnimation{
    [self.susimgView.layer removeAnimationForKey:@"customTransform"];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
