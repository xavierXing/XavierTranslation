//
//  SourceEditorCommand.m
//  XavierTranslation
//
//  Created by LeoTai on 2017/10/13.
//  Copyright © 2017年 Xavier. All rights reserved.
//

#import "SourceEditorCommand.h"
#import "XavierNetWork.h"
@implementation SourceEditorCommand

- (void)
performCommandWithInvocation:(XCSourceEditorCommandInvocation *)invocation
           completionHandler:
               (void (^)(NSError *_Nullable nilOrError))completionHandler {
  
  XCSourceTextRange * range = [invocation.buffer.selections firstObject];
  NSString * selectedLines = [invocation.buffer.lines objectAtIndex:range.start.line];
  NSString * selection = [selectedLines substringWithRange:NSMakeRange(range.start.column, range.end.column - range.start.column)];
  
  NSLog(@"%@",selectedLines);
  NSLog(@"%@",selection);
  
  [[XavierNetWork sharedInstance] getValue:selection success:^(NSString *result) {
    
  } failed:^(NSString *error) {
    
  }];
  
  completionHandler(nil);
}

@end
