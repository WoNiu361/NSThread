//
//  MyPerson.h
//  ThreadKnowledge
//
//  Created by 庭好的 on 2018/11/4.
//  Copyright © 2018年 LYH-1140663172. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyPerson : NSObject
/** 书本 */
@property (nonatomic, strong) NSArray *books;

/** 名字 */
@property (nonatomic, strong) NSString *name;

+ (instancetype)sharedPerson;
@end
