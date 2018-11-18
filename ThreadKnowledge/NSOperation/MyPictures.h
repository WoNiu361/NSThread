//
//  MyPictures.h
//  ThreadKnowledge
//
//  Created by LYH on 2018/11/18.
//  Copyright © 2018年 LYH-1140663172(欢迎光顾我的博客：http://blog.cocoachina.com/473781). All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyPictures : NSObject

/** 图标 */
@property (nonatomic, strong) NSString *icon;
/** 下载量 */
@property (nonatomic, strong) NSString *download;
/** 名字 */
@property (nonatomic, strong) NSString *name;

+ (instancetype)appWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
