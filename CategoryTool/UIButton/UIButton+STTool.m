#import "UIButton+STTool.h"
@implementation UIButton (STTool)
- (void)ST_setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
    [self setBackgroundImage: [UIImage ST_getImageWithColor:backgroundColor withSize:self.frame.size] forState:state];
}
@end
