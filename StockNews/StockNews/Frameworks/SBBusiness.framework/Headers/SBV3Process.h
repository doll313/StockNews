/*
 #####################################################################
 # File    : SBV3Process.h
 # Project : GubaModule
 # Created : 14-5-29
 # DevTeam : eastmoney
 # Author  : Thomas
 # Notes   : 股吧独立版v3接口实现
 #####################################################################
 ### Change Logs   ###################################################
 #####################################################################
 ---------------------------------------------------------------------
 # Date  :
 # Author:
 # Notes :
 #
 #####################################################################
 */

#import <SBModule/SBHttpProcess.h>
#import "SBJSONNODEV3.h"

static const int kApiV3PageSize = 20;      //默认页面大小

@interface SBV3Process : SBHttpProcess

//股吧v3域名
+ (NSString *)v3HttpDomainPath;

/**
 *  拼装请求的完整路径
 *
 *  @param api api名
 *  @param url 参数
 *
 *  @return 请求的完整路径
 */
+ (NSString *)bulidFullPath:(NSString *)api url:(NSString *)url;

#pragma mark - 通用路口

/**
 *  数据接口实现
 *
 *  @param URL      完整路径
 *  @param delegate 回调句柄
 *
 *  @return 接口句柄
 */
+ (SBHttpDataLoader *)request_sbv3_api:(NSString *)URL delegate:(id<SBHttpDataLoaderDelegate>)delegate;

//为了分时图做的get请求
+ (SBHttpDataLoader *)request_get_sbv3_api:(NSString *)URL delegate:(id<SBHttpDataLoaderDelegate>)delegate;

#pragma mark - 读接口
#pragma mark - 2.1 文章
/**
 *  账户收藏的帖子
 *
 *  @param p        页码
 */
+ (SBHttpDataLoader *)sbget_collected_articles:(NSInteger)p
                                       delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 *  用户赞的帖子
 *
 *  @param p        页码
 uid    为空是自己
 */
+ (SBHttpDataLoader *)sbget_user_assist_articles:(NSInteger)p
                                             uid:(NSString *)uid
                                        delegate:(id<SBHttpDataLoaderDelegate>)delegate ;

/**
 *  用户赞的回复
 *
 *  @param p        页码
 */
+ (SBHttpDataLoader *)sbget_user_assist_replys:(NSInteger)p
                                       delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 *  用户被赞的帖子
 *
 *  @param p        页码
 */
+ (SBHttpDataLoader *)sbget_assist_user_articles:(NSInteger)p
                                         delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 *  用户被赞的回复
 *
 *  @param p        页码
 */
+ (SBHttpDataLoader *)sbget_assist_user_replys:(NSInteger)p
                                       delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 *  帖子正文html
 *
 *  @param mainpostid 帖子id
 */
+ (SBHttpDataLoader *)sbget_article_content_html:(NSString *)mainpostid
                                       delegate:(id<SBHttpDataLoaderDelegate>)delegate;
/**
 *  帖子正文信息，包括发帖人信息等
 *
 *  @param mainpostid 帖子id
 */
+ (SBHttpDataLoader *)sbget_article_content__withPostId:(NSString *)mainpostid
                                               postType:(int)postType
                                               delegate:(id<SBHttpDataLoaderDelegate>)delegate;



/**
 黑色分时图
 *  股吧主帖列表
 *
 *  @param code     股吧代码
 *  @param p        页码
 *  @param type        不传返回全部，传入1-新闻，2-研报，3-公告，4-数据
 */
+ (SBHttpDataLoader *)sbget_sb_articles:(NSString *)code
                                      p:(NSInteger)p
                                   type:(SBV3ArticleType)type
                               sortType:(NSInteger)sorttype
                               delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 *  黑色分时图下 热帖列表
 *
 */

+(SBHttpDataLoader *)sbget_black_hot_posts_articles:(NSString *)code
                                               page:(NSInteger)p
                                           sortType:(NSInteger)sorttype
                                           delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 *  黑色分时图下 股友
 */
+(SBHttpDataLoader *)sbget_black_suggest_guba_fierce:(NSString *)code delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 访谈帖信息
 
 @param mainPostId 帖子id
 @param delegate   delegate
 
 @return SBHttpDataLoader
 */
+ (SBHttpDataLoader *)sbget_interview_content__withPostId:(NSString *)mainPostId delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 访谈所有回复
 
 @param mainPostId post id
 @param p          page number
 @param sort       sort
 @param delegate   delegate
 
 @return SBHttpDataLoader
 */
+ (SBHttpDataLoader *)sbget_interview_all_reply__withPostId:(NSString *)mainPostId
                                                           p:(NSInteger)p
                                                        sort:(SBV3ReplysSort)sort
                                                    delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 访谈嘉宾回复
 
 @param mainPostId post id
 @param guestIds   guest id(s)
 @param p          page number
 @param sort       sort
 @param delegate   delegate
 
 @return SBHttpDataLoader
 */
+ (SBHttpDataLoader *)sbget_interview_guest_reply__withPostId:(NSString *)mainPostId
                                                      guestIds:(NSArray *)guestIds
                                                             p:(NSInteger)p
                                                          sort:(SBV3ReplysSort)sort
                                                      delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 *  账户关注人发帖列表
 *
 *  @param p        页码
 */
+ (SBHttpDataLoader *)sbget_follow_users_articles:(NSInteger)pageSize
                                           pageAt:(NSInteger)p
                                         delegate:(id<SBHttpDataLoaderDelegate>)delegate;
/**
 *  关注的股，热帖列表
 *
 *  @param p 页码
 *
 *
 */
+ (SBHttpDataLoader *)sbget_hot_posts_articles:(NSString *)userId page:(NSInteger)p delegate:(id<SBHttpDataLoaderDelegate>)delegate;



/**
 *  股吧总版热门帖子
 *
 *  @param p        页码
 */
+ (SBHttpDataLoader *)sbget_hot_ariticles:(NSInteger)p
                                  delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 *  股吧总版热门资讯
 *
 *  @param p        页码
 */
+ (SBHttpDataLoader *)sbget_hot_news:(NSInteger)p
                                  delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 *  账户发帖列表
 *
 *  @param uid       用户id
 *  @param p        页码
 */
+ (SBHttpDataLoader *)sbget_user_articles:(NSString *)uid
                                         p:(NSInteger)p
                                  delegate:(id<SBHttpDataLoaderDelegate>)delegate;


/**
 *  帖子简要信息
 *
 *  @param postId   帖子id
 *  @param postType 帖子类型
 */
+ (SBHttpDataLoader *)sbget_article_short_info:(NSString *)postId type:(NSInteger)postType delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 *  主帖评论列表
 *
 *  @param postid 主帖id
 *  @param replyid    回复id
 *  @param p   页码
 *  @param sort   排序
 */
+ (SBHttpDataLoader *)sbget_article_replys:(NSString *)postid
                                     newsId:(NSString *)newsId
                                    replyid:(NSString *)replyid
                                          p:(NSInteger)p
                                          sort:(SBV3ReplysSort)sort
                                   delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 *  主帖评论列表（类型通用）
 *
 *  @param postid 主帖id
 *  @param type   主帖类型
 *  @param sort   排序
 *  @param p   页码
 */

+ (SBHttpDataLoader *)sbget_mainpost_replys:(NSString *)postid
                                        type:(SBV3ArticleType)type
                                           p:(NSInteger)p
                                        sort:(SBV3ReplysSort)sort
                                    delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 *  只看楼主评论列表（类型通用）
 *
 *  @param postid 主帖id
 *  @param type   主帖类型
 *  @param replyid   假页面回复ID
 *  @param sort   排序
 *  @param p   页码
 *  @param uid   楼主id,必传
 */
+ (SBHttpDataLoader *)sbget_authorOnly_replys:(NSString *)postid
                                          type:(SBV3ArticleType)type
                                       replyid:(NSString *)replyid
                                          sort:(SBV3ReplysSort)sort
                                           uid:(NSString *)uid
                                             p:(NSInteger)p
                                      delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 *  帖子简要信息
 *
 *  @param mainpostid 主帖id
 *  @param type        帖子类型
 */
+ (SBHttpDataLoader *)sbget_mainpost_shortInfo:(NSString *)mainpostid
                                                type:(SBV3ArticleType)type
                                            delegate:(id<SBHttpDataLoaderDelegate>)delegate;
/**
 查看对话，这个接口不翻页

 @param replyId  reply id
 @param ps       多少页，这个接口不翻页
 @param delegate delegate
 
 @return SBHttpDataLoader
 */
+ (SBHttpDataLoader *)sbget_article_view_conversation__withDialogId:(NSString *)dialogId ps:(NSUInteger)ps delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 主帖转发列表
 
 @param postId   主帖id
 @param p        页码
 @param sort     排序
 @param delegate delegate
 
 @return SBHttpDataLoader
 */
+ (SBHttpDataLoader *)sbget_article_repostsWithPostId:(NSString *)postId
                                                     p:(NSInteger)p
                                              delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 *  关注人回复汇总
 *
 *  @return
 */
+ (SBHttpDataLoader *)sbget_myUser_replyWithPage:(NSInteger)p
                                       delegate:(id<SBHttpDataLoaderDelegate>)delegate;
/**
 *  只看楼主
 *
 *  @param mainpostid 主帖id 
 *  @param p        页码
 */
+ (SBHttpDataLoader *)sbget_view_author__withPostId:(NSString *)mainpostid
                                                  sort:(SBV3ReplysSort)sort
                                                   p:(NSInteger)p
                                                 uid:(NSString *)uid
                                            delegate:(id<SBHttpDataLoaderDelegate>)delegate;


/**
 *  用户收到的评论列表
 *
 *  @param p        页码
 */
+ (SBHttpDataLoader *)sbget_user_recieve_replys:(NSInteger)p
                                delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 *  用户的评论列表
 *
 *  @param p        页码
 *  uid 为空则为自己
 */
+ (SBHttpDataLoader *)sbget_user_post_replys:(NSInteger)p
                                         uid:(NSString *)uid
                                    delegate:(id<SBHttpDataLoaderDelegate>)delegate;


/**
 *  转帖正文html
 *
 *  @param mainpostid 帖子id
 */
+ (SBHttpDataLoader *)sbget_repost_article_content_html:(NSString *)mainpostid
                                         delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 *  根据内容搜索帖子
 *
 *  @param text     内容
 *  @param p        页码
 */
+ (SBHttpDataLoader *)sbget_search_articles_by_content:(NSString *)text
                                                      p:(NSInteger)p
                                                delegate:(id<SBHttpDataLoaderDelegate>)delegate;


/**
 *  根据作者搜索帖子
 *
 *  @param text     作者
 *  @param p        页码
 */
+ (SBHttpDataLoader *)sbget_search_articles_by_author:(NSString *)text
                                                     p:(NSInteger)p
                                      delegate:(id<SBHttpDataLoaderDelegate>)delegate;


/**
 *  根据标题搜索帖子
 *
 *  @param text     内容
 *  @param p        页码
 */
+ (SBHttpDataLoader *)sbget_search_articles_by_title:(NSString *)text
                                                    p:(NSInteger)p
                                      delegate:(id<SBHttpDataLoaderDelegate>)delegate;


#pragma mark - 2.2 股吧
/**
 *  股吧信息
 *
 *  @param code        股票代码
 */
+ (SBHttpDataLoader *)sbget_sb_info:(NSString *)code
                                    delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 *  股吧热门帖子
 *
 *  @param p            页码
 */
+ (SBHttpDataLoader *)sbget_sb_hot_articles:(NSInteger)p
                                    delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 *  热门股吧
 *
 *  @param p            页码
 */
+ (SBHttpDataLoader *)sbget_hot_sbs:(NSInteger)p
                                    delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 *  热门主题吧
 *
 *  @param p            页码
 */
+ (SBHttpDataLoader *)sbget_hot_tbs:(NSInteger)p
                            delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 *  账户收藏的股吧列表
 *
 *  @param p       页码
 */
+ (SBHttpDataLoader *)sbget_user_collected_tbs:(NSInteger)p
                                         userid:(NSString *)uid
                                       delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 *  账户关注的股吧列表
 *
 *  @param p       页码
 */
+ (SBHttpDataLoader *)sbget_user_collected_sbs:(NSInteger)p
                                         userid:(NSString *)uid
                                       delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 *  账户关注的股吧最新发帖列表
 *
 *  @param p       页码
 */
+ (SBHttpDataLoader *)sbget_user_follow_sbs_articles:(NSInteger)p
                                       delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 *  用户关注的股吧发帖列表
 *
 *  @param p        页码
 */
+ (SBHttpDataLoader *)sbget_follow_sbs_articles:(NSInteger)p
                                             delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 *  股吧的粉丝列表
 *
 *  @param code        股票代码
 *  @param p        页码
 */
+ (SBHttpDataLoader *)sbget_sb_fans:(NSString *)code
                                   p:(NSInteger)p
                            delegate:(id<SBHttpDataLoaderDelegate>)delegate ;

/**
 *  搜索股吧
 *
 *  @param text     作者
 *  @param p        页码
 */
+ (SBHttpDataLoader *)sbget_search_sbs:(NSString *)text
                                      p:(NSInteger)p
                            delegate:(id<SBHttpDataLoaderDelegate>)delegate;

#pragma mark - 2.3 图片
#pragma mark - 2.4 推荐
/**
 *  活跃用户
 */
+ (SBHttpDataLoader *)sbget_active_users:(NSString *)rand delegate:(id<SBHttpDataLoaderDelegate>)delegate;
/**
 *  知名用户
 */
+ (SBHttpDataLoader *)sbget_famous_users:(NSString *)rand delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 *  可能感兴趣的人
 */
+ (SBHttpDataLoader *)sbget_interest_users:(int)pageSize pageAt:(int)p delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 *  推荐股友
 */
+ (SBHttpDataLoader *)sbget_recommend_users:(NSString *)rand pageSize:(int)pageSize delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 *  高手看盘
 */
+ (SBHttpDataLoader *)sbget_masterviews_users:(NSInteger)pageSize  delegate:(id<SBHttpDataLoaderDelegate>)delegate ;

#pragma mark - 2.5 用户
/**
 *  用户信息
 *
 *  @param followuid 用户id
 */
+ (SBHttpDataLoader *)sbget_user_info:(NSString *)followuid
                              delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 *  用户收到的评论
 *
 *  @param p        页码
 */
+ (SBHttpDataLoader *)sbget_recived_user_replys:(NSInteger)p
                                     delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 *  at到用户的主帖
 *
 *  @param p        页码
 */
+ (SBHttpDataLoader *)sbget_at_user_articles:(NSInteger)p
                              delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 *  at到用户的回复
 *
 *  @param p        页码
 */
+ (SBHttpDataLoader *)sbget_at_user_replys:(NSInteger)p
                                     delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 *  用户的粉丝
 *
 *  @param followuid 用户id
 *  @param p         页码
 */
+ (SBHttpDataLoader *)sbget_user_fans:(NSString *)followuid
                                        p:(NSInteger)p
                                   delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 *  用户关注的人
 *
 *  @param followuid 用户id
 *  @param p         页码
 */
+ (SBHttpDataLoader *)sbget_user_follow_users:(NSString *)followuid
                                        p:(NSInteger)p
                                      delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 *  互相关注的人
 *
 *  注：互相关注的粉丝是一次性获取完毕
 */
+ (SBHttpDataLoader *)sbget_each_follow_users:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 *  股友列表
 *
 *  @param ids      用户id "," 分隔
 *  @param source   股友来源
 */
+ (SBHttpDataLoader *)sbget_bar_friend_list:(NSArray *)ids source:(SBV3InviteSource)source delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 *  新帖消息数量
 *
 *  @param lastnewid    新帖
 *  @param hotId        热帖
 *  @param userStatusid 关注人帖
 *  @param replyId      回复
 *  @return
 */
+ (SBHttpDataLoader *)sbget_message_count:(NSString *)lastnewid
                                lastHotId:(NSString *)hotId
                         lastuserStatusid:(NSString *)userStatusid
                              lastReplyId:(NSString *)replyId
                                 delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 *  广告栏
 */
+ (SBHttpDataLoader *)sbget_banner_list:(id<SBHttpDataLoaderDelegate>)delegate;


/**
 * 	动态布告栏
 */
+ (SBHttpDataLoader *)sbget_multiple_banner_list:(NSString *)rand delegate:(id<SBHttpDataLoaderDelegate>)delegate;

#pragma mark - 写接口
#pragma mark - 3.1 文章
/**
 *  取消收藏主帖
 *
 *  @param mainpostid 主帖id
 */
+ (SBHttpDataLoader *)sbset_dis_collect_article:(NSString *)mainpostid
                                           type:(NSString *)type
                                        delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 *  收藏主帖
 *
 *  @param mainpostid 主帖id
 */
+ (SBHttpDataLoader *)sbset_collect_article:(NSString *)mainpostid
                                       type:(NSString *)type
                                        delegate:(id<SBHttpDataLoaderDelegate>)delegate;


/**
 *  赞帖子
 *
 *  @param p        页码
 */
+ (SBHttpDataLoader *)sbset_assist_article:(NSString *)postid
                                       code:(NSString *)code
                                         delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 *  赞帖子(类型通用)
 *  @param postid 主帖id
 *  @param type   主帖类型
 */
+ (SBHttpDataLoader *)sbset_praise_article:(NSString *)postid
                                       type:(SBV3ArticleType)type
                                   delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 *  取消赞帖子(类型通用)
 *  @param postid 主帖id
 *  @param type   主帖类型
 */
+ (SBHttpDataLoader *)sbset_cancel_praise_article:(NSString *)postid
                                       type:(SBV3ArticleType)type
                                   delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 *  赞回复(类型通用)
 *  @param postid 主帖id
 *  @param replyId 回复id
 *  @param type   主帖类型
 */
+ (SBHttpDataLoader *)sbset_praise_reply:(NSString *)postid
                                  replyId:(NSString *)replyid
                                       type:(SBV3ArticleType)type
                                   delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 *  取消赞回复(类型通用)
 *  @param postid 主帖id
 *  @param replyId 回复id
 *  @param type   主帖类型
 */
+ (SBHttpDataLoader *)sbset_cancel_praise_reply:(NSString *)postid
                                         replyId:(NSString *)replyid
                                              type:(SBV3ArticleType)type
                                          delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 *  取消赞帖子
 *
 *  @param p        页码
 */
+ (SBHttpDataLoader *)sbset_dis_assist_article:(NSString *)postid
                                           code:(NSString *)code
                                       delegate:(id<SBHttpDataLoaderDelegate>)delegate;
/**
 *  赞回复
 *
 *  @param p        页码
 */
+ (SBHttpDataLoader *)sbset_assist_reply:(NSString *)replyid
                                       postid:(NSString *)postid
                                   delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 *  取消赞回复
 *
 *  @param p        页码
 */
+ (SBHttpDataLoader *)sbset_dis_assist_reply:(NSString *)replyid
                                           postid:(NSString *)postid
                                       delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 回复帖子
 
 @param tid      要回复主题的ID（股吧回复必须要）
 @param newsId   新闻ID,字符串前加icom（回复帖子可不传，当不为空时，该接口为回复新闻，否则为回复帖子）
 @param type     1 摘要 0 新闻
 @param hid      子回复，没有不传
 @param text     内容
 @param isRepost 是否同时转发
 @param delegate delegate
 
 @return SBHttpDataLoader
 */
+ (SBHttpDataLoader *)sbset_reply_status:(NSString *)tid
                                             newsId:(NSString *)newsId
                                               type:(NSString *)type
                                            huifuId:(NSString *)hid
                                               text:(NSString *)text
                                           isRepost:(BOOL)isRepost
                             delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 回复帖子
 
 @param postId      帖子或新闻，公告，研报，投资组合id
 @param type     1 摘要 0 新闻
 @param huifuid   子回复，没有不传
 @param text     内容
 @param isRepost 是否同时转发
 @param t_type      0：普通帖，1：新闻，2：研报，3：公告，9：投资组合
 @param delegate delegate
 
 @return SBHttpDataLoader
 */
+ (SBHttpDataLoader *)sbset_articleReply_status:(NSString *)postId
                                         huifuId:(NSString *)hid
                                            text:(NSString *)text
                                        isRepost:(BOOL)isRepost
                                          t_type:(SBV3ArticleType)replyType
                                        delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 发新帖与转发统一接口
 
 @param code    股票代码
 @param text    内容
 @param pics    图片
 @param yid     原帖id
 @param isReply 是否同时评论
 
 @return SBHttpDataLoader
 */
+ (SBHttpDataLoader *)sbset_post_status:(NSString *)code
                                          text:(NSString *)text
                                          pics:(NSArray *)pics
                                           yid:(NSString *)yid
                                      is_reply:(BOOL)isReply delegate:(id<SBHttpDataLoaderDelegate>) delegate;



+(SBHttpDataLoader *)sbset_post_vote:(NSString*)code text:(NSString*)text pics:(NSArray *)pics voteOptions:(NSArray*)voteOptions singleSelect:(BOOL)singleSelect delegate:(id<SBHttpDataLoaderDelegate>) delegate;


/**
 *  发长博客
 *  title 帖子标题，为空时截取text40个字符
 *  text  帖子内容
 *  评论权限 0 可以回复  3, 该主题禁止回复
 */
+ (SBHttpDataLoader *)sbset_creat_blog:(NSString *)title
                                   text:(NSString *)text
                         replyauthority:(NSString *)replyauthority
                               delegate:(id<SBHttpDataLoaderDelegate>) delegate;


/**
 *  更新博客
 *  postid 博客帖子id
 *  text  帖子内容
 *  评论权限 0 可以回复  3, 该主题禁止回复
 */
+ (SBHttpDataLoader *)sbset_update_blog:(NSString *)postid
                                   text:(NSString *)text
                         replyauthority:(NSString *)replyauthority
                               delegate:(id<SBHttpDataLoaderDelegate>) delegate;

/**
 *  热门博客
 *  pageAt  页码
 *  type    类型
 */
+ (SBHttpDataLoader *)sbset_sepcial_blog_list:(NSInteger)pageAt
                                         type:(NSInteger)blogType
                                     delegate:(id<SBHttpDataLoaderDelegate>) delegate;

/**
 *  最新博客
 *
 */
+ (SBHttpDataLoader *)sbget_blog_articles:(NSInteger)p
                                 delegate:(id<SBHttpDataLoaderDelegate>)delegate;
/**
 *  博文点击榜
 *
 */
+ (SBHttpDataLoader *)sbget_MostClickBlogs:(NSInteger)p
                                  delegate:(id<SBHttpDataLoaderDelegate>)delegate ;


/**
 *  热门博主
 *
 */
+ (SBHttpDataLoader *)sbget_suggest_hotBlogUser:(NSInteger)p
                                       delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 *  删除帖子
 *
 *  @param postid 主帖id
 */
+ (SBHttpDataLoader *)sbset_delete_status:(NSString *)postid
                                  delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 *  关闭评论
 *
 *  @param postid 主帖id
 *  replyauthority  评论权限0 可以回复,1,该主题加V用户才能回复, 2,该主题注册用户才能回复,3, 该主题禁止回复
 */
+ (SBHttpDataLoader *)sbset_article_reply_authority:(NSString *)postid
                                     replyauthority:(int)authority
                                               type:(int)type
                                           delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 *  删除回复
 *
 *  @param postid 主帖id
 *  @param replyid 回复id
 */
+ (SBHttpDataLoader *)sbset_delete_reply:(NSString *)postid
                                         replyid:(NSString *)replyid
                                  delegate:(id<SBHttpDataLoaderDelegate>)delegate;

#pragma mark - 3.2 股吧
/**
 *  看涨或看跌
 *
 *  @param code 股票代码
 *  @param islow true 看跌  false 看涨
 */
+ (SBHttpDataLoader *)sbset_look_high_low:(NSString *)code
                                     islow:(BOOL)islow
                                   delegate:(id<SBHttpDataLoaderDelegate>)delegate;
/**
 *  取消收藏主题吧
 *
 *  @param code 主题吧id
 */
+ (SBHttpDataLoader *)sbset_dis_collect_tb:(NSString *)code
                                   delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 *  收藏主题吧
 *
 *  @param code 主题吧id
 */
+ (SBHttpDataLoader *)sbset_collect_tb:(NSString *)code
                               delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 *  取消关注股吧
 *
 *  @param code 股吧id
 */
+ (SBHttpDataLoader *)sbset_dis_follow_sb:(NSString *)code
                                  delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 *  关注股吧
 *
 *  @param code 股吧id
 */
+ (SBHttpDataLoader *)sbset_follow_sb:(NSString *)code
                              delegate:(id<SBHttpDataLoaderDelegate>)delegate;



#pragma mark - 3.3 用户
/**
 *  取消关注个人
 *
 *  @param code 股吧id
 */
+ (SBHttpDataLoader *)sbset_dis_follow_user:(NSString *)followuid
                                    delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 *  关注个人
 *
 *  @param code 股吧id
 */
+ (SBHttpDataLoader *)sbset_follow_user:(NSString *)followuid
                                delegate:(id<SBHttpDataLoaderDelegate>)delegate;



/**
 *  投票
 *
 *  @param postId           帖子id
 *  @param selectItemString 选项string
 */
+(SBHttpDataLoader *)sbset_write_vote_article:(NSString *)postId selectiteams:(NSString *)selectItemString delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 *  举报，
    个人或者帖子
 *
 */
+(SBHttpDataLoader *)sbset_report_postid:(NSString *)postid userid:(NSString *)userid type:(NSInteger)type content:(NSString *)content email:(NSString *)email phoneno:(NSString *)phoneno delegate:(id<SBHttpDataLoaderDelegate>)delegate ;

/**
 *  拉黑
 *  @param userid   用户id
 */
+(SBHttpDataLoader *)sbset_add_to_my_balcklist:(NSString *)userid delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 *  取消拉黑
 *  @param userid   用户id
 */
+(SBHttpDataLoader *)sbset_remove_from_my_balcklist:(NSString *)userid delegate:(id<SBHttpDataLoaderDelegate>)delegate;


/**
 *  获取黑名单
 *
 *  @param p        页码
 */
+(SBHttpDataLoader *)sbget_my_black_list:(NSInteger)p delegate:(id<SBHttpDataLoaderDelegate>)delegate;


/**
 *  是否我的黑名单
 */
+(SBHttpDataLoader *)sbget_user_setting_is_my_black_user:(NSString *)uid delegate:(id<SBHttpDataLoaderDelegate>)delegate;


/**
 *  是否有权限查看他人自选股
 */
+(SBHttpDataLoader *)sbget_user_setting_has_auth_for_other_follow:(NSString *)uid delegate:(id<SBHttpDataLoaderDelegate>)delegete;

/**
 *  查看自选权限
 *
 */
+(SBHttpDataLoader *)sbget_my_follow_guba_list_authority:(id<SBHttpDataLoaderDelegate>)delegate;


/**
 *  设置自选权限
 */
+(SBHttpDataLoader *)sbset_my_follow_guba_list_authority:(NSInteger)type delegate:(id<SBHttpDataLoaderDelegate>)delegate;


/**
 *  股吧总版热帖列表
 *
 *  @param p        页码
 *  @param sortType        0：发帖时间倒序 1：回复时间倒序
 */
+ (SBHttpDataLoader *)sbget_hot_posts_list:(NSInteger)p
                                  sortType:(NSInteger)sorttype
                                  delegate:(id<SBHttpDataLoaderDelegate>)delegate;

/**
 *  发现热帖观点
 *
 *  @param p        页码
 */
+ (SBHttpDataLoader *)sbget_mostHot_article_list:(NSInteger)p
                                  delegate:(id<SBHttpDataLoaderDelegate>)delegate;
@end
