//
//  CYTReservePopView.m
//  CYTEasyPass
//
//  Created by bita on 15/9/2.
//  Copyright (c) 2015年 EasyPass. All rights reserved.
//

#import "CYTReservePopView.h"
#import "CEAppDelegate.h"
#import "OnLiveLabel.h"

static NSString *key_phone_Data = @"key_phone_data";

@interface CYTReservePopView()<rankingCollectionViewDeleagte>

@property (nonatomic, strong) UIControl *controlForDismiss;                     //没有按钮的时候，才会使用这个
@property (nonatomic, strong) NSMutableArray *showArray;

//title
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *okButtonTitle;

@property (nonatomic,strong) rankingCollectionView *rankingCollection;
@property (nonatomic,strong) UIPageControl *pageControl;

@end

@implementation CYTReservePopView

- (void)dealloc
{
    NSLog(@"dealloc!");
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (instancetype)initWithPopViewTitle:(NSString *)title message:(NSMutableArray *)message okButtonTitle:(NSString *)okButtonTitle;
{
    if (self = [super init]) {
        
        self.showArray = message;
        self.title = title;
        self.okButtonTitle = okButtonTitle;
        
        [self initTheInterface];
        
        //添加标题
        [self addTitleLable];
        
        //添加中间的框
        [self addCenterView];
        
        //添加按钮
        [self addInformOKCancel];
        
        [self addUIPageControl];
    }
    return self;
}

#define VIEW_X 25.f
#define HEIHGTTIELE 35.f
#define DISTENTCE  10.f

//#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
//#define ALL_APP_WEIHT [[UIScreen mainScreen] bounds].size.width
#define BRect(x,y,w,h) CGRectMake(x, y, w, h)

- (void)addUIPageControl
{
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(DISTENTCE, self.frame.size.height - 50.f - 5.f, self.frame.size.width-2*DISTENTCE, 10.f)];
    //[self.pageControl addTarget:self action:@selector(showPanelAtPageControl) forControlEvents:UIControlEventValueChanged];
    
    NSInteger pageCount = self.showArray.count/4;
    NSInteger modeCount = self.showArray.count % 4;
    if (modeCount != 0 ) {
        pageCount++;
    }
    self.pageControl.numberOfPages = pageCount;
    
    self.pageControl.currentPage = 0;
//    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
//    self.pageControl.pageIndicatorTintColor = [UIColor blueColor];
    [self addSubview:self.pageControl];
}

- (void)pageControl:(NSInteger)pageCount
{
    //NSLog(@"page = %ld",pageCount);

    self.pageControl.currentPage = pageCount;
}

- (void)initTheInterface
{
    self.layer.borderColor = [UIColorFromHex(0xefeeec) CGColor];
    self.layer.borderWidth = 1.0f;
    self.layer.cornerRadius = 5.0f;
    self.clipsToBounds = TRUE;
    
    self.backgroundColor = UIColorFromHex(0xefeeec);
    self.frame = BRect(0.f, 0.f, SCREEN_WIDTH - 30.f, 200.f);
}

- (void)addTitleLable
{
    UILabel *label = [[UILabel alloc] initWithFrame:BRect(VIEW_X, 10.f, self.frame.size.width - 2*VIEW_X, HEIHGTTIELE)];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    
    label.text = self.title;
    label.font = [UIFont boldSystemFontOfSize:20.f];

    [self addSubview:label];
}

- (void)addCenterView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.sectionInset = UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0);
    flowLayout.minimumInteritemSpacing = 5.0f; //行行间距
    flowLayout.minimumLineSpacing = 20.0f;//cell间距
    
    self.rankingCollection = [[rankingCollectionView alloc] initWithFrame:CGRectMake(DISTENTCE, HEIHGTTIELE, self.frame.size.width-2*DISTENTCE, self.frame.size.height - HEIHGTTIELE - 50.f) collectionViewLayout:flowLayout];
    [self addSubview:self.rankingCollection];
    self.rankingCollection.pageDeleagte = self;
    
    //刷新
    [self.rankingCollection freshCollectionViewData:self.showArray];
}

- (void)addInformOKCancel
{
    OnLiveLabel *okInform = [[OnLiveLabel alloc] initWithFrame:BRect(0.f, self.frame.size.height - 40.f, self.frame.size.width, 40.f)];
    okInform.text = self.okButtonTitle;
    okInform.textAlignment = NSTextAlignmentCenter;
    okInform.textColor = UIColorFromHex(0x3682f7);
    okInform.font = [UIFont boldSystemFontOfSize:20.f];
    [okInform addTarget:self withSelector:@selector(okInformClick:)];
    
    [self addSubview:okInform];
    
}

- (void)okInformClick:(id)sender
{
    //NSLog(@"okInformClick");
    [self dismiss];

}

- (void)refreshTheUserInterface
{
    if (nil == _controlForDismiss)
    {
        _controlForDismiss = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
        //162,154,151
        //_controlForDismiss.backgroundColor = [UIColor colorWithRed:105.f/255.f green:105.f/255.f blue:105.f/255.f alpha:.1];
        _controlForDismiss.backgroundColor = [UIColor blackColor];
        [_controlForDismiss addTarget:self action:@selector(touchForDismissSelf:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

- (void)touchForDismissSelf:(id)sender
{
    CEAppDelegate *delegate= (CEAppDelegate *)[UIApplication sharedApplication].delegate;
    
    UIView *viewBg = delegate.window.rootViewController.view;
    
    [UIView animateWithDuration:.2 animations:^{
        self.center = CGPointMake(viewBg.bounds.size.width/2.0f,
                                  viewBg.bounds.size.height/2.0f);
    }];
}

#pragma mark - Animated Mthod
- (void)animatedIn
{
    //self.transform = CGAffineTransformMakeScale(0.1, 0.1);
    __weak typeof(self) weakSelf = self;
    _controlForDismiss.alpha = 0.;

    self.alpha = 0;
    [UIView animateWithDuration:.2 animations:^{
        weakSelf.alpha = 1;
        weakSelf.controlForDismiss.alpha = 0.4;

        //self.transform = CGAffineTransformMakeScale(1, 1);
        
    }];
}

- (void)animatedOut
{
    __weak typeof(self) weakSelf = self;
    self.controlForDismiss.alpha = 0.4;

    [UIView animateWithDuration:.2 animations:^{
        //self.transform = CGAffineTransformMakeScale(0.1, 0.1);
        weakSelf.alpha = 0.0;
        weakSelf.controlForDismiss.alpha = 0.;

    } completion:^(BOOL finished) {
        if (finished) {
            
            if (weakSelf.controlForDismiss)
            {
                [weakSelf.controlForDismiss removeFromSuperview];
            }
            
            [weakSelf removeFromSuperview];
        }
    }];
}

#pragma mark - show or hide self
- (void)show
{
    [self refreshTheUserInterface];
    
    CEAppDelegate *delegate= (CEAppDelegate *)[UIApplication sharedApplication].delegate;
    
    UIView *viewBg = delegate.window.rootViewController.view;
    
    if (self.controlForDismiss)
    {
        [viewBg addSubview:self.controlForDismiss];
    }
    [viewBg addSubview:self];
    
    self.center = CGPointMake(viewBg.bounds.size.width/2.0f,
                              viewBg.bounds.size.height/2.0f);
    
    [self animatedIn];
}

- (void)dismiss
{
    [self animatedOut];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context,204.0/255,203.0/255,201.0/255,1);//画笔线的颜色
    
    //画线圆的上面线条
    CGPoint aTwoPoints[2];
    aTwoPoints[0] = CGPointMake(0.f, 160.f);
    aTwoPoints[1] = CGPointMake(self.bounds.size.width, 160.f);
    
    CGContextAddLines(context, aTwoPoints, 2);
    CGContextDrawPath(context, kCGPathStroke);
}


@end
