//
//  ViewController.m
//  Learn
//
//  Created by mac on 2020/7/10.
//  Copyright © 2020 mac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak,nonatomic) UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加tableView
    UITableView *tableView = [[UITableView alloc]init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.frame = UIScreen.mainScreen.bounds;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.detailTextLabel.text = @"Mask View";
    return cell;
}
@end
