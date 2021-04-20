#import "STTargetHeaderReusableView.h"
@interface STTargetHeaderReusableView ()
@property (weak, nonatomic) IBOutlet UIView *headerContentView;
@property (weak, nonatomic) IBOutlet UIView *separateView;
@end
@implementation STTargetHeaderReusableView
- (void)awakeFromNib {
    [super awakeFromNib];
    [self.leftButton setImage:[UIImage ST_imageNamePNG:@"left"] forState:UIControlStateNormal];
    [self.rightButton setImage:[UIImage ST_imageNamePNG:@"right"] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont ST_fontSize:17];
    self.titleLabel.textColor = [UIColor ST_mainBlackColor];
    self.titleLabel.text = @"2021 4";
    NSCalendar* calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond|NSCalendarUnitWeekday fromDate:[NSDate date]];
    self.currentMonth = comps.month;
}
@end
