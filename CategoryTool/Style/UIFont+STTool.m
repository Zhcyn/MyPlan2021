#import "UIFont+STTool.h"
static NSString* const kSTFontName = @"Helvetica Neue";
@implementation UIFont (STTool)
+ (UIFont *)ST_fontSize:(CGFloat)size {
    UIFont* font = [UIFont fontWithName:kSTFontName size:size];
    return font;
}
@end
