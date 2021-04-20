#import "STTargetTableViewCell.h"
@interface STTargetTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *targetImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *finishButton;
@end
@implementation STTargetTableViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.font = [UIFont ST_fontSize:18];
    self.titleLabel.textColor = [UIColor ST_mainBlackColor];
    self.subtitleLabel.font = [UIFont ST_fontSize:12];
    self.subtitleLabel.textColor = [UIColor ST_colorWithHexString:@"#999999"];
    [self.finishButton addTarget:self action:@selector(onTouchButton:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)setFrame:(CGRect)frame{
    frame.origin.x += 10;
    frame.origin.y += 10;
    frame.size.height -= 10;
    frame.size.width -= 20;
    [super setFrame:frame];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    self.layer.shadowColor = [UIColor colorWithRed:165/255.0 green:177/255.0 blue:201/255.0 alpha:0.3].CGColor;
    self.layer.shadowOffset = CGSizeMake(0,1);
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = 6;
    self.layer.cornerRadius = 10;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)setModel:(STTargetModel *)model {
    _model = model;
    self.targetImageView.image = [UIImage imageNamed:model.imageView];
    self.titleLabel.text = model.title;
    self.subtitleLabel.text = model.encourage;
    [self setupFinish];
}
- (void)onTouchButton:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(onTouchFinishModel:)]) {
        [self.delegate onTouchFinishModel:self.model];
    }
}
- (void)setupFinish {
    BOOL isFinish;
    if ([[self.model.finishrecordS.firstObject allKeys] containsObject:self.yearMonthDay]) {
        NSNumber* isFinishNumber = [self.model.finishrecordS.firstObject objectForKey:self.yearMonthDay];
        isFinish = isFinishNumber.boolValue;
    } else {
        isFinish = NO;
    }
    NSString* finishImageName = isFinish ? @"target_finish_complete": @"target_finish_normal";
    [self.finishButton setImage:[UIImage imageNamed:finishImageName] forState:UIControlStateNormal];
}
- (NSString *)yearMonthDay {
    if (!_yearMonthDay) {
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd";
        _yearMonthDay = [formatter stringFromDate:[NSDate date]];
    }
    return _yearMonthDay;
}
@end
