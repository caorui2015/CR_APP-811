/*
 
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RequestPostUploadHelper : NSObject

/**
 *POST 提交 并可以上传图片目前只支持单张
 */
+ (NSData *)postRequestWithURL: (NSString *)url//远程host路径
                      postParems: (NSMutableDictionary *)postParems // 提交参数据集合
                      imageObject:(UIImage *)imageObject;//上传的图片对象
//                     picFilePath: (NSString *)picFilePath  //上传图片路径
//                     picFileName: (NSString *)picFileName;  //  上传图片名称


//根据文件名获取文件的全路径
+(NSString *)getFilePath:(NSString *)fileName;

@end