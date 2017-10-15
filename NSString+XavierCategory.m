//
//  NSString+XavierCategory.m
//  XavierTranslation
//
//  Created by LeoTai on 2017/10/14.
//  Copyright © 2017年 Xavier. All rights reserved.
//

#import "NSString+XavierCategory.h"
#import "NSData+XavierCatrgory.h"
@implementation NSString (XavierCategory)

- (NSString *)md5String
{
  return [[self dataUsingEncoding:NSUTF8StringEncoding] getMD5];
}

@end
