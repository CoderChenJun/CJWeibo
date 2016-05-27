
// 1.判断是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

// 2.获得RGB颜色
#define IWColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 3.全局背景色
#define IWGlobalBg IWColor(232, 233, 232)

// 4.自定义Log
#ifdef DEBUG
#define IWLog(...) NSLog(__VA_ARGS__)
#else
#define IWLog(...)
#endif

// 5.颜色、字体常量
/** 导航栏 */
// 导航栏标题颜色
#define IWNavigationBarTitleColor IWColor(65, 65, 65)
// 导航栏标题字体
#define IWNavigationBarTitleFont [UIFont boldSystemFontOfSize:19]

// 导航栏按钮文字颜色
#define IWBarButtonTitleColor (iOS7 ? IWColor(239, 113, 0) : IWColor(119, 119, 119))
#define IWBarButtonTitleDisabledColor IWColor(208, 208, 208)

// 导航栏按钮文字字体
#define IWBarButtonTitleFont (iOS7 ? [UIFont systemFontOfSize:15] : [UIFont boldSystemFontOfSize:12])

// 6.常用的尺寸
/** 表格边框的宽度 */
extern const CGFloat IWTableBorderW;
/** cell之间的间距 */
extern const CGFloat IWCellMargin;

// 7.数据存储
#define IWUserDefaults [NSUserDefaults standardUserDefaults]
