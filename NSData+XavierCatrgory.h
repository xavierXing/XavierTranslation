//
//  NSData+XavierCatrgory.h
//  XavierTranslation
//
//  Created by LeoTai on 2017/10/14.
//  Copyright © 2017年 Xavier. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (XavierCatrgory)

/**
 计算MD5 大写

 @param string 需要计算MD5的字符串
 @return 返回计算好的MD5值
 */
- (NSString *)getMD5;

@end
