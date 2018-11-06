//
//  MyPerson.m
//  ThreadKnowledge
//
//  Created by 吕颜辉 on 2018/11/4.
//  Copyright © 2018年 LYH-1140663172. All rights reserved.
//

#import "MyPerson.h"

@implementation MyPerson

- (NSArray *)books
{
    if (_books == nil) {
        _books = @[@"1分钟突破iOS开发", @"5分钟突破iOS开发"];
    }
    
    //    static dispatch_once_t onceToken;
    //    dispatch_once(&onceToken, ^{
    //        _books = @[@"1分钟突破iOS开发", @"5分钟突破iOS开发"];
    //    });
    /*
    dispatch_once 是整个程序运行过程中只调用一次，而不是每个对象只调用一次，
     而懒加载是每个对象至调用过一次。
     */
    
    return _books;
}

@end
