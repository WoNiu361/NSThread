//
//  ViewController.m
//  ThreadKnowledge
//
//  Created by 庭好的 on 2018/10/30.
//  Copyright © 2018年 LYH. All rights reserved.
//

#import "ViewController.h"

#import "NSThreadViewController.h"
#import "ThreadSafeViewController.h"
#import "ThreadCommunicationViewController.h"

#import "GCDBaseUseViewController.h"
#import "GCDCommonUseViewController.h"
#import "DispatchOnceViewController.h"

#import "NSOperationViewController.h"
#import "NSOperationQueueViewController.h"
#import "NSOperationDependencyViewController.h"
#import "NSOperationQueueCommunicationViewController.h"
#import "MorePicturesDownLoadViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray<NSString *> *titleArray;
@property (nonatomic, strong) NSArray<NSString *> *vcNameArray;

/**   GCD标题    */
@property (nonatomic, strong) NSArray<NSString *> *gcdTitleArray;
@property (nonatomic, strong) NSArray<NSString *> *gcdVCArray;

/**   NSOperation标题    */
@property (nonatomic, strong) NSArray<NSString *> *operationTitleArray;
@property (nonatomic, strong) NSArray<NSString *> *operationVCArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"线程知识";
    self.titleArray = [NSArray arrayWithObjects:@"NSThread",@"线程安全",@"线程间通信", nil];
    self.vcNameArray = [NSArray arrayWithObjects:@"NSThreadViewController",@"ThreadSafeViewController",@"ThreadCommunicationViewController", nil];
    
    self.gcdTitleArray = [NSArray arrayWithObjects:@"GCD的基本使用",@"GCD常用函数",@"单粒模式", nil];
    self.gcdVCArray = [NSArray arrayWithObjects:@"GCDBaseUseViewController",@"GCDCommonUseViewController",@"DispatchOnceViewController", nil];
    
    self.operationTitleArray = [NSArray arrayWithObjects:@"NSOperation知识",@"NSOperationQueue知识",@"操作依赖",@"线程间的通信",@"多图片下载", nil];
    self.operationVCArray = [NSArray arrayWithObjects:@"NSOperationViewController",@"NSOperationQueueViewController",@"NSOperationDependencyViewController",@"NSOperationQueueCommunicationViewController",@"MorePicturesDownLoadViewController", nil];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 50;
    tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:tableView];
    
    /*
     欢迎光顾我在CocoaChina上的博客
     http://blog.cocoachina.com/473781
     */
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.titleArray.count;
    } else if (section == 1) {
        return self.gcdTitleArray.count;
    } else {
        return self.operationTitleArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *const cellID = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    if (indexPath.section == 0) {
        cell.textLabel.text = self.titleArray[indexPath.row];
    } else if (indexPath.section == 1) {
         cell.textLabel.text = self.gcdTitleArray[indexPath.row];
    } else {
       cell.textLabel.text = self.operationTitleArray[indexPath.row];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        UIViewController *vc = [[NSClassFromString(self.vcNameArray[indexPath.row]) alloc] init];
        vc.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.section == 1) {
        UIViewController *vc = [[NSClassFromString(self.gcdVCArray[indexPath.row]) alloc] init];
        vc.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        UIViewController *vc = [[NSClassFromString(self.operationVCArray[indexPath.row]) alloc] init];
        vc.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"NSThread知识";
    } else if (section == 1) {
       return @"GCD知识";
    } else {
        return @"NSOperation知识";
    }
}

@end
