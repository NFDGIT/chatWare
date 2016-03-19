//
//  QYResultTableViewController.h
//  weixin1512
//
//  Created by qingyun on 16/3/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QYResultTableViewController : UITableViewController<UISearchResultsUpdating>
@property (nonatomic, strong) NSArray *filterArray;
@end
