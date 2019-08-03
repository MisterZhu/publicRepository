//
//  MethodFactory.h
//  WatermelonEsports
//
//  Created by MCM on 2018/12/21.
//  Copyright © 2018年 xiguadianjing. All rights reserved.
//

typedef NS_ENUM(NSInteger,DateFormater){
    DateFormaterYYMDHms,
    DateFormaterMDHms,
    DateFormaterDHms,
    DateFormaterHms
};

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MethodFactory : NSObject

/**
 获取webView中的所有图片URL

 @param webString webString
 @return return ary
 */
+ (NSArray *) getImageurlFromHtml:(NSString *) webString;
/**
 压缩图片到指定大小
 
 @param maxLength 最大质量
 @param image image
 @return data
 */
+ (NSData *)compressQualityWithMaxLength:(NSInteger)maxLength withImageData:(UIImage *)image;
/**
 *  截取view生成一张图片
 *
 *  @param view view description
 *
 *  @return image
 */
+ (UIImage *)shotWithView:(UIView *)view;
/**
 设置圆角加阴影

 @param topView topView
 @param theColor theColor
 */
+ (void)addShadowToView:(UIView *)topView withColor:(UIColor *)theColor;

/**
 *  通过 CAShapeLayer 方式绘制虚线
 *
 *  param lineView:       需要绘制成虚线的view
 *  param lineLength:     虚线的宽度
 *  param lineSpacing:    虚线的间距
 *  param lineColor:      虚线的颜色
 *  param lineDirection   虚线的方向  YES 为水平方向， NO 为垂直方向
 **/
+ (void)drawLineOfDashByCAShapeLayer:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor lineDirection:(BOOL)isHorizonal;
/**
 i判断当前控制器是否正在显示
 
 @param viewController viewController
 @return bool
 */
+(BOOL)isCurrentViewControllerVisible:(UIViewController *)viewController;

/**
 *  获取当天的字符串
 *  @return 格式为年-月-日 时分秒
 */
+ (NSString *)getCurrentTimeyyyymmdd;

//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC;
//处理详情页面数据
+ (NSMutableDictionary *)handleWithResult:(NSDictionary *)dict;

//将字符串数组，按首字母分组，得到“字母”对“相应子字符串数组”的字典
+ (NSMutableDictionary *)getDicWithArray:(NSArray *)arrNames withKey:(NSString *)key;
//JSON字符串转化为字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
//日期截取
+ (NSString *)dateCutOutWithStr:(NSString *)dateStr;
#pragma mark ---------  nsdiction转json  ---------

+ (NSString *)rb_jsonStrFromDic:(NSDictionary *)dic;

#pragma mark ---------  检查是否登陆  ---------
+ (BOOL)isLoginWithController:(BaseViewController *)controller;

//返回固定格式uilabel的富文本
+ (NSAttributedString *)getSpaceLabelAttributedWithStr:(NSString *)content WithFont:(UIFont *)font;
//返回固定格式uilabel的高度
+(CGFloat)getSpaceLabelHeightWithContent:(NSString *)str withFont:(UIFont *)font withWidth:(NSInteger )width;
// 获取设备IP地址
+(NSString *)getIPAddress;
//通过两种颜色生成一张渐变色的图片
+ (UIImage*) BgImageFromColors:(NSArray*)colors withFrame: (CGRect)frame;

#pragma mark ---------  获取当前时间  ---------
+ (NSString *)getCurrentTime;

/**
 *  获取时间差值  截止时间-当前时间
 *  nowDateStr : 当前时间
 *  deadlineStr : 截止时间
 *  @return 时间戳差值
 */
+ (NSInteger)getDateDifferenceWithNowDateStr:(NSString*)nowDateStr deadlineStr:(NSString*)deadlineStr;


/**
 时间差(总秒数)

 @param nowDateStr 当前时间
 @param deadlineStr 开始时间

 @return 总秒数
 */
+ (NSInteger)getAbsoluteDateDifferenceWithNowDateStr:(NSString*)nowDateStr deadlineStr:(NSString*)deadlineStr;


#pragma mark ---------  通过字符串生成二维码图片  ---------
+ (UIImage *)qrImageForString:(NSString *)string imageSize:(CGFloat)Imagesize logoImageSize:(CGFloat)waterImagesize;

@end

NS_ASSUME_NONNULL_END
