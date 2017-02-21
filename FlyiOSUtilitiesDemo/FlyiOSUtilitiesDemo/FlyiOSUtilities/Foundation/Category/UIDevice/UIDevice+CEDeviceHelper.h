//
//  UIDevice+CEDeviceHelper.h
//  CarEton
//
//  Created by fengly on 16/11/24.
//  Copyright © 2016年 fengly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (CEDeviceHelper)
@property(nonatomic, readonly) NSString * OpenUUID;
@property(nonatomic, readonly) NSString * AppVersion;
@property(nonatomic, readonly) NSString * deviceTypeCode;
- (NSString *)AppVersionIdentify;
//- (NSString *) serialNumber;
@end
