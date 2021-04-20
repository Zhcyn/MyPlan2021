#import "STCalendersubView.h"
@interface STCalendersubView ()
@end
@implementation STCalendersubView
- (instancetype)init {
    self = [super init];
    if (self) {
        [self configuration];
    }
    return self;
}
- (void)configuration {
    self.weekLabel = [[UILabel alloc] init];
    [self.weekLabel setFont:[UIFont ST_fontSize:12]];
    [self.weekLabel setTextColor:[UIColor ST_colorWithHexString:@"#9CA5C4"]];
    self.weekLabel.text = @"Week";
    self.calenderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.calenderButton.titleLabel setFont:[UIFont ST_fontSize:13]];
    [self.calenderButton setTitleColor:[UIColor ST_colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    [self addSubview:self.weekLabel];
    [self addSubview:self.calenderButton];
    [self.weekLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.bottom.mas_equalTo(-12);
    }];
    [self.calenderButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(-5);
        make.width.height.mas_equalTo(32);
    }];
    [self.calenderButton setTitle:@"28" forState:UIControlStateNormal];
}
- (void)isShow {
    self.calenderButton.backgroundColor = [UIColor ST_colorWithHexString:@"#F5B853"];
    [self.calenderButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.calenderButton.layer.cornerRadius = 16;
    self.calenderButton.layer.masksToBounds = YES;
}
- (void)layoutSubviews {
    [super layoutSubviews];
}
@end
