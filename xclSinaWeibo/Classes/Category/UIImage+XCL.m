//
//  UIImage+XCL.m
//  xclSinaWeibo
//
//  Created by xiechanglei on 15/4/2.
//  Copyright (c) 2015年 谢长磊. All rights reserved.
//

#import "UIImage+XCL.h"

@implementation UIImage (XCL)

#pragma mark - 加载全屏的图片
//new_feature_1.png
+ (UIImage *)fullScreenImage:(NSString *)imgName {
//    1.判断  如果是iPhone5  那么就做特殊处理     如果不是iPhone5  那么就不用加 -568h@2x
    if (isIphone5) {
//        new_feature_1.png
//        1.获得文件拓展名
        NSString *ext = [imgName pathExtension];
        
//        2.删除文件最后面的拓展名
        imgName = [imgName stringByDeletingPathExtension];
        
//        3.拼接-568@2x
        imgName = [imgName stringByAppendingString:@"-568h@2x"];
        
//        4.拼接拓展名
        imgName = [imgName stringByAppendingPathExtension:ext];
        
        
        
    }
    return [self imageNamed:imgName];
}









@end
