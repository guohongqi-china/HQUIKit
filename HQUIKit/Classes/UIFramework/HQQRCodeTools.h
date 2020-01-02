//
//  HQQRCodeTools.h
//  ZTDJNewProj
//
//  Created by guohongqi on 2020/1/2.
//  Copyright © 2020 guohongqi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface HQQRCodeTools : NSObject

/**
 @abstract 绘制二维码
 @param content  二维码信息
 @param size    二维码尺寸
 */
+ (UIImage *)drawQRCodeWithContent:(NSString *)content imgSize:(CGFloat)size;
/**
@abstract 绘制二维码
@param content  二维码信息
@param size    二维码尺寸
@param logoImg logo img
*/
+ (UIImage *)drawQRCodeWithContent:(NSString *)content imgSize:(CGFloat)size withLogoImg:(UIImage *)logoImg;
/**
@abstract 绘制条形码
@param content  条形码信息
@param size    条形码尺寸
*/
+ (UIImage *)drawBarcodeImageWithContent:(NSString *)content codeImageSize:(CGSize)size red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;

@end

NS_ASSUME_NONNULL_END
