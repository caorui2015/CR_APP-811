
#import "ATCommonFunction.h"

@implementation ATCommonFunction

+ (NSString *)ATGetselfPhotoPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"selfPhoto.png"];
}

+ (void)ATGetNsUserDefaultSetting
{
    NSDictionary* defaults = [[NSUserDefaults standardUserDefaults] dictionaryRepresentation];
    ATLog(@"Defaults-->: %@", defaults);
}

+ (BOOL)ATgetUserIsLogin
{
   NSString *islogin =  [[NSUserDefaults standardUserDefaults] objectForKey:@"isLogin"];
    if ([islogin isEqualToString:@"YES"]) {
        return YES;
    }else{
        return NO;
    }
}

+ (NSString *)ATgetUserName
{
   return [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
}

+ (NSString *)ATgetUserEmail
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"userEmail"];
}

+ (UIButton *)ATgetRoundImgae:(UIButton *)image iconWidth:(CGFloat)kIconWidth
{
    image.imageView.layer.cornerRadius= kIconWidth;//锚点越大图形越圆
    image.imageView.layer.masksToBounds= YES;
    return image;
}

@end
