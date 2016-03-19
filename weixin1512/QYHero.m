//
//  QYHero.m
//  01-LOL
//
//  Created by qingyun on 16/3/7.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "QYHero.h"

@implementation QYHero

-(instancetype)initWithDictionary:(NSDictionary *)heroInfo{
    if (self = [super init]) {
        //用kvc的方式直接灌入数据
        [self setValuesForKeysWithDictionary:heroInfo];
    }
    return self;
}

+(instancetype)heroWithDictionary:(NSDictionary *)heroInfo{
    return [[self alloc]initWithDictionary:heroInfo];
}
@end
