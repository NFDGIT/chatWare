//
//  QYHeroGroup.m
//  01-LOL
//
//  Created by qingyun on 16/3/7.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "QYHeroGroup.h"
#import "QYHero.h"
@implementation QYHeroGroup

-(instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        //把friends中的字典转化成QYHero模型
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dict in self.friends) {
            QYHero *hero = [QYHero heroWithDictionary:dict];
            [array addObject:hero];
        }
        self.friends = array;
        //_isOpen = YES;
    }
    return self;
}

+(instancetype)heroGroupWithDictionary:(NSDictionary *)dict{
    return [[self alloc] initWithDictionary:dict];
}
@end
