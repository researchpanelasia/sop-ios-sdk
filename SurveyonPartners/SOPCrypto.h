//
//  SOPCrypto.h
//  SurveyonPartners
//
//  Copyright © 2017年 d8aspring. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SOPCrypto : NSObject
+ (NSString*) hmacSha256:(NSString*)message key:(NSString*)key;
@end
