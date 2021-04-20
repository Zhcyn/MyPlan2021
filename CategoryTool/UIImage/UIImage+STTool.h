#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface UIImage (STTool)
+ (instancetype)ST_imageNamePNG:(NSString *)namePNG;
+ (UIImage *)ST_getImageWithColor:(UIColor *)color withSize:(CGSize)size;
+ (UIImage *)ST_getImageWithColor:(UIColor *)color;
@end
NS_ASSUME_NONNULL_END
