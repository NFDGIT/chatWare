//
//  QYContactsTableViewController.m
//  weixin1512
//
//  Created by qingyun on 16/3/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "QYContactsTableViewController.h"
#import "QYHeroGroup.h"
#import "QYHeroCell.h"
#import "QYSectionHeaderView.h"
@interface QYContactsTableViewController ()<QYReloadTableViewDelegate>
@property (nonatomic, strong) NSArray *heroGroups;
@end

@implementation QYContactsTableViewController
//懒加载heroGroups
-(NSArray *)heroGroups{
    if (_heroGroups == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"hero" ofType:@"plist"];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *groups = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            QYHeroGroup *heroGroup = [QYHeroGroup heroGroupWithDictionary:dict];
            [groups addObject:heroGroup];
        }
        _heroGroups = groups;
    }
    return _heroGroups;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark  -UITableViewDataSource
//组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.heroGroups.count;
}

//行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //取出当前section对应的模型
    QYHeroGroup *group = self.heroGroups[section];
    if (group.isOpen) {
        return group.friends.count;
    }
    return 0;
}

//行内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"heroCell";
    QYHeroCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[QYHeroCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    //取出当前cell所在的section模型
    QYHeroGroup *group = self.heroGroups[indexPath.section];
    //取出当前cell的模型
    QYHero *hero = group.friends[indexPath.row];
    
    cell.hero = hero;
    return cell;
}

#if 0
//设置section头标题
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    QYHeroGroup *group = self.heroGroups[section];
    return group.name;
}
#endif

//section头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    QYSectionHeaderView *headerView = [QYSectionHeaderView headerViewWithTableView:tableView];
    //设置headerView的group属性
    QYHeroGroup *heroGroup = self.heroGroups[section];
    headerView.group = heroGroup;
    headerView.delegate = self;
    //对headerViewClick赋值
    headerView.headerViewClick = ^(){
        [tableView reloadData];
    };
    return headerView;
}

-(void)headerViewClick{
    [self.tableView reloadData];
}



#pragma mark -移动单元格

- (IBAction)editItemClick:(UIBarButtonItem *)sender {
    if ([sender.title isEqualToString:@"编辑"]) {
        sender.title = @"完成";
        [self.tableView setEditing:YES animated:YES];
    }else{
        sender.title = @"编辑";
        [self.tableView setEditing:NO animated:YES];
    }
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    //找移动的单元格所对应的section的数据
    QYHeroGroup *sourceGroup = self.heroGroups[sourceIndexPath.section];
    //取移动的单元格对应的模型
    QYHero *hero = sourceGroup.friends[sourceIndexPath.row];
    //删除移动单元格对应的模型
    [sourceGroup.friends removeObject:hero];
    
    //获取目标的位置所在的section
    QYHeroGroup *destGroup = self.heroGroups[destinationIndexPath.section];
    //在目标位置插入hero
    [destGroup.friends insertObject:hero atIndex:destinationIndexPath.row];
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
