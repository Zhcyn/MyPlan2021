#import "UIColor+STTool.h"
@implementation UIColor (STTool)
+ (UIColor *)ST_mainGrayColor {
    return [UIColor ST_colorWithHexString:@"#f5f4f9"];
}
+ (UIColor *)ST_grayColor {
    return [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
}
+ (UIColor *)ST_tealcolor {
    return [UIColor ST_colorWithHexString:@"#1AAA8C"];
}
+ (UIColor *)ST_skyBluecolor {
    return [UIColor ST_colorWithHexString:@"#1296db"];
}
+ (UIColor *)ST_mainBlueColor {
    return [UIColor ST_colorWithHexString:@"#2EA2F5"];
}
#pragma mark -- Text Color
+ (UIColor *)ST_mainTextColor {
    return [UIColor colorWithRed:30/255.0 green:23/255.0 blue:13/255.0 alpha:1.0];
}
+ (UIColor *)ST_minorTextColor {
    return [UIColor colorWithRed:113/255.0 green:120/255.0 blue:130/255.0 alpha:1.0];
}
+ (UIColor *)ST_detailTextColor {
    return [UIColor colorWithRed:113/255.0 green:120/255.0 blue:130/255.0 alpha:1.0];
}
#pragma mark - Title Color
+ (UIColor *)ST_mainBlackColor {
    return [UIColor ST_colorWithHexString:@"#333333"];
}
+ (UIColor *)ST_subTitleColor {
    return [UIColor ST_colorWithHexString:@"#999999"];
}
+ (CAGradientLayer *)ST_setGradualChangeView:(UIView *)view fromColor:(NSString *)fromHexColorStr toColor:(NSString *)toHexColorStr{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = view.bounds;
    gradientLayer.colors = @[(__bridge id)[UIColor whiteColor].CGColor, (__bridge id)[UIColor blackColor].CGColor];
    gradientLayer.startPoint = CGPointMake(0, 1);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.locations = @[@0.0,@1.0];
    return gradientLayer;
}
+ (UIColor *)ST_colorWithHexString:(NSString *)color {
    if (color == nil || color == NULL) {
        return [UIColor clearColor];;
    }
    if ([color isKindOfClass:[NSNull class]]) {
        return [UIColor clearColor];;
    }
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0) green:((float) g / 255.0) blue:((float) b / 255.0) alpha:1.0];
}
@end
