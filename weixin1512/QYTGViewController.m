//
//  ViewController.m
//  weixin1512
//
//  Created by qingyun on 16/3/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "QYTGViewController.h"
#import "QYTGModel.h"
#import "QYImageModel.h"
#import "QYTableHeaderView.h"
#import "QYWebViewController.h"
#import "QYTGCell.h"
#import "Masonry.h"
#import "QYResultTableViewController.h"
@interface QYTGViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) QYTableHeaderView *headerView;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSMutableArray *tgModels;
@property (nonatomic, strong) NSArray *images;

@end

@implementation QYTGViewController
static NSString *identifier = @"tgcell";
//懒加载团购数据
-(NSMutableArray *)tgModels{
    if (_tgModels == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"tgs" ofType:@"plist"];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *models = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            QYTGModel *model = [QYTGModel tgModelWithDictionary:dict];
            [models addObject:model];
        }
        _tgModels = models;
    }
    return _tgModels;
}

//懒加载轮播图片
-(NSArray *)images{
    if (_images == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"images" ofType:@"plist"];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *models = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            QYImageModel *imageModel = [QYImageModel imageModelWithDictionary:dict];
            [models addObject:imageModel];
        }
        _images = models;
    }
    return _images;
}

//懒加载headerView
-(QYTableHeaderView *)headerView{
    if (_headerView == nil) {
        _headerView = [QYTableHeaderView headerView];
        _headerView.imagePaths = self.images;
        
        __weak QYTGViewController *weakSelf = self;
        _headerView.gotoWebView = ^(NSString *url){
            //跳转webView
            [weakSelf gotoWebView:url];
        };
    }
    return _headerView;
}

-(UISearchController *)searchController{
    if (_searchController == nil) {
        QYResultTableViewController *resultVC = [[QYResultTableViewController alloc] initWithStyle:UITableViewStylePlain];
        resultVC.filterArray = self.tgModels;
        _searchController = [[UISearchController alloc] initWithSearchResultsController:resultVC];
        _searchController.searchResultsUpdater = resultVC;
        _searchController.hidesNavigationBarDuringPresentation = YES;
    }
    return _searchController;
}

- (IBAction)searchItemClick:(UIBarButtonItem *)sender {
    [self presentViewController:self.searchController animated:YES completion:nil];
}
-(void)gotoWebView:(NSString *)url{
    QYWebViewController *webVC = [self.storyboard instantiateViewControllerWithIdentifier:@"webVC"];
    webVC.urlString = url;
    [self.navigationController pushViewController:webVC animated:YES];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.headerView setimageForImageViews];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.tableHeaderView = self.headerView;
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 100;
    //注册单元格
    [_tableView registerClass:[QYTGCell class] forCellReuseIdentifier:identifier];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark  -UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tgModels.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    QYTGCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    QYTGModel *model = self.tgModels[indexPath.row];
    cell.tgModel = model;
    return cell;
}

//设置cell能够编辑
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

//编辑的样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.tgModels removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
