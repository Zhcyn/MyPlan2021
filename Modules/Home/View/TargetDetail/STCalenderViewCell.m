#import "STCalenderViewCell.h"
@interface STCalenderViewCell ()
@end
@implementation STCalenderViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.font = [UIFont ST_fontSize:16];
    self.titleLabel.textColor = [UIColor ST_mainBlackColor];
    self.titleLabel.text = @"Mon";
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.shouldHideSeparator = YES;
}
@end
