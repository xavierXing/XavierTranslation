//
//  XavierNetWork.h
//  XavierTranslation
//
//  Created by LeoTai on 2017/10/14.
//  Copyright © 2017年 Xavier. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XavierNetWork : NSObject

+ (XavierNetWork *)sharedInstance;

- (void)getValue:(NSString *)string
         success:(void(^)(NSString * result))successBlock
          failed:(void(^)(NSString * error))failedBlock;

@end
