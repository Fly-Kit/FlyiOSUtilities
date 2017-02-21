//
//  UIView+LoadNib.m
//  xib测试
//
//  Created by fengly on 15/11/2.
//  Copyright © 2015年 fengly. All rights reserved.
//

#import "UIView+LoadNib.h"
#import "FileOwner.h"
@implementation UIView (LoadNib)

+ (id)loadFromNib{
    return [self loadFromNibNamed:NSStringFromClass([self class])];
}

+(id)loadFromNibNamed:(NSString*) nibName {
    
    return [FileOwner viewFromNibNamed:nibName];
    
}
+ (id)loadFromNibNoOwner {
    UIView *result = nil;
    NSArray* elements = [[NSBundle mainBundle] loadNibNamed: NSStringFromClass([self class]) owner: nil options: nil];
    for (id anObject in elements) {
        if ([anObject isKindOfClass:[self class]]) {
            result = anObject;
            break;
        }
    }
    return result;
}
@end
