//
//  NSOperationViewController.m
//  ThreadKnowledge
//
//  Created by LYH on 2018/11/18.
//  Copyright © 2018年 LYH-1140663172(欢迎光顾我的博客：http://blog.cocoachina.com/473781). All rights reserved.
//

#import "NSOperationViewController.h"

@interface NSOperationViewController ()

@end

@implementation NSOperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"NSOperation知识";
    
    /*
     NSOperation 跟GCD很像，但是 更加面向对象
     
     NSOperation的作用
     配合使用NSOperation和NSOperationQueue也能实现多线程编程
     
     NSOperation和NSOperationQueue实现多线程的具体步骤
     1:先将需要执行的操作封装到一个NSOperation对象中
     2:然后将NSOperation对象添加到NSOperationQueue中
     3:系统会自动将NSOperationQueue中的NSOperation取出来
     4:将取出的NSOperation封装的操作放到一条新线程中执行
     
     NSOperation是个抽象类，并不具备封装操作的能力，必须使用它的子类
     
     使用NSOperation子类的方式有3种
     NSInvocationOperation
     NSBlockOperation
     自定义子类继承NSOperation，实现内部相应的方法
     
     创建NSInvocationOperation对象
     - (id)initWithTarget:(id)target selector:(SEL)sel object:(id)arg;
     
     调用start方法开始执行操作
     - (void)start;
     一旦执行操作，就会调用target的sel方法
     
     注意
     默认情况下，调用了start方法后并不会开一条新线程去执行操作，而是在当前线程同步执行操作
     只有将NSOperation放到一个NSOperationQueue中，才会异步执行操作
     
     创建NSBlockOperation对象
     + (id)blockOperationWithBlock:(void (^)(void))block;
     
     通过addExecutionBlock:方法添加更多的操作
     - (void)addExecutionBlock:(void (^)(void))block;
     
     注意：只要NSBlockOperation封装的操作数 > 1，就会异步执行操作
     
     */
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self blockOperation];
    
}

- (void)blockOperation {
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        // 在主线程
        NSLog(@"下载1------%@", [NSThread currentThread]);
    }];
    
    // 添加额外的任务(在子线程执行)
    [op addExecutionBlock:^{
        NSLog(@"下载2------%@", [NSThread currentThread]);
    }];
    
    [op addExecutionBlock:^{
        NSLog(@"下载3------%@", [NSThread currentThread]);
    }];
    [op addExecutionBlock:^{
        NSLog(@"下载4------%@", [NSThread currentThread]);
    }];
    
    [op start];
    
   // 注意：只要NSBlockOperation封装的操作数 > 1，就会异步执行操作
}

- (void)invocationOperation {
    //这样子写的。默认在主线程
    //你想实现多线程，必须把操作放在队列
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(run) object:nil];
    [op start];
    
    //上面代码和下面代码一样
    //    [self performSelector:@selector(run) withObject:nil];
    
    /*
     注意
     默认情况下，调用了start方法后并不会开一条新线程去执行操作，而是在当前线程同步执行操作
     只有将NSOperation放到一个NSOperationQueue中，才会异步执行操作
     */
}

- (void)run {
    NSLog(@"------%@", [NSThread currentThread]);
}


@end
