#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface UIColor (STTool)
+ (UIColor *)ST_colorWithHexString:(NSString *)color; 
+ (UIColor *)ST_grayColor;
+ (UIColor *)ST_tealcolor;
+ (UIColor *)ST_skyBluecolor;
+ (UIColor *)ST_mainBlueColor;
#pragma mark -Text Color
+ (UIColor *)ST_mainTextColor;
+ (UIColor *)ST_minorTextColor;
+ (UIColor *)ST_detailTextColor;
#pragma mark - Title Color
+ (UIColor *)ST_mainBlackColor;
+ (UIColor *)ST_subTitleColor;
+ (UIColor *)ST_mainGrayColor;
+ (CAGradientLayer *)ST_setGradualChangeView:(UIView *)view fromColor:(NSString *)fromHexColorStr toColor:(NSString *)toHexColorStr;
@end
NS_ASSUME_NONNULL_END
