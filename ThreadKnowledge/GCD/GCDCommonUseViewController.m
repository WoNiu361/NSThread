//
//  GCDCommonUseViewController.m
//  ThreadKnowledge
//
//  Created by 吕颜辉 on 2018/11/4.
//  Copyright © 2018年 LYH-1140663172. All rights reserved.
//

#import "GCDCommonUseViewController.h"
#import "MyPerson.h"

@interface GCDCommonUseViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/** 图片1 */
@property (nonatomic, strong) UIImage *image1;
/** 图片2 */
@property (nonatomic, strong) UIImage *image2;
@end

@implementation GCDCommonUseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"GCD常用函数";
    
    MyPerson *person1 = [[MyPerson alloc] init];
    MyPerson *person2 = [[MyPerson alloc] init];
    
    //    XMGPerson *p1 = [[XMGPerson alloc] init];
    //    NSLog(@"%@", p1.books);
    //
    //    XMGPerson *p2 = [[XMGPerson alloc] init];
    //    NSLog(@"%@", p2.books);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    //    dispatch_async(<#dispatch_queue_t queue#>, <#^(void)block#>);
    //    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //    dispatch_async_f(queue, NULL, download);
    
    [self group];
}

- (void)group
{
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    // 创建一个队列组
    dispatch_group_t group = dispatch_group_create();
    
    // 1.下载图片1
    dispatch_group_async(group, queue, ^{
        // 图片的网络路径
        NSURL *url = [NSURL URLWithString:@"http://img.pconline.com.cn/images/photoblog/9/9/8/1/9981681/200910/11/1255259355826.jpg"];
        
        // 加载图片
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        // 生成图片
        self.image1 = [UIImage imageWithData:data];
    });
    
    // 2.下载图片2
    dispatch_group_async(group, queue, ^{
        // 图片的网络路径
        NSURL *url = [NSURL URLWithString:@"http://pic38.nipic.com/20140228/5571398_215900721128_2.jpg"];
        
        // 加载图片
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        // 生成图片
        self.image2 = [UIImage imageWithData:data];
    });
    
    // 3.将图片1、图片2合成一张新的图片
    dispatch_group_notify(group, queue, ^{
        // 开启新的图形上下文
        UIGraphicsBeginImageContext(CGSizeMake(100, 100));
        
        // 绘制图片
        [self.image1 drawInRect:CGRectMake(0, 0, 50, 100)];
        [self.image2 drawInRect:CGRectMake(50, 0, 50, 100)];
        
        // 取得上下文中的图片
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        
        // 结束上下文
        UIGraphicsEndImageContext();
        
        // 回到主线程显示图片
        dispatch_async(dispatch_get_main_queue(), ^{
            // 4.将新图片显示出来
            self.imageView.image = image;
        });
    });
}

/**
 * 快速迭代
 */
- (void)apply
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    NSString *from = @"/Users/xiaomage/Desktop/From";
    NSString *to = @"/Users/xiaomage/Desktop/To";
    
    NSFileManager *mgr = [NSFileManager defaultManager];
    //获取文件夹里的内容，是个数组
    NSArray *subpaths = [mgr subpathsAtPath:from];
    
    dispatch_apply(subpaths.count, queue, ^(size_t index) {
        NSString *subpath = subpaths[index];
        //stringByAppendingPathComponent：会自动加上/
        NSString *fromFullpath = [from stringByAppendingPathComponent:subpath];
        NSString *toFullpath = [to stringByAppendingPathComponent:subpath];
        // 剪切
        [mgr moveItemAtPath:fromFullpath toPath:toFullpath error:nil];
        
        NSLog(@"%@---%@", [NSThread currentThread], subpath);
    });
}

/**
 * 传统文件剪切
 */
- (void)moveFile
{
    NSString *from = @"/Users/xiaomage/Desktop/From";
    NSString *to = @"/Users/xiaomage/Desktop/To";
    
    NSFileManager *mgr = [NSFileManager defaultManager];
    NSArray *subpaths = [mgr subpathsAtPath:from];
    
    for (NSString *subpath in subpaths) {
        NSString *fromFullpath = [from stringByAppendingPathComponent:subpath];
        NSString *toFullpath = [to stringByAppendingPathComponent:subpath];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // 剪切，一个一个剪切
            [mgr moveItemAtPath:fromFullpath toPath:toFullpath error:nil];
        });
    }
}

- (void)once
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"------run");
        //这里默认是线程安全的
    });
    /*
     是整个程序运行过程中只调用一次，而不是每个对象只调用一次，
     而懒加载是每个对象至调用过一次。
     */
}

/**
 * 延迟执行
 */
- (void)delay
{
    NSLog(@"touchesBegan-----");
    //    [self performSelector:@selector(run) withObject:nil afterDelay:2.0];
    
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        NSLog(@"run-----");
    //    });
    
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(run) userInfo:nil repeats:NO];
}

- (void)run
{
    NSLog(@"run-----");
}

- (void)barrier
{
    dispatch_queue_t queue = dispatch_queue_create("12312312", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        NSLog(@"----1-----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"----2-----%@", [NSThread currentThread]);
    });
    
    dispatch_barrier_async(queue, ^{
        NSLog(@"----barrier-----%@", [NSThread currentThread]);
    });
    //在前面的任务执行结束后它才执行，而且它后面的任务等它执行完成之后才会执行
    //这个queue不能是全局的并发队列。
    
    dispatch_async(queue, ^{
        NSLog(@"----3-----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"----4-----%@", [NSThread currentThread]);
    });
}


@end
