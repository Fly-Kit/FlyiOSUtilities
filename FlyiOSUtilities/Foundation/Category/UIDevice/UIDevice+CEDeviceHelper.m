//
//  UIDevice+CEDeviceHelper.m
//  CarEton
//
//  Created by fengly on 16/11/24.
//  Copyright © 2016年 fengly. All rights reserved.
//

#import "UIDevice+CEDeviceHelper.h"
#import <dlfcn.h>
#import <mach/port.h>
#import <mach/kern_return.h>
#import "OpenUDID.h"
@implementation UIDevice (CEDeviceHelper)
- (NSString *)AppVersionIdentify{
    NSString *sysVersion = [NSString stringWithFormat:@"%.1f",[[[UIDevice currentDevice] systemVersion] floatValue]];
    sysVersion = [sysVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
    if (sysVersion.length >= 2) {
        sysVersion = [sysVersion substringToIndex:2];
    }
    else if (sysVersion.length == 1){
        sysVersion = [NSString stringWithFormat:@"%@0",sysVersion];
    }
    else if(sysVersion.length < 1){
        sysVersion = @"00";
    }
    
    NSString *version_result = [NSString stringWithFormat:@"2%@",sysVersion];
    
    NSString *version = [self AppVersion];
    if (version.length >= 3) {
        if ([version rangeOfString:@"."].location != NSNotFound) {
            version = [version stringByReplacingOccurrencesOfString:@"." withString:@""];
        }
    }
    
    if (version.length == 2) {
        version = [version stringByAppendingString:@"00"];
    }
    else if (version.length < 2){
        if (version.length == 1) {
            version = [version stringByAppendingString:@"000"];
        }
        else{
            version = @"0000";
        }
    }
    else if (version.length == 3){
        NSMutableString *tmp_str = [NSMutableString stringWithFormat:@"%@",version];
        [tmp_str insertString:@"0" atIndex:2];
    }
    else if (version.length >= 4){
        version = [version substringToIndex:4];
    }
    
    version_result = [NSString stringWithFormat:@"%@%@000000",version_result,version];
    
    return version_result;
}

-(NSString *)OpenUUID{
    return [OpenUDID value];
}
-(NSString *)AppVersion{
    NSDictionary* infoDict =[[NSBundle mainBundle] infoDictionary];
    NSString* versionNum =[infoDict objectForKey:@"CFBundleVersion"];
    NSString*text =[NSString stringWithFormat:@"%@",versionNum];
    return text;
}

//    10002代表iPhone  20002代表安卓
- (NSString *)deviceTypeCode{
    return @"10002";
}

/***
- (NSString *) serialNumber
{
    NSString *serialNumber = nil;
    
    void *IOKit = dlopen("/System/Library/Frameworks/IOKit.framework/IOKit", RTLD_NOW);
    if (IOKit)
    {
        mach_port_t *kIOMasterPortDefault = dlsym(IOKit, "kIOMasterPortDefault");
        CFMutableDictionaryRef (*IOServiceMatching)(const char *name) = dlsym(IOKit, "IOServiceMatching");
        mach_port_t (*IOServiceGetMatchingService)(mach_port_t masterPort, CFDictionaryRef matching) = dlsym(IOKit, "IOServiceGetMatchingService");
        CFTypeRef (*IORegistryEntryCreateCFProperty)(mach_port_t entry, CFStringRef key, CFAllocatorRef allocator, uint32_t options) = dlsym(IOKit, "IORegistryEntryCreateCFProperty");
        kern_return_t (*IOObjectRelease)(mach_port_t object) = dlsym(IOKit, "IOObjectRelease");
        
        if (kIOMasterPortDefault && IOServiceGetMatchingService && IORegistryEntryCreateCFProperty && IOObjectRelease)
        {
            mach_port_t platformExpertDevice = IOServiceGetMatchingService(*kIOMasterPortDefault, IOServiceMatching("IOPlatformExpertDevice"));
            if (platformExpertDevice)
            {
                CFTypeRef platformSerialNumber = IORegistryEntryCreateCFProperty(platformExpertDevice, CFSTR("IOPlatformSerialNumber"), kCFAllocatorDefault, 0);
                if (CFGetTypeID(platformSerialNumber) == CFStringGetTypeID())
                {
                    serialNumber = [NSString stringWithString:(NSString*)platformSerialNumber];
                    CFRelease(platformSerialNumber);
                }
                IOObjectRelease(platformExpertDevice);
            }
        }
        dlclose(IOKit);
    }
    
    return serialNumber;
}
***/
@end
