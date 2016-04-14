//
//  SNJSONNODE.h
//  GubaModule
//
//  Created by jf on 14-12-5.
//  Copyright (c) 2014年 eastmoney. All rights reserved.
//  资讯JSON节点宏定义

//资讯默认加载图片



#define SN_CONTENT_CANCOMMENT       @"post_id"
#pragma mark 资讯要闻
//资讯要闻列表
#define SN_SUMMARY_LIST_IMAGE        @"image"         //资讯要闻 图片地址
#define SN_SUMMARY_LIST_BASICTITLE        @"title"         //资讯要闻 标题
#define SN_SUMMARY_LIST_TITLE        @"simtitle"         //资讯要闻 标题
#define SN_SUMMARY_LIST_SIMTITLE        @"simdigest"         //资讯要闻 摘要
#define SN_SUMMARY_LIST_COMMENTSIZE        @"commentnum"         //资讯要闻 评论个数
#define SN_SUMMARY_LIST_TOPICARR       @"simspecial"         //资讯要闻 专题数组
#define SN_SUMMARY_LIST_COMMENTSHOW       @"iscomment"         //资讯要闻 评论是否显示
#define SN_SUMMARY_LIST_SIMTPYE       @"simtype_zh"         //资讯要闻 专题名称
#define SN_SUMMARY_LIST_ISOFFLINE       @"isoffline"         //资讯要闻 是否是离线
#define SN_SUMMARY_LIST_SHAREURL       @"shareUrl"         //资讯要闻 分享地址

//要闻广告字段
#define SN_SUMMARY_LIST_ADTYPE     @"adtype"         //资讯要闻 广告类型
#define SN_SUMMARY_LIST_ADTOPIC     @"topic"         //资讯要闻 广告提示文字
#define SN_SUMMARY_LIST_ADWEBURL     @"jumpWebPage"         //资讯要闻 广告推广直接跳转地址
#define SN_SUMMARY_LIST_ADJUMPTYPE      @"jumptype"         //资讯要闻 广告跳转类型
#define SN_SUMMARY_LIST_ADJUMPIOSCLIENT      @"jumpIosClient"         //资讯要闻 广告跳转客户端
#define SN_SUMMARY_LIST_ADACTCONFIG     @"actConfig"            //资讯要闻 广告跳转 活动配置
#define SN_SUMMARY_LIST_ADISACT     @"isAct"            //资讯要闻 广告跳转是否是act，代表跳客户端活动
//要闻广告分享一些字段
#define SN_SUMMARY_AD_GUESSNAME     @"guessName"            //活动标题
#define SN_SUMMARY_AD_WBSHARENAME     @"WBShareName"            //微博分享名称
#define SN_SUMMARY_AD_WBSHAREMSG     @"WBShareMsg"            //微博分享消息
#define SN_SUMMARY_AD_WBSHAREURL     @"WBShareUrl"            //微博分享地址
#define SN_SUMMARY_AD_WBSHAREIMAGE     @"WBSharePic"            //微博分享图片
#define SN_SUMMARY_AD_WXSHARENAME     @"WXShareName"            //微信分享名称
#define SN_SUMMARY_AD_WXSHAREMSG     @"WXShareMsg"            //微信分享消息
#define SN_SUMMARY_AD_WXSHAREURL     @"WXShareUrl"            //微信分享地址
#define SN_SUMMARY_AD_WXSHAREIMAGE     @"WXSharePic"            //微信分享图片

#pragma mark 资讯自选

#ifdef YES



#define SN_OPTIONAL_LIST_POSTLASTTIME       @"post_last_time"         //资讯自选 股票最新时间
#define SN_OPTIONAL_LIST_POSTID      @"post_id"         //资讯自选 RecordID
#define SN_OPTIONAL_LIST_POSTCLICKCOUNT     @"post_click_count"         //资讯自选 点击次数
#define SN_OPTIONAL_LIST_POSTSOURCEID     @"post_source_id"         //资讯自选 点击次数

#else
//资讯自选



#define SN_OPTIONAL_LIST_POSTLASTTIME       @"post_last_time"         //资讯自选 股票最新时间
#define SN_OPTIONAL_LIST_POSTID      @"post_id"         //资讯自选 RecordID
#define SN_OPTIONAL_LIST_POSTCLICKCOUNT     @"post_click_count"         //资讯自选 点击次数
#define SN_OPTIONAL_LIST_POSTSOURCEID     @"post_source_id"         //资讯自选 点击次数

#endif

#pragma mark 自选内容
#define SN_OPTIONAL_CONTENT_POSTCONTENT     @"post_content"         //资讯自选内容 内容

#pragma mark 资讯其他
//资讯其他
#define SN_OTHER_LIST_TITLE        @"title"         //资讯其他 标题
#define SN_OTHER_LIST_TIME        @"showtime"         //资讯其他 时间

#define SN_SHARETITLE_NEWS          @"simdigest"          //
#define SN_SHARETITLE_LIVE          @"digest"          //
#define SN_OTHER_LIST_TITLESTYLE    @"titlestyle"   //资讯字体样式

#pragma mark 资讯专题
//资讯专题
#define SN_TOPIC_TOPICBANNER        @"Topic_Banner"      //资讯专题 标题字段
#define SN_TOPIC_HEADGUIDANCE        @"Head_Guidance"      //资讯专题 导语字段

#define SN_TOPIC_HEADGUIDANCE_PREFIX        @"TopicHeadLine"      //资讯专题 导语标示
#define SN_TOPIC_CUTIMG_PREFIX        @"TopicCutImg"      //资讯专题 非图片报道标示
#define SN_TOPIC_IMGREPORT_PREFIX       @"TopicImg"      //资讯专题 图片报道标示
//资讯专题列表
#define SN_TOPIC_LIST_IMAGE        @"Img_Path"         //资讯专题 图片地址
#define SN_TOPIC_LIST_TITLE        @"Img_MainTitle"         //资讯专题 标题
#define SN_TOPIC_LIST_SIMTITLE        @"Img_SecTitle"         //资讯专题 摘要
#define SN_TOPIC_LIST_COMMENTSIZE        @"Commentnum"         //资讯专题 评论个数
#define SN_TOPIC_LIST_NEWSID       @"Newsid"         //资讯专题 专题NewsId
#define SN_TOPIC_LIST_NEWSTYPE       @"Newstype"         //资讯专题 专题NewsType
#define SN_TOPIC_LIST_TOPICNAME       @"Img_Goto_URL"         //资讯专题 专题跳转（唯一标示）
#define SN_TOPIC_LIST_SIMTPYE       @"Simtype"         //资讯要闻 专题名称

//资讯专题 DataItemDetail 设置字段
#define __SN_TOPIC_SECTION_TITLE        @"section_title"        //悬浮 标题
#define __SN_TOPIC_TITLE        @"title"        //子层的标题，字符串
#define __SN_TOPIC_CONTENT      @"content"      //子层的内容，数组类型



//个股公告
#define __SN_INDIVIDUALREPORT_DIC            @"reportAStock"         //个股研报底层dic字段
#define __SN_INDIVIDUALREPORT_STOCKCODE            @"StockCode"         //股票代码
#define __SN_INDIVIDUALREPORT_STOCKNAME            @"StockName"         //股票名称
#define __SN_INDIVIDUALREPORT_DECLAREDATE            @"declaredate"         //时间
#define __SN_INDIVIDUALREPORT_TTITLE            @"title"         //标题
#define __SN_INDIVIDUALREPORT_AUTHOR            @"author"         //作者
#define __SN_INDIVIDUALREPORT_TYPENAME            @"reporttypename"         //报告类型
#define __SN_INDIVIDUALREPORT_BROKERNAME            @"brokerName"         //公司名称
#define __SN_INDIVIDUALREPORT_CONTENT            @"content"         //内容
#define __SN_INDIVIDUALREPORT_PDFURL            @"url_pdf"         //pdf下地址

#define __SN_INDIVIDUALREPORT_SHAREURL          @"url_m"            //分享URL

//个股研报
#define __SN_INDUSTRYREPIRT_DIC            @"reportIndustry"         //行业研报底层dic字段

//重大消息
#define __SN_BIGNEWS_LIST_TITLE         @"title"            //重大消息标题
#define __SN_BIGNEWS_LIST_DIGEST         @"digest"            //重大消息副标题
#define __SN_BIGNEWS_LIST_COMMENTNUM         @"commentnum"            //评论个数
#define __SN_BIGNEWS_LIST_NEWSID         @"newsid"            //新闻ID
#define __SN_BIGNEWS_LIST_SHOWTIME       @"showtime"            //展示时间
#define __SN_BIGNEWS_LIST_PULISHTIME       @"pushtime"            //发布时间
#define __SN_BIGNEWS_LIST_NEWSTYPE         @"newstype"            //新闻类型


//缓存键
#define STORE_CORE_NEWS_ISREAD                  @"STORE_CORE_NEWS_ISREAD"   // 资讯是否已经阅读
#define STORE_CORE_PDF_DOWN                     @"STORE_CORE_PDF_DOWN"   //下载PDF

#define __SN_CACHEKEY_NEWS_BODY(nid)          [NSString stringWithFormat:@"__SN_CACHEKEY_NEWS_NEWBODY_%@", nid]    //资讯内容
#define __SN_CACHEKEY_FAVORITE_BODY          [NSString stringWithFormat:@"__SN_CACHEKEY_FAVORITE_BODY"]    //资讯收藏
#define __SN_CACHEKEY_FAVORITE_USER(userId)          [NSString stringWithFormat:@"__SN_CACHEKEY_FAVORITE_USER%@",userId]    //根据用户id存

#define __SN_CACHEKEY_TABLE_NEWS(channel)           [NSString stringWithFormat:@"__SN_CACHEKEY_TABLE_NEWS-%@", channel]
#define __SN_CACHEKEY_TABLE_OFFLINE(channel)           [NSString stringWithFormat:@"__SN_CACHEKEY_TABLE_OFFLINE-%@", channel]


//资讯列表需要刷新的时间
#define __SN_REFRESHTIME_TABLE          300.0f

//资讯渠道标示
#define __SN_CHANNEL_TAG_OPTION @"999"      //资讯渠道 自选
#define __SN_CHANNEL_TAG_LIVE @"102"      //资讯渠道 滚动
#define __SN_CHANNEL_TAG_NEWS @"101"      //资讯渠道 要闻

#define __SN_CHANNEL_TAG_STOCKBARSCHROOL @"stockschool"      //资讯渠道 股民学校

#define __SN_CHANNEL_TAG_WANGER @"wagner"      //资讯渠道 看盘

#define __SN_OFFLINT_TAG_TABLEVIEW 10000000          //离线下载混和列表tag

//分享公共字段
#define __SN_RUN_APPNAME @"eastmoney.runningApplicationName"         //分享时候的KEY
#define __SN_SHARE_ICONNAME @"stockbar.share.shareIconName"
#define __SN_SHARE_APPNAME @"东方财富网"
#define __SN_SHARE_ICON @"AppIcon57x57.png"