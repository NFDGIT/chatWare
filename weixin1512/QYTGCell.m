//
//  QYTGCell.m
//  weixin1512
//
//  Created by qingyun on 16/3/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "QYTGCell.h"
#import "Masonry.h"
#import "QYTGModel.h"
@interface QYTGCell ()
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UILabel *buyCount;
@end

@implementation QYTGCell
#pragma mark -创建子视图
-(UIImageView *)iconView{
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc] init];
        _iconView.layer.cornerRadius = 3;
        _iconView.layer.masksToBounds = YES;
    }
    return _iconView;
}

-(UILabel *)title{
    if (_title == nil) {
        _title = [[UILabel alloc] init];
        _title.numberOfLines = 0;
    }
    return _title;
}

-(UILabel *)price{
    if (_price == nil) {
        _price = [[UILabel alloc] init];
    }
    return _price;
}

-(UILabel *)buyCount{
    if (_buyCount == nil) {
        _buyCount = [[UILabel alloc] init];
    }
    return _buyCount;
}

#pragma mark -添加子视图约束
-(void)updateConstraints{
    
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(8);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconView.mas_right).with.offset(10);
        make.right.greaterThanOrEqualTo(self).with.offset(-8);
        make.top.equalTo(self.iconView);
    }];
    
    [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.title);
        make.bottom.equalTo(self.iconView);
    }];
    
    [self.buyCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).with.offset(-8);
        make.bottom.equalTo(self.iconView);
    }];
    
    [super updateConstraints];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.title];
        [self.contentView addSubview:self.price];
        [self.contentView addSubview:self.buyCount];
    }
    [self setNeedsUpdateConstraints];
    return self;
}

-(void)setTgModel:(QYTGModel *)tgModel{
    _tgModel = tgModel;
    
    self.iconView.image = [UIImage imageNamed:tgModel.icon];
    self.title.text = tgModel.title;
    self.price.text = tgModel.price;
    self.buyCount.text = tgModel.buycount;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
