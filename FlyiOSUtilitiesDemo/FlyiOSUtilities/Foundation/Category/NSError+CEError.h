//
//  NSError+CEError.h
//  CarEton
//
//  Created by fengly on 16/11/29.
//  Copyright © 2016年 fengly. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ENUM(NSInteger)
{
    CEURLErrorUnknown =                         -1,    // 未知错误
    CEURLErrorCancelled =                       -999,  // 请求关闭
    CEURLErrorBadURL =                          -1000, // 错误的url
    CEURLErrorTimedOut =                        -1001, // 超时
    CEURLErrorUNsupportedURL =                  -1002, // 不支持的url
    CEURLErrorCannotFindHost =                  -1003, // 找不到host
    CEURLErrorCannotConnectToHost =             -1004, // 连接不到host
    CEURLErrorNetworkConnectionLost =           -1005, // 连接丢失
    CEURLErrorDNSLookupFailed =                 -1006, // dns解析失败
    CEURLErrorHTTPTooManyRedirects =            -1007, // 太多的Redirects
    CEURLErrorResourceUnavailable =             -1008, // 无法获取资源
    CEURLErrorNotConnectedToInternet =          -1009, // 连接不到网络
    CEURLErrorRedirectToNonExistentLocation = 	-1010, // 重定向失败
    CEURLErrorBadServerResponse =               -1011, // 错误的数据
    CEURLErrorUserCancelledAuthentication = 	-1012, // 用户取消认证
    CEURLErrorUserAuthenticationRequired =      -1013, // 用户认证要求
    CEURLErrorZeroByteResource =                -1014, // 资源为空
    CEURLErrorCannotDecodeRawData =             -1015, // 无法解码原始数据
    CEURLErrorCannotDecodeContentData =         -1016, // 无法解码内容数据
    CEURLErrorCannotParseResponse =             -1017, // 无法解析Response
    CEURLErrorTokenInvalid =                    -1018  // token失效
    
};

FOUNDATION_EXPORT NSString *const CEURLErrorDomainTokenInvalid;
FOUNDATION_EXPORT NSString *const CEURLErrorDomainUnknownError;
FOUNDATION_EXPORT NSString *const CEURLErrorDomainNetworkError;
FOUNDATION_EXPORT NSString *const CEURLErrorDomainNoMoreData;

FOUNDATION_EXPORT NSString *const CEURLErrorDescriptionKey;
FOUNDATION_EXPORT NSString *const CEURLErrorErrorCodeKey;

FOUNDATION_EXPORT NSString *const CEURLErrorTokenInvalidPrompt;
FOUNDATION_EXPORT NSString *const CEURLErrorNetErrorPrompt;
FOUNDATION_EXPORT NSString *const CEURLErrorRequestFailurePrompt;
FOUNDATION_EXPORT NSString *const CEURLErrorZeroByteResourcePrompt;
@interface NSError (CEError)

@end
