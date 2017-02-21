//
//  OnLiveLabel.m
//  HKS_LCT
//
//  Created by luxiaobin on 13-12-27.
//  Copyright (c) 2013年 ZhengQI. All rights reserved.
//

#import "OnLiveLabel.h"

@interface OnLiveLabel ()
@property (weak, nonatomic) id target;
@property (assign, nonatomic) SEL action;
@end

@implementation OnLiveLabel

@synthesize selected_On = _selected_On;

// rgb颜色转换（16进制->10进制）
//#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//带有RGBA的颜色设置
#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

- (id)init
{
    if (self = [super init]) {
        [self commeit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commeit];
    }
    return self;
}

-(void)commeit
{
    self.userInteractionEnabled = YES;
    _selected_On = NO;
    self.font = [UIFont boldSystemFontOfSize:18.f];
    self.textAlignment = NSTextAlignmentCenter;
    self.textColor = [UIColor whiteColor];
    self.clipsToBounds = YES;

    self.layer.borderColor =  RGB(128, 169, 165).CGColor;
    self.layer.borderWidth = 0.f;
    
    self.layer.cornerRadius = 5.f;
}

-(void)selectedLive
{
    _selected_On = YES;
    [self changeBgGray];
    [self changeTextIsWhite];
}

-(void)noSelectedLive
{
    _selected_On = NO;
    [self changeBgWhite];
    [self changeTextIsBlack];
}

-(void)clickTouchesAction
{
    /*
    if ([_target respondsToSelector:_action]) {
        _selected_On = !_selected_On;
        if (_selected_On == YES) {
            [self changeTextIsWhite];
            [self changeBgGray];
        } else {
            [self changeBgWhite];
            [self changeTextIsBlack];
        }
    }
     */
    _selected_On = YES;
    [self.target performSelector:self.action withObject:nil afterDelay:0.0f];
}

-(void)changeTextIsWhite
{
    [self setTextColor:[UIColor whiteColor]];
}

-(void)changeTextIsBlack
{
    [self setTextColor:[UIColor blackColor]];
}

-(void)changeBgGray
{
    self.backgroundColor = UIColorFromHex(0xe83423);
    self.clipsToBounds = YES;
}

-(void)changeBgWhite
{
    self.backgroundColor = UIColorFromHex(0xb4b4b4);
    self.clipsToBounds = YES;

}

- (void)addTarget:( id)target withSelector:(SEL)action
{
    self.target = target;
    self.action = action;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self clickTouchesAction];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
