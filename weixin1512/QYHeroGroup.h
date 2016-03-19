//
//  QYHeroGroup.h
//  01-LOL
//
//  Created by qingyun on 16/3/7.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QYHeroGroup : NSObject
@property (nonatomic, strong) NSMutableArray *friends;
@property (nonatomic, strong) NSString *name;
@property (nonatomic) NSInteger online;
//打开状态
@property (nonatomic) BOOL isOpen;

-(instancetype)initWithDictionary:(NSDictionary *)dict;
+(instancetype)heroGroupWithDictionary:(NSDictionary *)dict;
@end
