
// 0.账号相关的信息
#define CJAppKey @"3024216879"
#define CJAppSecret @"3227b9117b769892bca3b7b32dc1eb36"
#define CJRedirectURI @"https://www.baidu.com"

#define CJLoginURL [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",CJAppKey,CJRedirectURI]







// 1.判断是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

// 2.RGB颜色
#define CJColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 3.自定义Log
#ifdef DEBUG
#define CJLog(...) NSLog(__VA_ARGS__)
#else
#define CJLog(...)
#endif

// 4.是否为4英寸
#define fourInch ([UIScreen mainScreen].bounds.size.height == 568)





// 5.微博cell上的属性

/** 时间的字体 */
#define CJStatusTimeFont [UIFont systemFontOfSize:12]
/** 来源的字体 */
#define CJStatusSourceFont CJStatusTimeFont

/** 昵称的字体 */
#define CJStatusNameFont [UIFont systemFontOfSize:15]
/** 正文的字体 */
#define CJStatusContentFont CJStatusNameFont

/** 被转发微博的昵称的字体 */
#define CJRetweetNameFont [UIFont systemFontOfSize:13]
/** 被转发微博的正文的字体 */
#define CJRetweetContentFont CJRetweetNameFont

/** 整个tableView 的宽度 */
#define CJStatusTableBorder 5
/** cell的内边框宽度 */
#define CJStatusCellBorder 10





// 6.微博cell内部相册
#define CJPhotoW 70
#define CJPhotoH 70
#define CJPhotoMargin 10



