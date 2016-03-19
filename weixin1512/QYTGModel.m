//
//  QYTGModels.m
//  weixin1512
//
//  Created by qingyun on 16/3/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "QYTGModel.h"

@implementation QYTGModel

+(instancetype)tgModelWithDictionary:(NSDictionary *)dict{
    return [[self alloc]initWithDictionary:dict];
}

-(instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

@end
