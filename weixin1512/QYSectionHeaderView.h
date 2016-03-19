//
//  QYSectionHeaderView.h
//  01-LOL
//
//  Created by qingyun on 16/3/7.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QYReloadTableViewDelegate.h"
@class QYHeroGroup;
@interface QYSectionHeaderView : UITableViewHeaderFooterView
@property (nonatomic, strong)QYHeroGroup *group;
@property (nonatomic, assign)id <QYReloadTableViewDelegate> delegate;
@property (nonatomic, strong) void (^headerViewClick) ();
//tableView来指定当前创建的sectionHeaderView用在哪个tableView上
+(instancetype)headerViewWithTableView:(UITableView *)tableView;

@end
