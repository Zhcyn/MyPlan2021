#import "STCalenderHeaderView.h"
#import "STStackView.h"
#import "STCalendersubView.h"
#import "STTargetDetailVC.h"
#import "STCalendarViewModel.h"
@interface STCalenderHeaderView ()
@property (nonatomic, strong) STStackView* stackView;
@property (nonatomic, strong) UIButton* stackButton;
@property (strong, nonatomic) NSArray *weekArray;
@property (strong, nonatomic) STCalendarViewModel *viewModel;
@end
@implementation STCalenderHeaderView
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}
- (void)setupView {
    [self.viewModel updateTarget];
    self.stackView = [[STStackView alloc] init];
    [self addSubview:self.stackView];
    [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    [self.stackButton addTarget:self action:@selector(onTouchStackView:) forControlEvents:UIControlEventTouchUpInside];
    for (NSInteger i = 0; i < 7; i++) {
        STCalendersubView* subView = [[STCalendersubView alloc] init];
        if (i == 3) {
            [subView isShow];
        }
        [self.stackView addArrangedSubview:subView];
        subView.weekLabel.text = [self.viewModel.targetWeekDaysDic objectForKey:self.viewModel.targetWeekDays[i]];
        [subView.calenderButton setTitle:self.viewModel.targetDays[i] forState:UIControlStateNormal];
        subView.calenderButton.tag = i;
        subView.calenderButton.userInteractionEnabled = YES;
        [subView.calenderButton addTarget:self action:@selector(onTouchStackButton:) forControlEvents:UIControlEventTouchUpInside];
    }
}
- (void)onTouchStackView:(id)sender {
}
- (void)onTouchStackButton:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(onTouchCalenderHeaderViewIndex:)]) {
        [self.delegate onTouchCalenderHeaderViewIndex:sender.tag];
        for (NSInteger i = 0; i < 7; i++) {
            STCalendersubView* subView = self.stackView.subviews[i];
            if (sender.tag == i) {
                [subView isShow];
            }
        }
    }
}
- (NSArray *)weekArray {
    if (!_weekArray) {
        _weekArray = @[@"Sun",@"Mon",@"Tues",@"Wed",@"Thur",@"Fri",@"Sat"
                       ];
    }
    return _weekArray;
}
- (STCalendarViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[STCalendarViewModel alloc] init];
    }
    return _viewModel;
}
@end
