#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

/**
 *  自定义导航栏按钮
 *  @param imageName     普通状态下图片名称
 *  @param highImageName 高亮状态下图片名称
 *  @param target        谁调用就是谁
 *  @param action        事件
 *  @return UIBarButtonItem
 */
+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action;
@end
