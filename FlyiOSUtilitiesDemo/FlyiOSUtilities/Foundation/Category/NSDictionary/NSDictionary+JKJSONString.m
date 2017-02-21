//
//  NSDictionary+JKJSONString.m
//  JKCategories (https://github.com/shaojiankui/JKCategories)
//
//  Created by Jakey on 15/4/25.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import "NSDictionary+JKJSONString.h"
#import "NSDictionary+JKSafeAccess.h"
@implementation NSDictionary (JKJSONString)
/**
 *  @brief NSDictionary转换成JSON字符串
 *
 *  @return  JSON字符串
 */
-(NSString *)jk_JSONString{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (jsonData == nil) {
#ifdef DEBUG
        NSLog(@"fail to get JSON from dictionary: %@, error: %@", self, error);
#endif
        return nil;
    }
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

- (NSString *)sortRemoveSpaceWithLowercaseRule:(NSString *)rule{
    rule = [[rule stringByReplacingOccurrencesOfString:@" " withString:@""] lowercaseString];
    return [self sortWithRule:rule];
}

- (NSDictionary *)dicWithRemoveSpaceLowercaseRule:(NSString *)rule{
    rule = [[rule stringByReplacingOccurrencesOfString:@" " withString:@""] lowercaseString];
    NSMutableDictionary *muDic_tmp = [[NSMutableDictionary alloc] initWithCapacity:3];
    NSArray *rule_arry = [rule componentsSeparatedByString:@"+"];
    for (NSString *key_string in rule_arry) {
        if ([self objectForKey:key_string]) {
            NSString *value_string = [self jk_stringForKey:key_string];
            [muDic_tmp setObject:value_string forKey:key_string];
        }
    }
    return [muDic_tmp copy];
}

- (NSString *)sortRemoveSpaceWithRule:(NSString *)rule{
    rule = [rule stringByReplacingOccurrencesOfString:@" " withString:@""];
    return [self sortWithRule:rule];
}

- (NSString *)sortWithRule:(NSString *)rule{
    
    NSArray *rule_arry = [rule componentsSeparatedByString:@"+"];
    NSMutableString *dic_str = [[NSMutableString alloc] init];
    for (id obj in rule_arry) {
        NSString *obj_str = (NSString *)obj;
        NSString *value = [NSString stringWithFormat:@"%@",[self objectForKey:obj_str]];
        if (value) {
            [dic_str appendString:value];
        }else{
            NSLog(@"拼串-字典解析失败---key = %@",obj_str);
        }
    }
    return dic_str;
    
}

- (NSString *)sortGeturlRemoveSpaceWithRule:(NSString *)rule{
    rule = [rule stringByReplacingOccurrencesOfString:@" " withString:@""];
    return [self sortGeturlWithRule:rule];
}

- (NSString *)sortGeturlWithRule:(NSString *)rule{
    NSArray *rule_arry = [rule componentsSeparatedByString:@"+"];
    NSMutableString *dic_str = [[NSMutableString alloc] init];
    for (id obj in rule_arry) {
        NSString *obj_str = (NSString *)obj;
        NSString *value = [NSString stringWithFormat:@"/%@",[self objectForKey:obj_str]];
        if (value) {
            [dic_str appendString:value];
        }
    }
    return dic_str;
}

@end
