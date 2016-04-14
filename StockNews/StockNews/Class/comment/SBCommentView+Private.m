//
//  SBCommentView+Private.m
//  IosDemo
//
//  Created by MengWang on 16/1/26.
//  Copyright © 2016年 YukiWang. All rights reserved.
//

#import "SBCommentView+Private.h"
#import <SBModule/NSString+SBMODULE.h>
#import <SBBusiness/SBJSONNODEV3.h>

@implementation SBCommentView(Private)

// 计算高度
- (void)calculateHeight:(DataItemResult *)result {
    for (DataItemDetail *detail in result.dataList) {
        NSMutableAttributedString *attributedText = [self string2AttrString:[detail getString:JNV3_REPLY_TEXT]];
        [detail setATTString:attributedText forKey:@"attr"];
        
        NSMutableAttributedString *attributedReplyText = [self string2AttrString:[detail getString:JNV3_SOURCE_REPLY_TEXT]];
        [detail setATTString:attributedReplyText forKey:@"replyattr"];
    }
}

// string转换成NSMutableAttributedString
- (NSMutableAttributedString *)string2AttrString:(NSString *)string {
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    style.lineSpacing = 0;
    style.paragraphSpacing = 0;
    style.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *atts = @{NSFontAttributeName : [UIFont systemFontOfSize:15], NSForegroundColorAttributeName : [UIColor redColor], NSParagraphStyleAttributeName : style,};
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:[string html2text] attributes:atts];
    // 匹配中括号里任意的中文,倒序是由于之后会将文字占位符替换为图片，这个操作会改变文字的长度
    NSRegularExpression *regexEmoji = [NSRegularExpression regularExpressionWithPattern:@"\\[[\u4E00-\u9FA5]*\\]" options:0 error:nil];
    NSArray *matchesEmoji = [regexEmoji matchesInString:attributedText.string
                                                options:NSMatchingWithoutAnchoringBounds
                                                  range:NSMakeRange(0, attributedText.string.length)];
    // 倒叙替换
    for (NSTextCheckingResult *result in [matchesEmoji reverseObjectEnumerator]) {
        NSString *currentFindStr = [attributedText.string substringWithRange:result.range];
        NSString *matchString = [self.model searchEmojiImageName:currentFindStr];
        // 匹配下是否有这个
        if (matchString.length > 0) {
            UIImage *emojiImage = [UIImage imageNamed:[@"SBEmoji.bundle" stringByAppendingPathComponent:[NSString stringWithFormat:@"images/%@", matchString]]];
            NSTextAttachment * attachment = [[NSTextAttachment alloc] init];
            attachment.bounds = CGRectMake(0, 0, 14, 14);
            attachment.image = emojiImage;
            NSAttributedString * attachStr1 = [NSAttributedString attributedStringWithAttachment:attachment];
            [attributedText replaceCharactersInRange:result.range withAttributedString:attachStr1];
        }
    }
    
    // 匹配<a href>里面的内容
    NSRegularExpression *regexLink = [NSRegularExpression regularExpressionWithPattern:@"<a .*>(\\d+|\\D+)</a>" options:0 error:nil];
    NSArray *matchesLink = [regexLink matchesInString:attributedText.string
                                              options:NSMatchingWithoutAnchoringBounds
                                                range:NSMakeRange(0, attributedText.string.length)];
    for (NSTextCheckingResult *result in [matchesLink reverseObjectEnumerator]) {
        NSString *currentFindStr = [attributedText.string substringWithRange:result.range];
        
        NSArray *array=[currentFindStr componentsSeparatedByString:@">"];
        NSString *separateString=[array objectAtIndex:1];
        [attributedText addAttribute:NSLinkAttributeName value:[NSURL URLWithString:@"http://www.baidu.com"] range:result.range];
        [attributedText replaceCharactersInRange:result.range withString:[separateString substringToIndex:(separateString.length-3)]];
    }
    return attributedText;
}

@end
