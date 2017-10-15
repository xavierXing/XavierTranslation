//
//  XavierNetWork.m
//  XavierTranslation
//
//  Created by LeoTai on 2017/10/14.
//  Copyright © 2017年 Xavier. All rights reserved.
//

#import "XavierNetWork.h"
#import "NSString+XavierCategory.h"
#import "SAMKeychain.h"
@implementation XavierNetWork


static XavierNetWork * xavierHandler = nil;
+ (instancetype)sharedInstance
{
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    xavierHandler = [[self alloc] init];
  });
  return xavierHandler;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
  if (!xavierHandler) {
    xavierHandler = [super allocWithZone:zone];
  }
  return xavierHandler;
}

- (id)copyWithZone:(NSZone *)zone
{
  return xavierHandler;
}

//API地址
static NSString * const YDHTTPLink = @"http://openapi.youdao.com/api";
static NSString * const YDHTTPSLink = @"https://openapi.youdao.com/api";

- (void)getValue:(NSString *)string
         success:(void (^)(NSString *))successBlock
          failed:(void (^)(NSString *))failedBlock
{

  NSString * salt = [NSString stringWithFormat:@"%i",arc4random() % 999];
  NSString * sign = [self getSignWithq:string withSalt:salt];
  
  NSURL * URL = [NSURL URLWithString:YDHTTPLink];
  NSMutableURLRequest * REQUEST = [NSMutableURLRequest requestWithURL:URL];
  REQUEST.HTTPMethod = @"POST";
  NSString * args = [NSString stringWithFormat:@"q=%@&from=%@&to=%@&appKey=%@&salt=%@&sign=%@",string,@"auto",@"auto",[self appID],salt,sign];
  REQUEST.HTTPBody = [args dataUsingEncoding:NSUTF8StringEncoding];
  
  NSURLSession * session = [NSURLSession sharedSession];
  NSURLSessionDataTask * sessionDataTask = [session dataTaskWithRequest:REQUEST completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    NSDictionary * result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    NSLog(@"%@",result);
    NSLog(@"%@",response);
    NSLog(@"%@",error);
  }];
  [sessionDataTask resume];
}

- (NSString *)getSignWithq:(NSString *)q
                  withSalt:(NSString *)salt
{
  return [NSString stringWithFormat:@"%@%@%@%@",[self appID],q,salt,[self key]].md5String.uppercaseString;
}

static NSString * appIDAccount = @"appID";
static NSString * keyAccount = @"key";
static NSString * myServiceAccount = @"myService";

- (NSString *)appID
{
  return [SAMKeychain passwordForService:myServiceAccount account:appIDAccount];
}

- (NSString *)key
{
  return [SAMKeychain passwordForService:myServiceAccount account:keyAccount];
}
@end
