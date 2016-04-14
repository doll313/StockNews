//
//  SBV3Loader.h
//  SBBarModule
//
//  Created by Thomas on 15/2/27.
//  Copyright (c) 2015年 thomas. All rights reserved.
//

#import <SBModule/SBHttpDataLoader.h>

//股吧v3请求
@interface SBV3Loader : SBHttpDataLoader
//初始化本地数据
- (id)initWithData:(NSData *)data;

@end
