//
//  DispatchOnceViewController.m
//  ThreadKnowledge
//
//  Created by 庭好的 on 2018/11/7.
//  Copyright © 2018年 LYH-1140663172. All rights reserved.
//

#import "DispatchOnceViewController.h"
#import "MyPerson.h"
#import "StudyCoding.h"

@interface DispatchOnceViewController ()

@end

@implementation DispatchOnceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"单粒模式";
    
//    NSLog(@"  %p,  %p",[MyPerson sharedPerson],[[MyPerson alloc] init]);
    
//        MyPerson *person1 = [[MyPerson alloc] init];
//        person1.name = @"jack";
//
//        MyPerson *person2 = [[MyPerson alloc] init];
//        MyPerson *person3 = [[MyPerson alloc] init];
//        MyPerson *person4 = [[MyPerson alloc] init];
//
//        NSLog(@"%p %p %p %p", person1, person2, person3, person4);
//        NSLog(@"%@", person3.name);
    
//        NSLog(@"%@ %@", [MyPerson sharedPerson], [MyPerson sharedPerson]);
    
//    NSLog(@"-- %p  %p ",[StudyCoding sharedInstance],[[StudyCoding alloc] init]);
    NSLog(@"  %p  ",[StudyCoding sharedTest]);
    
    /*
     只要搞一个单粒，单例对象永远不死。因为有个强指针指着它，这是个全局变量，到程序结束它才会死。
     */
}



@end
