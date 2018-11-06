//
//  ThreadSafeViewController.m
//  ThreadKnowledge
//
//  Created by 庭好的 on 2018/10/31.
//  Copyright © 2018年 LYH-1140663172. All rights reserved.
//

#import "ThreadSafeViewController.h"

@interface ThreadSafeViewController ()
/** 售票员01 */
@property (nonatomic, strong) NSThread *thread01;
/** 售票员02 */
@property (nonatomic, strong) NSThread *thread02;
/** 售票员03 */
@property (nonatomic, strong) NSThread *thread03;

/** 票的总数 */
@property (nonatomic, assign) NSInteger ticketCount;

/** 锁对象 */
//@property (nonatomic, strong) NSObject *locker;
@end

@implementation ThreadSafeViewController

/*
 多线程的安全隐患:
 1:资源共享
    1块资源可能会被多个线程共享，也就是多个线程可能会访问同一块资源,
    比如多个线程访问同一个对象、同一个变量、同一个文件,
 2:当多个线程访问同一块资源时，很容易引发数据错乱和数据安全问题
 
 安全隐患解决 – 互斥锁
 互斥锁使用格式
 @synchronized(锁对象) { // 需要锁定的代码  }
 注意：锁定1份代码只用1把锁，用多把锁是无效的

 互斥锁的优缺点
 优点：能有效防止因多线程抢夺资源造成的数据安全问题
 缺点：需要消耗大量的CPU资源
 
 互斥锁的使用前提：多条线程抢夺同一块资源

 相关专业术语：线程同步
 线程同步的意思是：多条线程在同一条线上执行（按顺序地执行任务）
 互斥锁，就是使用了线程同步技术

 
 */

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"线程安全";
    
    //    self.locker = [[NSObject alloc] init];
    
    self.ticketCount = 100;
    
    self.thread01 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket) object:nil];
    self.thread01.name = @"售票员01";
    
    self.thread02 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket) object:nil];
    self.thread02.name = @"售票员02";
    
    self.thread03 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket) object:nil];
    self.thread03.name = @"售票员03";
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.thread01 start];
    [self.thread02 start];
    [self.thread03 start];
}

- (void)saleTicket
{
    while (1) {
        //不推荐使用，比较耗性能
        @synchronized(self) {//必须是同一个对象
            // 先取出总数
            NSInteger count = self.ticketCount;
            if (count > 0) {
                self.ticketCount = count - 1;
                NSLog(@"%@卖了一张票，还剩下%zd张", [NSThread currentThread].name, self.ticketCount);
            } else {
                NSLog(@"票已经卖完了");
                break;
            }
        }
    }
}

- (void)saleTicket1
{
    //一个人把票全部卖完了。
    @synchronized(self) {//必须是同一个对象
        while (1) {
            //不推荐使用，比较耗性能
            // 先取出总数
            NSInteger count = self.ticketCount;
            if (count > 0) {
                self.ticketCount = count - 1;
                NSLog(@"%@卖了一张票，还剩下%zd张", [NSThread currentThread].name, self.ticketCount);
            } else {
                NSLog(@"票已经卖完了");
                break;
            }
        }
    }
}

@end
