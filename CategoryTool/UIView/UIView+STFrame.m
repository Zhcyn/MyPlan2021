#import "UIView+STFrame.h"
@implementation UIView (STFrame)
- (CGFloat)ST_left {
    return self.frame.origin.x;
}
- (void)ST_setleft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (CGFloat)ST_top {
    return self.frame.origin.y;
}
- (void)ST_settop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (CGFloat)ST_right {
    return self.frame.origin.x + self.frame.size.width;
}
- (void)ST_setright:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}
- (CGFloat)ST_bottom {
    return self.frame.origin.y + self.frame.size.height;
}
- (void)ST_setbottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}
- (CGFloat)ST_width {
    return self.frame.size.width;
}
- (void)ST_setwidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (CGFloat)ST_height {
    return self.frame.size.height;
}
- (void)ST_setheight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (CGPoint)ST_origin {
    return self.frame.origin;
}
- (void)ST_setorigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}
- (CGSize)ST_size {
    return self.frame.size;
}
- (void)ST_setsize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
- (CGFloat)ST_centerX {
    return self.center.x;
}
- (void)setcenterX:(CGFloat)ST_centerX {
    self.center = CGPointMake(ST_centerX, self.center.y);
}
- (CGFloat)ST_centerY {
    return self.center.y;
}
- (void)setcenterY:(CGFloat)ST_centerY  {
    self.center = CGPointMake(self.center.x, ST_centerY);
}
@end
