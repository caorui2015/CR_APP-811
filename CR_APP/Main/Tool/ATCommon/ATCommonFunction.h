/*
     封装了一些全局常用的函数功能在里面
 */
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ATCommonFunction : NSObject


/**
 *  得到用户上传头像的保存路径
 *  @return 返回用户头像保存的地址
 */
+ (NSString *)ATGetselfPhotoPath;


/**
 *  获取设备上的所有的NSUserDefaults的设置
 */
+ (void)ATGetNsUserDefaultSetting;

/**
 *  获取用户是否登陆
 */
+ (BOOL)ATgetUserIsLogin;

/**
 *  获取登陆的用户名
 */
+(NSString *)ATgetUserName;

/**
 *  获取登陆用户的邮箱
 */
+(NSString *)ATgetUserEmail;

/**
 *  返回一张圆形的按钮图片
 */
+(UIButton *)ATgetRoundImgae:(UIButton *)image iconWidth:(CGFloat)kIconWidth;


@end
