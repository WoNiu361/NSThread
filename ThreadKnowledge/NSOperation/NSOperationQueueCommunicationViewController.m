//
//  NSOperationQueueCommunicationViewController.m
//  ThreadKnowledge
//
//  Created by LYH on 2018/11/18.
//  Copyright © 2018年 LYH-1140663172(欢迎光顾我的博客：http://blog.cocoachina.com/473781). All rights reserved.
//

#import "NSOperationQueueCommunicationViewController.h"

@interface NSOperationQueueCommunicationViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;



@end

@implementation NSOperationQueueCommunicationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"线程间通信";
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event  {
    
//    [self test];
    [self combineImage];
}

- (void)combineImage {
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    __block UIImage *image1 = nil;
    // 下载图片1
    NSBlockOperation *download1 = [NSBlockOperation blockOperationWithBlock:^{
        
        // 图片的网络路径
        NSURL *url = [NSURL URLWithString:@"http://img.pconline.com.cn/images/photoblog/9/9/8/1/9981681/200910/11/1255259355826.jpg"];
        
        // 加载图片
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        // 生成图片
        image1 = [UIImage imageWithData:data];
    }];
    
    
    __block UIImage *image2 = nil;
    // 下载图片2
    NSBlockOperation *download2 = [NSBlockOperation blockOperationWithBlock:^{
        
        // 图片的网络路径
        NSURL *url = [NSURL URLWithString:@"http://pic38.nipic.com/20140228/5571398_215900721128_2.jpg"];
        
        
        // 加载图片
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        // 生成图片
        image2 = [UIImage imageWithData:data];
    }];
    
    
    // 合成图片
    NSBlockOperation *combine = [NSBlockOperation blockOperationWithBlock:^{
        // 开启新的图形上下文
        UIGraphicsBeginImageContext(CGSizeMake(200, 200));
        
        // 绘制图片
        [image1 drawInRect:CGRectMake(0, 0, 100, 100)];
        image1 = nil;
        
        [image2 drawInRect:CGRectMake(100, 0, 100, 100)];
        image2 = nil;
        
        // 取得上下文中的图片
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        
        // 结束上下文
        UIGraphicsEndImageContext();
        
        // 回到主线程
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.imageView.image = image;
        }];
    }];
    [combine addDependency:download1];
    [combine addDependency:download2];
    
    [queue addOperation:download1];
    [queue addOperation:download2];
    [queue addOperation:combine];
}

/**
 * 线程之间的通信
 */
- (void)test {
    [[[NSOperationQueue alloc] init] addOperationWithBlock:^{
        // 图片的网络路径
        NSURL *url = [NSURL URLWithString:@"http://img.pconline.com.cn/images/photoblog/9/9/8/1/9981681/200910/11/1255259355826.jpg"];
        
        // 加载图片
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        // 生成图片
        UIImage *image = [UIImage imageWithData:data];
        
        // 回到主线程
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.imageView.image = image;
        }];
    }];
}

@end
