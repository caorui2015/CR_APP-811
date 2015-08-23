

#import <UIKit/UIKit.h>

@interface UIView (Extension)

//可以轻松设置控件位置而不需要使用CGRectMake.....xxx
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;

@end
