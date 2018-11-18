//
//  MyOperation.m
//  ThreadKnowledge
//
//  Created by LYH on 2018/11/18.
//  Copyright © 2018年 LYH-1140663172(欢迎光顾我的博客：http://blog.cocoachina.com/473781). All rights reserved.
//

#import "MyOperation.h"

@implementation MyOperation

/**
 * 需要执行的任务
 * 自定义，必须要实现 main方法
 */
- (void)main {
    /*
     执行一段耗时操作
     如果你想自定义NSOperation(继承与NSOperation)，最好要不断地判断和响应，看看外界有没有取消我们（[self.queue cancelAllOperations];）
     */
    for (NSInteger i = 0; i<1000; i++) {
        NSLog(@"download1 -%zd-- %@", i, [NSThread currentThread]);
    }
    if (self.isCancelled) return;
    
    for (NSInteger i = 0; i<1000; i++) {
        NSLog(@"download2 -%zd-- %@", i, [NSThread currentThread]);
    }
    if (self.isCancelled) return;
    
    for (NSInteger i = 0; i<1000; i++) {
        NSLog(@"download3 -%zd-- %@", i, [NSThread currentThread]);
    }
    if (self.isCancelled) return;
}

@end
