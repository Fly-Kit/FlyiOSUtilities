//
//  NSDictionary+JKJSONString.h
//  JKCategories (https://github.com/shaojiankui/JKCategories)
//
//  Created by Jakey on 15/4/25.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (JKJSONString)
/**
 *  @brief NSDictionary转换成JSON字符串
 *
 *  @return  JSON字符串
 */
-(NSString *)jk_JSONString;


- (NSString *)sortRemoveSpaceWithLowercaseRule:(NSString *)rule; // rule 去空格 小写
- (NSDictionary *)dicWithRemoveSpaceLowercaseRule:(NSString *)rule; // 获取rule中的字典

- (NSString *)sortRemoveSpaceWithRule:(NSString *)rule;
- (NSString *)sortWithRule:(NSString *)rule;
- (NSString *)sortGeturlRemoveSpaceWithRule:(NSString *)rule;
- (NSString *)sortGeturlWithRule:(NSString *)rule;

@end
