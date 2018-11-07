//
//  MyPerson.m
//  ThreadKnowledge
//
//  Created by 庭好的 on 2018/11/4.
//  Copyright © 2018年 LYH-1140663172. All rights reserved.
//

#import "MyPerson.h"

@interface MyPerson ()<NSCopying>

@end
static MyPerson *_person;//防止外界访问
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

/****-------------------------------****/
//first step,根本上保证你外边调用N次，只返回一个对象
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _person = [super allocWithZone:zone];
    });
    return _person;
}

//second step 根本上保证你外边调用N次，只创建初始化一个对象
+ (instancetype)sharedPerson {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _person = [[self alloc] init];
    });
    return _person;
}

//防止外面copy对象，生成新的对象（保证只有一个对象）
- (id)copyWithZone:(NSZone *)zone {
    return _person;
}


@end
