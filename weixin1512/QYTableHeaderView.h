//
//  QYTableHeaderView.h
//  weixin1512
//
//  Created by qingyun on 16/3/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface QYTableHeaderView : UIView
@property (nonatomic, strong) NSArray *imagePaths;
@property (nonatomic, strong) void (^gotoWebView)(NSString *webUrl);
+(instancetype)headerView;
-(void)setimageForImageViews;
@end
