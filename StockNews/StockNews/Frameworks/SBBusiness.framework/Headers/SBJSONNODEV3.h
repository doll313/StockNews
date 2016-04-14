/*
 #####################################################################
# File    : SBJSONNODEV3.h
# Project : GubaModule
# Created : 14-5-29
# DevTeam : eastmoney
# Author  : Thomas
# Notes   : 股吧v3接口的json节点宏定义
 #####################################################################
 ### Change Logs   ###################################################
 #####################################################################
 ---------------------------------------------------------------------
# Date                                  :
# Author:
# Notes                                 :
 #
 #####################################################################
 */

#ifndef SBBarModule_SBJSONNODEV3_h
#define SBBarModule_SBJSONNODEV3_h

/**
 *  股吧帖子的类型
 */
typedef NS_ENUM(NSInteger, SBV3StockbarType){
    /** 其他 */
    SBV3StockbarTypeOther = -1,
    /** 沪深，港股，美股*/
    SBV3StockbarTypeNormal = 100,
    /** 待上市 */
    SBV3StockbarTypeForUP = 101,
    /** 指数 */
    SBV3StockbarTypeIndex = 102,//(非分时图)
    /** 板块*/
    SBV3StockbarTypePlate = 103,//(非分时图)
    /** 基金*/
    SBV3StockbarTypeFund = 105,//(非分时图)
    /** 未上市*/
    SBV3StockbarTypeUnUP = 200,
    /** 主题吧*/
    SBV3StockbarTypeTheme = 201,//(非分时图)
    /** 期权吧*/
    SBV3StockbarTypeOption = 204,
    
    SBV3StockbarTypeHidden = 205,//为了应对隐藏发表于多出来的隐藏吧
    /** 期货现货吧*/
    SBV3StockbarTypeForward = 206//（非分时图）
};

/**
 *  股吧帖子的类型
 */
typedef NS_ENUM(NSInteger, SBV3ArticleType){
    /** 全部 */
    SBV3ArticleTypeAll = 0,
    /** 新闻*/
    SBV3ArticleTypeNews = 1,
    /** 研报*/
    SBV3ArticleTypeSurvey = 2,
    /** 公告 */
    SBV3ArticleTypeAnnounce = 3,
    /**  数据*/
    SBV3ArticleTypeData = 4,
    /**  股东会*/
    SBV3ArticleTypeShareHolder = 5,
    /**  博客*/
    SBV3ArticleTypeBlog = 7,
    /**  访谈*/
    SBV3ArticleTypeInterview = 8,
    /**  投资组合*/
    SBV3ArticleTypePortfolio = 9,
    
    /**  投票帖*/
    SBV3ArticleTypeVotePost = 10,
    /**  热门 这个是自定义的*/
    SBV3ArticleTypeHot = 99
};

//评论权限0 可以回复,1,该主题加V用户才能回复, 2,该主题注册用户才能回复,3, 该主题禁止回复
typedef NS_ENUM(NSInteger,SBPostReplyAthorityType) {
    SBPostReplyAthorityTypeAollow = 0,
    SBPostReplyAthorityTypeIdentify,
    SBPostReplyAthorityTypeRegister,
    SBPostReplyAthorityTypeDisable,
};

// 新闻类(滚动……)点击跳转的类型
typedef NS_ENUM(NSInteger,LiveNewsType){
    LiveNewsTypeNews = 1,           //新闻
    LiveNewsTypeLive = 2,           // 摘要
    LiveNewsTypeIndividual = 3,         //个股研报
    LiveNewsTypeIndustry = 4            //行业研报
};

/**
 *  股吧帖子的类型 新闻摘要
 */
typedef NS_ENUM(NSInteger, SBV3ArticleSpecialType){
    /** 新闻*/
    SBV3ArticleSpecialTypeNews = 0,
    /** 摘要 */
    SBV3ArticleSpecialTypeSummay = 1,
    /** 其他 */
    SBV3ArticleSpecialTypeOther = 99,
};

/**
 *  股吧帖子的置顶类型
 */
typedef NS_ENUM(NSInteger, SBV3StatusTopType){
    /** 普通 */
    SBV3StatusTopTypeNormal = 0,
    /** 置顶*/
    SBV3StatusTopTypeIsTop = 1,
    /** 话题*/
    SBV3StatusTopTypeTopic = 2
    
};

/**
 *  股吧帖子状态
 */
typedef NS_ENUM(NSInteger, SBV3StatusStatus){
    /** 普通 */
    SBV3StatusStatusNormal = 0,
    /** 精华*/
    SBV3StatusStatusEssence = 1,
    /** 股东*/
    SBV3StatusStatusShareholder = 2,
    
};

/**
 *  帖子排序
 */
typedef NS_ENUM(NSInteger, SBV3ReplysSort){
    /** 最早回复 */
    SBV3ReplysSortASC = -1,
    /** 最早 */
    SBV3ReplysSortDES = 1
};

/**
 *  邀请好友的来源
 */
typedef NS_ENUM(NSInteger, SBV3InviteSource){
    /** 通讯录 */
    SBV3InviteSourceAddress = 1,
    /** 微博 */
    SBV3InviteSourceSina = 2
};

/**
 *  原帖删除标识
 */
typedef NS_ENUM(NSInteger, SBV3SourcePostState){
    /** 没删 */
    SBV3SourcePostStateNormal = 0,
    /** 删除 */
    SBV3SourcePostStateDeleted = 1,
    /** 审核 */
    SBV3SourcePostStateAudit = 2
};

/**
 访谈帖状态
 */
typedef NS_ENUM(NSInteger, SBV3InterviewState) {
    /** 还未开始 */
    SBV3InterviewStateNotStart = 0,
    /** 正在进行 */
    SBV3InterviewStateOnGoing,
    /** 已经结束 */
    SBV3InterviewStateFinished
};

/**
 股吧是否有行情
 */
typedef NS_ENUM(NSInteger, SBV3StockbarQuote) {
    /** 有行情 */
    SBV3StockbarQuoteWithMarket = 1,
    /** 无行情 */
    SBV3StockbarQuoteWithoutMarket = 2
};

/**
 股票品种类型
 */
typedef NS_ENUM(NSInteger, SBV3StockbarCategory) {
    /** 其他 */
    SBV3StockbarCategoryOther = -1,
    /** 股票 */
    SBV3StockbarCategoryStock = 100,
    /** 待上市 */
    SBV3StockbarCategoryWaitListed = 101,
    /** 指数 */
    SBV3StockbarCategoryIndex = 102,
    /** 板块 */
    SBV3StockbarCategoryPlate = 103,
    /** 未上市 */
    SBV3StockbarCategoryUnlisted = 200,
    /** 主题吧 */
    SBV3StockbarCategoryTheme = 201,
    /** 从gubalist导入 */
    SBV3StockbarCategoryGubaList = 202
    
};

//帖子类型
typedef NS_ENUM(NSInteger, SBStatusBodyControllerType) {
    SBStatusBodyControllerTypeNormal = 0,
    SBStatusBodyControllerTypeInterview = 1
};

//判断搜索是否从股吧进入
typedef NS_ENUM(NSInteger, SBAllSearchComeFrom) {
    SBAllSearchComeFromEastMoney = 0,
    SBAllSearchComeFromGuBa = 1
};

typedef NS_ENUM(NSInteger, SBViewStatusBodyFromType) {//是否从回复进入
    SBViewStatusBodyFromNomal = 0,
    SBViewStatusBodyFromReply = 1,
};

//用户自选股状态
typedef NS_ENUM(NSInteger, SBUserSelectStockAuthorityType) {
    SBUserSelectStockAuthorityTypeAll = 0,
    SBUserSelectStockAuthorityTypeFollow ,
    SBUserSelectStockAuthorityTypeNoBody ,
};

//帖子json节点

#define JNV3_POST                         @"Post"
#define JNV3_POST_ID                      @"post_id"                     // 帖子ID ,
#define JNV3_NEWS_ID                      @"news_id"
#define JNV3_POST_USER                    @"post_user"                   //主帖用户信息
#define JNV3_USER_ID                      @"user_id"                     //用户id ,
#define JNV3_USER_NICKNAME                @"user_nickname"               // 用户昵称 ,
#define JNV3_USER_IS_MY_BLACK             @"user_is_my_black"            //黑名单
#define JNV3_USER_NAME                    @"user_name"                   // 用户名 ,
#define JNV3_SOURCE_POST_USER_IS_MAJIA    @"source_post_user_is_majia"   //false-个人账号 ture-资讯账号
#define JNV3_USER_V                       @"user_v"                      //加v用户  ,
#define JNV3_USER_LEVEL                   @"user_level"                  //用户级别 0：普通 1 ：股东 ,
#define JNV3_USER_STOCKBAR_AGE            @"user_stockbar_age"           // 吧龄
#define JNV3_USER_BAR_AGE                 @"user_age"                    // 5.3吧龄
#define JNV3_USER_INFLU_LEVEL             @"user_influ_level"            //影响力
#define JNV3_USER_BLACK_TYPE              @"user_black_type"             //被屏蔽信息
#define JNV3_USER_FIRST_EN_NAME           @"user_first_en_name"          //拼音首字母
#define JNV3_USER_IS_MAJIA                @"user_is_majia"               //0 个人 1 马甲,
#define JNV3_USER_REG_TIME                @"user_reg_time"               //用户注册时间
#define JNV3_POST_GUBA                    @"post_guba"                   //主帖股吧信息
#define JNV3_STOCKBAR_CODE                @"stockbar_code"               // 股票代码 ,
#define JNV3_STOCKBAR_NAME                @"stockbar_name"               // 股票名称 ,
#define JNV3_STOCKBAR_MARKET              @"stockbar_market"             //股票市场
#define JNV3_STOCKBAR_EXTERNAL_CODE       @"stockbar_external_code"      //目前板块使用的，说是我们发什么他们返回什么
#define JNV3_STOCKBAR_TYPE                @"stockbar_type"               //股票类型
#define JNV3_STOCKBAR_IS_FOLLOWING        @"stockbar_is_following"       //股票是否关注
#define JNV3_STOCKBAR_QUOTE               @"stockbar_quote"       //股票是否有行情
#define JNV3_STOCKBAR_SEARCH_TYPE         @"stockbar_search_type"        //股票类型
#define JNV3_STOCKBAR_CATEGORY            @"stockbar_category"       //股票品种
#define JNV3_STOCKBAR_EXCHANGE            @"stockbar_exchange"       //股票交易所
#define JNV3_POST_TITLE                   @"post_title"                  // 标题 ,
#define JNV3_POST_CONTENT                 @"post_content"                // 主帖摘要 ,
#define JNV3_POST_ABSTRACT                @"post_abstract"              //用于分享的正文
#define JNV3_POST_PUBLISH_TIME            @"post_publish_time"           //主帖发表时间 ,
#define JNV3_POST_LAST_TIME               @"post_last_time"              //更新时间 ,
#define JNV3_POST_IP                      @"post_ip"                     // 主帖用户IP
#define JNV3_POST_IP_ADDRESS              @"post_ip_address"             // 主帖用户IP所在地
#define JNV3_POST_CLICK_COUNT             @"post_click_count"            // 点击数 ,
#define JNV3_POST_FORWARD_COUNT           @"post_forward_count"          //转发数,
#define JNV3_POST_COMMENT_COUNT           @"post_comment_count"          // 评论数 ,
#define JNV3_POST_LIKE_COUNT              @"post_like_count"             // 赞数 ,
#define JNV3_POST_IS_LIKE                 @"post_is_like"                //0 未赞 1 已赞,
#define JNV3_POST_POST_TYPE               @"post_type"                   //类型（0：普通，1：新闻，2：研报，3：公告，4：数据,7-博客，8-访谈，9-投资组合，10-投票）,
#define JNV3_POST_REPLY_AUTHORITY         @"post_comment_authority"     //评论权限 0 可以回复,1,该主题加V用户才能回复, 2,该主题注册用户才能回复,3, 该主题禁止回复
#define JNV3_POST_TOP_STATUS              @"post_top_status"             //置顶（0没置顶，1置顶，2话题）,
#define JNV3_POST_STATUS                  @"post_status"                 //帖子状态（0 普通，1 精华, 2 股东）,
#define JNV3_POST_FROM                    @"post_from"                   //  来源终端（）,
#define JNV3_POST_PDF_URL                 @"post_pdf_url"                //pdf的url，
#define JNV3_POST_HAS_PIC                 @"post_has_pic"                //图片（0没有图片，1带有图片） ,
#define JNV3_POST_PIC_URL                 @"post_pic_url"                //:图片地址
#define JNV3_POST_IS_COLLECTED            @"post_is_collected"           //帖子是否收藏

#define JNV3_SOURCE_POST_GUBA             @"source_post_guba"            //资讯对应股票信息
#define JNV3_SOURCE_POST_ID               @"source_post_id"              //转发原id,
#define JNV3_SOURCE_POST_IP               @"source_post_ip"              //转发原ip,
#define JNV3_SOURCE_POST_IP_ADDRESS       @"source_post_ip_address"      // 主帖用户IP所在地
#define JNV3_SOURCE_POST_STATE            @"source_post_state"           //：原帖删除标识，0没删，1删除，2审核 ,
#define JNV3_SOURCE_POST_USER_ID          @"source_post_user_id"         // 原帖用户id ,
#define JNV3_SOURCE_POST_USER_NICK_NAME   @"source_post_user_nickname"   //原帖用户昵称 ,
#define JNV3_SOURCE_POST_PIC_URL          @"source_post_pic_url"         //原帖图片地址   ,
#define JNV3_SOURCE_POST_TITLE            @"source_post_title"           // 原帖标题 ,
#define JNV3_SOURCE_POST_CONTENT          @"source_post_content"         //原帖内容
#define JNV3_SOURCE_POST_TYPE             @"source_post_type"         //原帖类型

//访谈帖
#define JNV3_INTERVIEW_START_TIME   @"interview_start_time"
#define JNV3_INTERVIEW_END_TIME         @"interview_end_time"
#define JNV3_INTERVIEW_STATE        @"interview_state"
#define JNV3_INTERVIEW_GUEST            @"interview_guest"

//评论json节点 （只声明还未定义的）
#define JNV3_REPLY_USER                   @"reply_user"                  //回复用户
#define JNV3_REPLY_GUBA                   @"reply_guba"                  //回复所在的股吧
#define JNV3_REPLY_ID                     @"reply_id"                    //回复id
#define JNV3_REPLY_TYPE                     @"reply_type"                    //回复类型
#define JNV3_REPLY_IP                     @"reply_ip"                    //回复ip
#define JNV3_REPLY_IP_ADDRESS             @"reply_ip_address"            //回复ip所在地
#define JNV3_REPLY_TEXT                   @"reply_text"                  //回复内容
#define JNV3_REPLY_PUBLISH_TIME           @"reply_publish_time"          //回复时间
#define JNV3_REPLY_IS_LIKE                @"reply_is_like"               //回复是否已赞
#define JNV3_REPLY_DIALOG_ID              @"reply_dialog_id"             //对话id
#define JNV3_SOURCE_REPLY_ID              @"source_reply_id"             //原始回复id
#define JNV3_SOURCE_REPLY_USER_ID         @"source_reply_user_id"        //原始用户id
#define JNV3_SOURCE_REPLY_USER_IP         @"source_reply_user_ip"        //原始ip
#define JNV3_SOURCE_REPLY_IP              @"source_reply_ip"             //查看对话里面的被回复人IP
#define JNV3_SOURCE_REPLY_USER_IP_ADDRESS @"source_reply_user_ip_address"//原始ip所在地
#define JNV3_SOURCE_REPLY_USER_NICKNAME   @"source_reply_user_nickname"  //原始用户昵称
#define JNV3_SOURCE_REPLY_TEXT            @"source_reply_text"           //原始评论
#define JNV3_POINT_REPLY                  @"point_re"                    //精彩评论

//5.4股吧首页更新数据节点
#define JNV3_FOLLOW_GUBA_NEWPOSTCOUNT    @"follow_guba_has_newpost"//更新新帖数
#define JNV3_FOLLOW_GUBA_HOTPOSTCOUNT    @"follow_guba_has_newhotpost"//更新新帖数
#define JNV3_FOLLOW_USER_NEWPOSTCOUNT    @"follow_user_has_newpost"//更新新帖数
#define JNV3_FOLLOW_USER_REPLYPOSTCOUNT    @"follow_user_has_newreply"//更新新帖数


//热门股吧json节点 （只声明还未定义的）
#define JNV3_STOCKBAR_FANS_COUNT          @"stockbar_fans_count"         // 股吧粉丝数量
#define JNV3_STOCKBAR_POST_COUNT          @"stockbar_post_count"         // 股吧主帖数量
#define JNV3_STOCKBAR_LOOKHIGH_COUNT      @"stockbar_look_high_count"    // 看涨数量
#define JNV3_STOCKBAR_LOOKLOW_COUNT       @"stockbar_look_low_count"     // 看跌数量

//股吧粉丝列表json节点 （只声明还未定义的）
#define JNV3_USER_INTRODUCE               @"user_introduce"              //用户介绍
#define JNV3_USER_DESCRIPTION             @"user_description"            //用户描述
#define JNV3_USER_RANK_DESCRIPTION        @"user_rank_description"      //热门博主描述

//股吧粉丝列表json节点 （只声明还未定义的）
#define JNV3_USER_LOGINED                  @"user_logined"                 //用户是否登录
#define JNV3_USER_PI                  @"user_pi"                 //用户PI信息
#define JNV3_USER_ISLOCKED                @"user_islocked"               //是否锁定
#define JNV3_USER_GENDER                  @"user_gender"                 //用户性别
#define JNV3_USER_PROVINCE                @"user_province"               //用户省
#define JNV3_USER_CITY                    @"user_city"                   //市
#define JNV3_USER_FOLLOWING_COUNT         @"user_following_count"        //用户关注数量
#define JNV3_USER_FANS_COUNT              @"user_fans_count"             //用户粉丝数量
#define JNV3_USER_SELECT_STOCK_COUNT      @"user_select_stock_count"     //用户自选股吧数量
#define JNV3_USER_IS_FOLLOWING            @"user_is_following"           //是否已经关注
#define JNV3_USER_IS_FOLLOWING_EACH       @"user_is_following_each"      //是否相互关注
#define JNV3_USER_COMMON_SELECT_STOCK     @"user_common_select_stock"    //共同关注的股吧
#define JNV3_USER_INFLU_RANGE             @"user_influ_range"            //能力圈


//用户数量json节点
#define JNV3_USER_FANS_COUNT              @"user_fans_count"             //用户粉丝数量
#define JNV3_USER_AT_POST_COUNT           @"user_at_post_count"          //@我的主帖数量
#define JNV3_USER_AT_REPLY_COUNT          @"user_at_reply_count"         //@我的回复数量
#define JNV3_USER_FOLLOWING_STOCK_COUNT   @"user_following_stock_count"  //用户关注的股数量
#define JNV3_USER_FOLLOWING_COUNT         @"user_following_count"        //用户关注的人数量
#define JNV3_USER_ALL_COUNT               @"user_all_count"              //全部数量
#define JNV3_USER_POST_COUNT              @"user_post_count"             //用户帖子数量
#define JNV3_USER_LIKE_POST_COUNT         @"user_like_post_count"        //赞我的主帖数量
#define JNV3_USER_LIKE_REPLY_COUNT        @"user_like_reply_count"       //赞我的回复数量
#define JNV3_USER_REPLY_COUNT             @"user_reply_count"            //回复我的数量
#define JNV3_USER_TOTAL_POST_COUNT        @"user_total_post_count"       //用户发帖数
#define JNV3_USER_TOTAL_FOLLOW_COUNT      @"user_total_follow_count"     //用户关注数
#define JNV3_USER_TOTAL_FANS_COUNT        @"user_total_fans_count"       //粉丝总数
#define JNV3_USER_TOTAL_BAR_COUNT         @"user_total_follow_guba_count"       //关注股吧数
#define JNV3_USER_COMBINATION_COUNT        @"user_combination_count"        //投资组合数
#define JNV3_USER_SELECT_STOCK_AUTHORITY   @"user_select_stock_authority"   //是否允许查看自选股 0：允许所有人查看  1：允许我关注的人查看  2：不允许任何人查看，默认0
#define JNV3_USER_IS_FOLLOWED             @"user_is_followed"             //"我"是否被他人关注



//用户赞json节点
#define JNV3_POST_LIKE_USER               @"post_like_user"              //用户数据
#define JNV3_POST_LIKE_USER_ID            @"post_like_user_id"           // 赞帖子的用户id
#define JNV3_POST_LIKE_USER_NICKNAME      @"post_like_user_nickname"     // 赞帖子的用户昵称
#define JNV3_POST_LIKE_USER_V               @"post_like_user_v"              // 赞帖子用户vip
#define JNV3_POST_LIKE_TIME               @"post_like_time"              // 赞帖子时间
#define JNV3_POST_LIKE_FROM               @"post_like_from"              // 赞帖子来自
#define JNV3_REPLY_LIKE_USER               @"reply_like_user"              //赞回复的用户数据
#define JNV3_REPLY_LIKE_USER_ID           @"reply_like_user_id"          // 赞回复的用户id
#define JNV3_REPLY_LIKE_USER_NICKNAME     @"reply_like_user_nickname"    // 赞回复的用户昵称
#define JNV3_REPLY_LIKE_USER_V               @"reply_like_user_v"              // 赞回复用户vip
#define JNV3_REPLY_LIKE_TIME              @"reply_like_time"             // 赞回复时间
#define JNV3_REPLY_LIKE_FROM              @"reply_like_from"             // 赞回复来自
#define JNV3_REPLY_LIKE_COUNT              @"reply_like_count"             // 赞数量

//股友信息json节点
#define JNV3_USER_TAUSER_ID               @"tauser_id"                   //第三方用户id

//上传图片的
#define JNV3_USER_FILENAME              @"filename"                   //图片地址

//广告栏信息json节点
#define JNV3_USER_BANNER_TITLE            @"banner_title"                //广告的标题
#define JNV3_USER_BANNER_PIC_URL          @"banner_pic_url"              //广告图片位置
#define JNV3_USER_BANNER_POST_ID          @"banner_post_id"              //广告对应的股吧帖子id
#define JNV3_USER_BANNER_LINK_URL         @"banner_link_url"             //布告栏链接
#define JNV3_USER_BANNER_RE               @"banner_re"                   //列表数据
#define JNV3_USER_BANNER_TYPE             @"banner_type"                //布告栏类型

//发帖转发json节点
#define JNV3_MAIN_POST_ID                      @"main_post_id"                     // 帖子ID
#define JNV3_REPLYID                           @"replyid"                    //回复id

//推送的节点 根据接口回复字符串修改
#define JNV3_NOTIFICATION_RESPONSE        @"notication_response"         //回复字符串
#define JNV3_NOTIFICATION_UID             @"notication_uid"              //uid
#define JNV3_NOTIFICATION_STOCK_CODE      @"notication_stock_code"       //股票代码
#define JNV3_NOTIFICATION_NOTICE          @"notication_notice"           //是否接收公告消息
#define JNV3_NOTIFICATION_SURVEY          @"notication_survey"           //是否接收研报消息
#define JNV3_NOTIFICATION_DATA            @"notication_data"             //是否接收数据消息
#define JNV3_NOTIFICATION_UPPER           @"notication_upper"            //股价上限
#define JNV3_NOTIFICATION_FLOOR           @"notication_floor"            //股价下限
#define JNV3_NOTIFICATION_AMOUNT          @"notication_amount"           //股价涨幅
#define JNV3_NOTIFICATION_UPDAY           @"notication_upday"            //上涨预警日
#define JNV3_NOTIFICATION_DOWNDAY         @"notication_downday"          //下跌预警日
#define JNV3_NOTIFICATION_ENABLE          @"notication_enable"           //是否启用
#define JNV3_NOTIFICATION_INCREMENT_ID    @"notication_increment_id"     //增量id
#define JNV3_NOTIFICATION_TOKEN           @"notication_token"            //token
#define JNV3_NOTIFICATION_MESSEGE_ID      @"notication_messege_id"       //消息id
#define JNV3_NOTIFICATION_HAS_READED      @"notication_has_readed"       //是否阅读
#define JNV3_NOTIFICATION_MESSEGE_TYPE    @"notication_messege_type"     //消息类型
#define JNV3_NOTIFICATION_MESSEGE_COUNT   @"notication_messege_count"    //消息数量
#define JNV3_NOTIFICATION_STOCK_CODE      @"notication_stock_code"       //股票代码
#define JNV3_NOTIFICATION_STOCK_NAME      @"notication_stock_name"       //股票名字
#define JNV3_NOTIFICATION_MESSEGE_CONTENT @"notication_messege_content"  //消息内容
#define JNV3_NOTIFICATION_SB_UUID         @"notication_sb_uuid"          //股吧唯一标示
#define JNV3_NOTIFICATION_CREATE_TIME     @"notication_create_time"      //创建时间
#define JNV3_NOTIFICATION_DISPLAY_TIME    @"notication_display_time"     //显示时间
#define JNV3_NOTIFICATION_COUNT           @"notication_count"            //总数
#define JNV3_NOTIFICATION_APPTYPE         @"notication_app_type"         //应用类型
#define JNV3_NOTIFICATION_MSG_ID          @"notication_msg_id"           //消息id
#define JNV3_NOTIFICATION_MSG_TITLE       @"notication_msg_title"        //消息标题
#define JNV3_NOTIFICATION_MSG_CONTENT     @"notication_msg_content"      //消息内容
#define JNV3_NOTIFICATION_MSG_TIME        @"notication_msg_time"         //消息事件

#define JNV3_Original_Post_ID             @"original_post_id"            //原帖ID
#define JNV3_Original_Post_USER_ID        @"original_post_user_id"       //原帖用户ID
#define JNV3_Original_Post_USER_NAME      @"original_post_user_name"     //原帖用户名
#define JNV3_Original_Post_TITLE          @"original_post_title"         //原帖标题
#define JNV3_Original_Post_CONTENT        @"original_post_content"       //原帖内容

//新浪找股友字段
#define JNV3__NODE_SINA_NICK        @"__SB_NODE_SINA_NICK"       //新浪昵称
#define JNV3__NODE_SINA_OPENID        @"__SB_NODE_SINA_OPENID"       //新浪号
#define JNV3__NODE_SINA_NAME        @"__SB_NODE_SINA_NAME"       //新浪显示名字
#define JNV3__NODE_SINA_IMAGE        @"__SB_NODE_SINA_IMAGE"       //新浪头像
//通讯录找好友字段
#define JNV3__NODE__ADDRESS_FIRSTNAME        @"__SB_NODE_ADDRESS_FIRSTNAME"       //通讯录名
#define JNV3__NODE_ADDRESS_LASTNAME        @"__SB_NODE_ADDRESS_LASTNAME"       //通讯录姓
#define JNV3__NODE_ADDRESS_NUMBER        @"__SB_NODE_ADDRESS_NUMBER"       //通讯录号码
#define JNV3__NODE_ADDRESS_IMAGE        @"__SB_NODE_ADDRESS_IMAGE"       //通讯录头像

#define JNV3__NODE_ISGUBAUSER        @"__SB_NODE_ISGUBAUSER"       //是否股吧用户
#define JNV3__NODE_ISGUBAUSER        @"__SB_NODE_ISGUBAUSER"       //通讯录头像

#define JNV3__NODE_ISSINA_FRIEND        @"__SB_NODE_ISSINA_FRIEND"       //是否是新浪找好友

#define JNV3__NODE_NAME_ORIGINSTRING        @"__SB_NODE_NAME_ORIGINSTRING"       //原名称
#define JNV3__NODE_NAME_PINYINSTRING        @"__SB_NODE_NAME_PINYINSTRING"       //拼音名称
#define JNV3__NODE_NAME_INITIAL        @"__SB_NODE_NAME_INITIAL"       //名称首字母

#define JNV3_SBEMBARCELL_TAG              @"sbembarcelltag"            // 用来区别分时图下的cell算高度用


#endif
