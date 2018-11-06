//
//  NSThreadViewController.m
//  ThreadKnowledge
//
//  Created by 庭好的 on 2018/10/30.
//  Copyright © 2018年 LYH-1140663172. All rights reserved.
//

#import "NSThreadViewController.h"
#import "MyThread.h"

@interface NSThreadViewController ()

@end

@implementation NSThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"NSThread";
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self createThread2];
    
}

- (void)createThread3 {
    
    [self performSelectorInBackground:@selector(operation:) withObject:@"my greate china"];
}

- (void)createThread2 {
    NSDictionary *dic = @{
                          @"lyh":@"zym"
                          };
    //创建线程后自动启动线程,线程这样创建，有一定的局限性，不能设置设置一些属性。
    [NSThread detachNewThreadSelector:@selector(operation:) toTarget:self withObject:dic];
}

- (void)createThread1 {
    //NSThread,创建出来的线程就是 子线程，而且你必须手动启动该线程
    // NSThread事件中，一个线程对象就是一个NSThread对象
    MyThread *thread = [[MyThread alloc] initWithTarget:self selector:@selector(operation:) object:@"lyh"];
    thread.name = @"love you forever"; //设置线程的名称
    [thread start];  // 启动线程
    /*
     线程启动时，就开始执行任务，在执行任务的过程中，线程并没有销毁，当任务完成时，线程就会自动销毁，结束生命,不能再次开启任务
     */
}

- (void)operation:(id)object {
    
    for (NSInteger i = 0; i < 30000; i ++) {
        NSLog(@"---operation --  %@---%@",object,[NSThread currentThread]);
        if (i == 20000) {
            [MyThread exit];// 直接退出线程
//            break;
//            return;
        }
    }
}

- (void)run2 {
    NSLog(@"-------");
    //    [NSThread sleepForTimeInterval:2]; // 让线程睡眠2秒（阻塞2秒）
    //    [NSThread sleepUntilDate:[NSDate distantFuture]];
    [NSThread sleepUntilDate:[NSDate dateWithTimeIntervalSinceNow:2]];
    NSLog(@"-------");
}


@end
