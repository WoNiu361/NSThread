//
//  NSOperationDependencyViewController.m
//  ThreadKnowledge
//
//  Created by LYH on 2018/11/18.
//  Copyright © 2018年 LYH-1140663172(欢迎光顾我的博客：http://blog.cocoachina.com/473781). All rights reserved.
//

#import "NSOperationDependencyViewController.h"

@interface NSOperationDependencyViewController ()

@end

@implementation NSOperationDependencyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"操作依赖";
    
    /*
     NSOperation之间可以设置依赖来保证执行顺序
     比如一定要让操作A执行完后，才能执行操作B，可以这么写
     [operationB addDependency:operationA]; // 操作B依赖于操作A
     
     可以在不同queue的NSOperation之间创建依赖关系
     
     注意：不能相互依赖
     比如A依赖B，B依赖A
     
     操作的监听
     可以监听一个操作的执行完毕
     - (void (^)(void))completionBlock;
     - (void)setCompletionBlock:(void (^)(void))block;
     */
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"download1----%@", [NSThread  currentThread]);
    }];
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"download2----%@", [NSThread  currentThread]);
    }];
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"download3----%@", [NSThread  currentThread]);
    }];
    NSBlockOperation *op4 = [NSBlockOperation blockOperationWithBlock:^{
        for (NSInteger i = 0; i<3; i++) {
            NSLog(@"download4----%@", [NSThread  currentThread]);
        }
    }];
    NSBlockOperation *op5 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"download5----%@", [NSThread  currentThread]);
    }];
    //监听一个操作的执行完毕
    op5.completionBlock = ^{
        NSLog(@"op5执行完毕---%@", [NSThread currentThread]);
    };
    
    // 设置依赖
    [op3 addDependency:op1];
    [op3 addDependency:op2];
    [op3 addDependency:op4];
    
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
    [queue addOperation:op4];
    [queue addOperation:op5];
    
    //不能相互依赖：比如 A依赖B，B依赖A。
    //可以跨队列依赖
}

@end
