//
//  ThreadCommunicationViewController.m
//  ThreadKnowledge
//
//  Created by 庭好的 on 2018/10/31.
//  Copyright © 2018年 LYH-1140663172. All rights reserved.
//

#import "ThreadCommunicationViewController.h"

@interface ThreadCommunicationViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *showImageView;

@end

@implementation ThreadCommunicationViewController

/*
 什么叫做线程间通信
 在1个进程中，线程往往不是孤立存在的，多个线程之间需要经常进行通信

 线程间通信的体现
 1个线程传递数据给另1个线程
 在1个线程中执行完特定任务后，转到另1个线程继续执行任务

 线程间通信常用方法
 - (void)performSelectorOnMainThread:(SEL)aSelector withObject:(id)arg waitUntilDone:(BOOL)wait;
 - (void)performSelector:(SEL)aSelector onThread:(NSThread *)thr withObject:(id)arg waitUntilDone:(BOOL)wait;

 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"线程间的通信";
    
    // 另外一种线程之间的通信方式
    //    NSPort;
    //    NSMessagePort;
    //    NSMachPort;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //子线程下载图片
    [self performSelectorInBackground:@selector(download3) withObject:nil];
}

- (void)download3
{
    // 图片的网络路径
    NSURL *url = [NSURL URLWithString:@"http://img.pconline.com.cn/images/photoblog/9/9/8/1/9981681/200910/11/1255259355826.jpg"];
    
    // 加载图片 data：文件的二进制数据
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    // 生成图片
    UIImage *image = [UIImage imageWithData:data];
    
    // 回到主线程，显示图片
    [self.showImageView performSelector:@selector(setImage:) onThread:[NSThread mainThread] withObject:image waitUntilDone:NO];
    //    [self.imageView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:NO];
    //    [self performSelectorOnMainThread:@selector(showImage:) withObject:image waitUntilDone:YES];
}

//- (void)showImage:(UIImage *)image
//{
//    self.imageView.image = image;
//}

- (void)download2
{
    // 图片的网络路径
    NSURL *url = [NSURL URLWithString:@"http://img.pconline.com.cn/images/photoblog/9/9/8/1/9981681/200910/11/1255259355826.jpg"];
    
    CFTimeInterval begin = CFAbsoluteTimeGetCurrent();
    // 根据图片的网络路径去下载图片数据,是最浪费时间的
    NSData *data = [NSData dataWithContentsOfURL:url];
    CFTimeInterval end = CFAbsoluteTimeGetCurrent();
    
    NSLog(@"%f", end - begin);
    
    // 显示图片
    self.showImageView.image = [UIImage imageWithData:data];
}

- (void)download
{
    // 图片的网络路径
    NSURL *url = [NSURL URLWithString:@"http://img.pconline.com.cn/images/photoblog/9/9/8/1/9981681/200910/11/1255259355826.jpg"];
    
    NSDate *begin = [NSDate date];
    // 根据图片的网络路径去下载图片数据
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSDate *end = [NSDate date];
    
    NSLog(@"%f", [end timeIntervalSinceDate:begin]);//计算耗时时间
    
    // 显示图片
    self.showImageView.image = [UIImage imageWithData:data];
}

@end
