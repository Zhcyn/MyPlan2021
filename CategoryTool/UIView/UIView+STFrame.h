#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface UIView (STFrame)
- (CGFloat)ST_left;
- (void)ST_setleft:(CGFloat)x;
- (CGFloat)ST_top;
- (void)ST_settop:(CGFloat)y;
- (CGFloat)ST_right;
- (void)ST_setright:(CGFloat)right;
- (CGFloat)ST_bottom;
- (void)ST_setbottom:(CGFloat)bottom;
- (CGFloat)ST_width;
- (void)ST_setwidth:(CGFloat)width;
- (CGFloat)ST_height;
- (void)ST_setheight:(CGFloat)height;
- (CGPoint)ST_origin;
- (void)ST_setorigin:(CGPoint)origin;
- (CGSize)ST_size;
- (void)ST_setsize:(CGSize)size;
- (CGFloat)ST_centerX;
- (void)setcenterX:(CGFloat)centerX;
- (CGFloat)ST_centerY;
- (void)setcenterY:(CGFloat)centerY;
@end
NS_ASSUME_NONNULL_END
