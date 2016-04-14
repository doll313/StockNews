//
//  SBEmojiModel.m
//  IosDemo
//
//  Created by MengWang on 16/1/25.
//  Copyright © 2016年 YukiWang. All rights reserved.
//

#import "SBEmojiModel.h"

@interface SBEmojiModel()
@property (nonatomic, strong)NSArray *emojiArray;
@end

@implementation SBEmojiModel

- (id)init {
    self = [super init];
    if (self) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"sb_emoji" ofType:@"json"];
        NSData *jsonData = [NSData dataWithContentsOfFile:path options:NSDataReadingMappedIfSafe error:nil];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingAllowFragments
                                                              error:&err];
        _emojiArray = [dic[@"re"] mutableCopy];
    }
    return self;
}

- (NSString *)searchEmojiImageName:(NSString *)emojiName {
    for (NSDictionary *dic in self.emojiArray) {
        NSString *name = [[NSString alloc] initWithFormat:@"[%@]", dic[@"emojimeaning"]];
        if ([name isEqualToString:emojiName]) {
            return dic[@"emojiname"];
        }
    }
    return @"";
}

@end
