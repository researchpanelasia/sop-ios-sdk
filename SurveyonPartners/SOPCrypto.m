//
//  SOPCrypto.m
//  SurveyonPartners
//
//  Copyright © 2017年 d8aspring. All rights reserved.
//

#import "SOPCrypto.h"
#import <CommonCrypto/CommonCrypto.h>

@interface SOPCrypto()
@end

@implementation SOPCrypto

+ (NSString*) hmacSha256:(NSString*)message key:(NSString*)key {
  NSData* messageData = [message dataUsingEncoding:NSUTF8StringEncoding];
  NSData* keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
  NSMutableData* hash = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
  CCHmac(kCCHmacAlgSHA256, keyData.bytes, keyData.length, messageData.bytes, messageData.length, hash.mutableBytes);
  const unsigned char* buffer = (const unsigned char*)hash.bytes;
  NSMutableString* hashString = [NSMutableString stringWithCapacity:hash.length * 2];

  NSUInteger len = hash.length;
  for(int i=0;i<len;i++){
    [hashString appendString:[NSString stringWithFormat:@"%02x",(unsigned int)buffer[i]]];
  }

  return hashString;
}

@end

