//
//  ViewController.m
//  Learn
//
//  Created by mac on 2020/7/10.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RootVc.h"
#import "SingSoundVC.h"

@interface RootVc ()<UITableViewDelegate,UITableViewDataSource>
@property (weak,nonatomic) UITableView *tableView;
@end

@implementation RootVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Demo";
    // 添加tableView
    UITableView *tableView = [[UITableView alloc]init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 60;
    tableView.frame = UIScreen.mainScreen.bounds;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSString *title = @"";
    switch (indexPath.row) {
        case 0:
            title = @"SingSound";
            break;
        case 1:
            title = @"MaskView";
            break;
        default:
            break;
    }
    cell.textLabel.text = title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        SingSoundVC *singVc = [[SingSoundVC alloc] init];
        [self.navigationController pushViewController:singVc animated:YES];
    }
}
@end
