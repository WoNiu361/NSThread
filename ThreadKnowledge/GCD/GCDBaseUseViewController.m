//
//  GCDBaseUseViewController.m
//  ThreadKnowledge
//
//  Created by 庭好的 on 2018/11/2.
//  Copyright © 2018年 LYH-1140663172. All rights reserved.
//

#import "GCDBaseUseViewController.h"

@interface GCDBaseUseViewController ()

@end

@implementation GCDBaseUseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"GCD的基本使用";
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //    [self syncConcurrent];
    //    [self asyncMain];
    [self asyncConcurrent];
}

/**
 * 同步函数 + 主队列： 主线程 + 主队列 比较特殊，不会执行后面的
 */
- (void)syncMain
{
    NSLog(@"syncMain ----- begin");
    
    // 1.获得主队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    // 2.将任务加入队列
    dispatch_sync(queue, ^{
        NSLog(@"1-----%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"2-----%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"3-----%@", [NSThread currentThread]);
    });
    
    NSLog(@"syncMain ----- end");
}

/**
 * 异步函数 + 主队列：只在主线程中执行任务,不会开启新的线程
 */
- (void)asyncMain
{
    // 1.获得主队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    // 2.将任务加入队列
    dispatch_async(queue, ^{
        NSLog(@"1-----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"2-----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"3-----%@", [NSThread currentThread]);
    });
}

/**
 * 同步函数 + 串行队列：不会开启新的线程，在当前线程执行任务。任务是串行的，执行完一个任务，再执行下一个任务
 */
- (void)syncSerial
{
    // 1.创建串行队列
    dispatch_queue_t queue = dispatch_queue_create("com.520it.queue", DISPATCH_QUEUE_SERIAL);
    
    // 2.将任务加入队列
    dispatch_sync(queue, ^{
        NSLog(@"1-----%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"2-----%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"3-----%@", [NSThread currentThread]);
    });
}

/**
 * 异步函数 + 串行队列：会开启新的线程，但是任务是串行的，执行完一个任务，再执行下一个任务
 */
- (void)asyncSerial
{
    // 1.创建串行队列
    dispatch_queue_t queue = dispatch_queue_create("com.520it.queue", DISPATCH_QUEUE_SERIAL);
    //    dispatch_queue_t queue = dispatch_queue_create("com.520it.queue", NULL);
    
    // 2.将任务加入队列
    dispatch_async(queue, ^{
        NSLog(@"1-----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"2-----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"3-----%@", [NSThread currentThread]);
    });
}

/**
 * 同步函数 + 并发队列：不会开启新的线程
 */
- (void)syncConcurrent
{
    // 1.获得全局的并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    // 2.将任务加入队列
    dispatch_sync(queue, ^{
        NSLog(@"1-----%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"2-----%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"3-----%@", [NSThread currentThread]);
    });
    
    NSLog(@"syncConcurrent--------end");
    //同步函数，会立即执行
}

/**
 * 异步函数 + 并发队列：可以同时开启多条线程
 */
- (void)asyncConcurrent
{
    // 1.创建一个并发队列
    // label : 相当于队列的名字
    //    dispatch_queue_t queue = dispatch_queue_create("com.520it.queue", DISPATCH_QUEUE_CONCURRENT);
    
    // 1.获得全局的并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    // 2.将任务加入队列
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i<10; i++) {
            NSLog(@"1-----%@", [NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i<10; i++) {
            NSLog(@"2-----%@", [NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i<10; i++) {
            NSLog(@"3-----%@", [NSThread currentThread]);
        }
    });
    
    //但是那个线程跑得快就不一定了
    
    NSLog(@"asyncConcurrent--------end");
    //异步函数，等会再执行。例如上面的打印，打印完在去执行上面的任务
    //    dispatch_release(queue);
}


@end
