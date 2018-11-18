//
//  NSOperationQueueViewController.m
//  ThreadKnowledge
//
//  Created by LYH on 2018/11/18.
//  Copyright © 2018年 LYH-1140663172(欢迎光顾我的博客：http://blog.cocoachina.com/473781). All rights reserved.
//

#import "NSOperationQueueViewController.h"
#import "MyOperation.h"

@interface NSOperationQueueViewController ()
@property (nonatomic, weak) NSOperationQueue *queue;
@end

@implementation NSOperationQueueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"NSOperationQueue用法";
    
    /*
     NSOperationQueue
     
     NSOperationQueue的作用
     NSOperation可以调用start方法来执行任务，但默认是同步执行的
     如果将NSOperation添加到NSOperationQueue（操作队列）中，系统会自动异步执行NSOperation中的操作
     
     添加操作到NSOperationQueue中
     - (void)addOperation:(NSOperation *)op;
     - (void)addOperationWithBlock:(void (^)(void))block;
     
     
     最大并发数
     什么是并发数
     同时执行的任务数
     比如，同时开3个线程执行3个任务，并发数就是3
     
     最大并发数的相关方法
     - (NSInteger)maxConcurrentOperationCount;
     - (void)setMaxConcurrentOperationCount:(NSInteger)cnt;
     
     队列的取消、暂停、恢复
     取消队列的所有操作
     - (void)cancelAllOperations;
     提示：也可以调用NSOperation的- (void)cancel方法取消单个操作
     
     暂停和恢复队列
     - (void)setSuspended:(BOOL)b; // YES代表暂停队列，NO代表恢复队列
     - (BOOL)isSuspended;
     */
    
    
//    [self customOperation];
    [self operationQueueSuspended];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
    //取消所有操作
//    [self.queue cancelAllOperations];
    
    
    if (self.queue.isSuspended) {
        // 恢复队列，继续执行
        self.queue.suspended = false;
    } else {
        // 暂停（挂起）队列，暂停执行
        self.queue.suspended = true;
    }
}

- (void)operationQueueSuspended {
    
    // 创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // 设置最大并发操作数
    queue.maxConcurrentOperationCount = 1; // 就变成了串行队列
    
    // 添加操作
    [queue addOperationWithBlock:^{
        //        NSLog(@"download1 --- %@", [NSThread currentThread]);
        //        [NSThread sleepForTimeInterval:1.0];
        for (NSInteger i = 0; i<5000; i++) {
            NSLog(@"download1 -%zd-- %@", i, [NSThread currentThread]);
            //任务一旦开启，就不会中途self.queue.suspended，直到这个任务结束
        }
    }];
    [queue addOperationWithBlock:^{
        //        NSLog(@"download2 --- %@", [NSThread currentThread]);
        //        [NSThread sleepForTimeInterval:1.0];
        for (NSInteger i = 0; i<3000; i++) {
            NSLog(@"download2 --- %@", [NSThread currentThread]);
        }
    }];
    [queue addOperationWithBlock:^{
        //        NSLog(@"download3 --- %@", [NSThread currentThread]);
        //        [NSThread sleepForTimeInterval:1.0];
        for (NSInteger i = 0; i<1000; i++) {
            NSLog(@"download3 --- %@", [NSThread currentThread]);
        }
    }];
    
    self.queue = queue;
}

- (void)customOperation {
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:[[MyOperation alloc] init]];
    self.queue = queue;
}

- (void)operationQueue3 {
    // 创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // 设置最大并发操作数 maxConcurrentOperationCount默认是-1
    queue.maxConcurrentOperationCount = 4;
    //    queue.maxConcurrentOperationCount = 1; // 就变成了串行队列
    //线程数量不用我们认为控制，系统会自动为我们安排好。
    
    // 添加操作
    [queue addOperationWithBlock:^{
        NSLog(@"download1 --- %@", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:0.01];
    }];
    [queue addOperationWithBlock:^{
        NSLog(@"download2 --- %@", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:0.01];
    }];
    [queue addOperationWithBlock:^{
        NSLog(@"download3 --- %@", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:0.01];
    }];
    [queue addOperationWithBlock:^{
        NSLog(@"download4 --- %@", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:0.01];
    }];
    [queue addOperationWithBlock:^{
        NSLog(@"download5 --- %@", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:0.01];
    }];
    [queue addOperationWithBlock:^{
        NSLog(@"download6 --- %@", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:0.01];
    }];
}

- (void)operationQueue2 {
    // 创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // 创建操作
    //    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
    //        NSLog(@"download1 --- %@", [NSThread currentThread]);
    //    }];
    
    // 添加操作到队列中
    //    [queue addOperation:op1];
    [queue addOperationWithBlock:^{
        NSLog(@"download1 --- %@", [NSThread currentThread]);
    }];
    [queue addOperationWithBlock:^{
        NSLog(@"download2 --- %@", [NSThread currentThread]);
    }];
}

- (void)operationQueue1 {
    // 创建队列，非主队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // 创建操作（任务）
    // 创建NSInvocationOperation
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(download1) object:nil];
    NSInvocationOperation *op2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(download2) object:nil];
    
    // 创建NSBlockOperation
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"download3 --- %@", [NSThread currentThread]);
    }];
    
    [op3 addExecutionBlock:^{
        NSLog(@"download4 --- %@", [NSThread currentThread]);
    }];
    [op3 addExecutionBlock:^{
        NSLog(@"download5 --- %@", [NSThread currentThread]);
    }];
    
    
    NSBlockOperation *op4 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"download6 --- %@", [NSThread currentThread]);
    }];
    
    // 创建XMGOperation
    MyOperation *op5 = [[MyOperation alloc] init];
    
    // 添加任务到队列中，会自动开线程，
    [queue addOperation:op1]; // [op1 start]
    [queue addOperation:op2]; // [op2 start]
    [queue addOperation:op3]; // [op3 start]
    [queue addOperation:op4]; // [op4 start]
    [queue addOperation:op5]; // [op5 start]
    
    /*
     NSOperationQueue的队列类型
     1.主队列： [NSOperationQueue mainQueue];
     2.其他队列（串行，并发）：[[NSOperationQueue alloc] init];
     
     ## GCD的队列类型
     - 并发队列
     - 自己创建的
     - 全局
     - 串行队列
     - 主队列
     - 自己创建的
     
     ## NSOperationQueue的队列类型
     - 主队列
     - [NSOperationQueue mainQueue]
     - 凡是添加到主队列中的任务（NSOperation），都会放到主线程中执行
     - 非主队列（其他队列）
     - [[NSOperationQueue alloc] init]
     - 同时包含了：串行、并发功能
     - 添加到这种队列中的任务（NSOperation），就会自动放到子线程中执行
     
     */
}

- (void)download1 {
    NSLog(@"download1 --- %@", [NSThread currentThread]);
}

- (void)download2 {
    NSLog(@"download2 --- %@", [NSThread currentThread]);
}

@end
