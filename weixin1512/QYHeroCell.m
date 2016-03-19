//
//  QYHeroCell.m
//  01-LOL
//
//  Created by qingyun on 16/3/7.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "QYHeroCell.h"
#import "QYHero.h"
@implementation QYHeroCell

-(void)setHero:(QYHero *)hero{
    //完成setHero方法默认事情
    _hero = hero;
    
    //对cell子视图属性赋值
    self.textLabel.text = hero.name;
    self.detailTextLabel.text = hero.intro;
    self.imageView.image = [UIImage imageNamed:hero.icon];
    self.textLabel.textColor = hero.vip ? [UIColor redColor] : [UIColor blackColor];
}

- (void)awakeFromNib {
    // Initialization code

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
