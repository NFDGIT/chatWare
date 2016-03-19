//
//  QYTGModels.h
//  weixin1512
//
//  Created by qingyun on 16/3/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QYTGModel : NSObject
@property (nonatomic, strong) NSString *buycount;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *weburl;

+(instancetype)tgModelWithDictionary:(NSDictionary *)dict;
-(instancetype)initWithDictionary:(NSDictionary *)dict;
@end
