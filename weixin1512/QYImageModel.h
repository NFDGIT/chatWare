//
//  QYImageModel.h
//  weixin1512
//
//  Created by qingyun on 16/3/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QYImageModel : NSObject
@property (nonatomic, strong) NSString *imagepath;
@property (nonatomic, strong) NSString *weburl;

+(instancetype)imageModelWithDictionary:(NSDictionary *)dict;
-(instancetype)initWithDictionary:(NSDictionary *)dict;
@end
