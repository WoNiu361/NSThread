//
//  MyPictures.m
//  ThreadKnowledge
//
//  Created by LYH on 2018/11/18.
//  Copyright © 2018年 LYH-1140663172(欢迎光顾我的博客：http://blog.cocoachina.com/473781). All rights reserved.
//

#import "MyPictures.h"

@implementation MyPictures

+ (instancetype)appWithDict:(NSDictionary *)dict {
    
    MyPictures *pictures = [[self alloc] init];
    [pictures setValuesForKeysWithDictionary:dict];
    return pictures;
}

@end
