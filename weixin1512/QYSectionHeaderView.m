//
//  QYSectionHeaderView.m
//  01-LOL
//
//  Created by qingyun on 16/3/7.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "QYSectionHeaderView.h"
#import "QYHeroGroup.h"
#import "Masonry.h"
@interface QYSectionHeaderView ()
@property (nonatomic, strong) UIButton *bgButton;
@property (nonatomic, strong) UILabel *numLabel;
@end

@implementation QYSectionHeaderView

+(instancetype)headerViewWithTableView:(UITableView *)tableView{
    static NSString *headerViewIdentifier = @"headerView";
    QYSectionHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerViewIdentifier];
    if (headerView == nil) {
        headerView = [[QYSectionHeaderView alloc] initWithReuseIdentifier:headerViewIdentifier];
    }
    [headerView setNeedsUpdateConstraints];
    return headerView;
}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        //1、添加背景btn
        UIButton *bgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:bgBtn];
        
        //添加背景图片
        UIImage *image = [[UIImage imageNamed:@"buddy_header_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(44, 0, 44, 1) resizingMode:UIImageResizingModeStretch];
        UIImage *highLightImage = [[UIImage imageNamed:@"buddy_header_bg_highlighted"] resizableImageWithCapInsets:UIEdgeInsetsMake(44, 0, 44, 1) resizingMode:UIImageResizingModeStretch];
        [bgBtn setBackgroundImage:image forState:UIControlStateNormal];
        [bgBtn setBackgroundImage:highLightImage forState:UIControlStateHighlighted];
        
        //设置图片
        UIImage *arrow = [UIImage imageNamed:@"buddy_header_arrow"];
        [bgBtn setImage:arrow forState:UIControlStateNormal];
        
        //设置标题字体颜色
        [bgBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        //设置bgBtn的内容显示
        bgBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        //设置bgBtn的内容偏移
        bgBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        //设置bgBtn的标题偏移
        bgBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        
        //设置bgBtn中图片视图的内容模式
        bgBtn.imageView.contentMode = UIViewContentModeCenter;
        bgBtn.imageView.clipsToBounds = NO;
        
        //添加点击事件
        [bgBtn addTarget:self action:@selector(bgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //2、添加右边的label
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        
        //对齐方式
        label.textAlignment = NSTextAlignmentRight;
        
        _bgButton = bgBtn;
        _numLabel = label;
        
        
    }
    return self;
}

////重新布局子视图
//-(void)layoutSubviews{
//    [super layoutSubviews];
//    //设置bgButton的frame
//    _bgButton.frame = self.bounds;
//    //设置numLabel的frame
//    CGFloat labelW = 100;
//    CGFloat labelH = CGRectGetHeight(self.frame);
//    CGFloat labelX = CGRectGetMaxX(self.frame) - labelW - 10;
//    CGFloat labelY = 0;
//    _numLabel.frame = CGRectMake(labelX, labelY, labelW, labelH);
//}

-(void)updateConstraints{
    [_bgButton  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.contentView);
        make.center.equalTo(self.contentView);
    }];
    
    [_numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).with.offset(-10);
        make.centerY.equalTo(self.contentView);
    }];
    [super updateConstraints];
}

//利用setGroup设置btn标题和label文本
-(void)setGroup:(QYHeroGroup *)group{
    _group = group;
    
    //设置bgButton的标题
    [_bgButton setTitle:group.name forState:UIControlStateNormal];
    
    //设置numLabel的文本
    _numLabel.text = [NSString stringWithFormat:@"%ld/%ld",group.online,group.friends.count];
    
    if (_group.isOpen) {
        _bgButton.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    }else{
        _bgButton.imageView.transform = CGAffineTransformIdentity;
    }
}

//点击bgBtn
-(void)bgBtnClick:(UIButton *)sender{
    
    //更改section的isOpen
    _group.isOpen = !_group.isOpen;
    
//    if (_headerViewClick) {
//        _headerViewClick();
//    }
    [self.delegate headerViewClick];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
