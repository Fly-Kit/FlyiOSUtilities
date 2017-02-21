//
//  NSError+CEError.m
//  CarEton
//
//  Created by fengly on 16/11/29.
//  Copyright © 2016年 fengly. All rights reserved.
//

#import "NSError+CEError.h"

NSString *const CEURLErrorDomainTokenInvalid        = @"CEURLErrorDomainTokenInvalid";
NSString *const CEURLErrorDomainUnknownError        = @"CEURLErrorDomainUnknownError";
NSString *const CEURLErrorDomainNetworkError        = @"CEURLErrorDomainNetworkError";
NSString *const CEURLErrorDomainNoMoreData          = @"CEURLErrorDomainNoMoreData";

NSString *const CEURLErrorDescriptionKey            = @"CEURLErrorDescriptionKey";
NSString *const CEURLErrorErrorCodeKey              = @"CEURLErrorErrorCodeKey";

NSString *const CEURLErrorTokenInvalidPrompt        = @"TokenInvalid";
NSString *const CEURLErrorNetErrorPrompt            = @"网络异常";
NSString *const CEURLErrorRequestFailurePrompt      = @"请求数据失败";
NSString *const CEURLErrorZeroByteResourcePrompt    = @"没有更多数据";
@implementation NSError (CEError)

@end
