//
//  QYHero.h
//  01-LOL
//
//  Created by qingyun on 16/3/7.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface QYHero : NSObject
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *intro;
@property (nonatomic) BOOL vip;

-(instancetype)initWithDictionary:(NSDictionary *)heroInfo;
+(instancetype)heroWithDictionary:(NSDictionary *)heroInfo;
@end
