#import "STTargetDetailVC.h"
#import "STCalendarVC.h"
NSString* const kTargetCalenderShow = @"kTargetCalenderShow";
NSString* const kTargetCalenderHide = @"kTargetCalenderHide";
@interface STTargetDetailVC ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *scrollContentView;
@property (weak, nonatomic) IBOutlet UILabel *sayingLabel;
@property (weak, nonatomic) IBOutlet UIView *allFinishView;
@property (weak, nonatomic) IBOutlet UIView *monthFinishView;
@property (weak, nonatomic) IBOutlet UIView *calendarView;
@property (strong, nonatomic) STCalendarVC *calendarVC;
@property (weak, nonatomic) IBOutlet UILabel *totalTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthTitleLabel;
@end
@implementation STTargetDetailVC
#pragma mark - 1.View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBar];
    [self setupView];
    [self setupData];
    [self setupNotification];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
#pragma mark - 2.SettingView and Style
- (void)setupNavBar {
    self.title = @"Target details";
    if (self.model) {
        self.title = self.model.title;
    }
}
- (void)setupView {
    self.view.backgroundColor = [UIColor ST_mainGrayColor];
    self.scrollView.backgroundColor = [UIColor ST_mainGrayColor];
    self.scrollContentView.backgroundColor = [UIColor ST_mainGrayColor];
    self.sayingLabel.font = [UIFont ST_fontSize:19];
    self.sayingLabel.textColor = [UIColor ST_mainBlackColor];
    self.allFinishView.backgroundColor = [UIColor whiteColor];
    self.allFinishView.layer.shadowColor = [UIColor colorWithRed:165/255.0 green:177/255.0 blue:201/255.0 alpha:0.3].CGColor;
    self.allFinishView.layer.shadowOffset = CGSizeMake(0,1);
    self.allFinishView.layer.shadowOpacity = 1;
    self.allFinishView.layer.shadowRadius = 6;
    self.allFinishView.layer.cornerRadius = 10;
    self.totalNumberLabel.font = [UIFont ST_fontSize:21];
    self.totalNumberLabel.textColor = [UIColor ST_mainBlackColor];
    self.totalTitleLabel.font = [UIFont ST_fontSize:12];
    self.totalTitleLabel.textColor = [UIColor ST_subTitleColor];
    self.totalTitleLabel.text = @"Cumulative number of punch cards";
    self.monthFinishView.backgroundColor = [UIColor whiteColor];
    self.monthFinishView.layer.shadowColor = [UIColor colorWithRed:165/255.0 green:177/255.0 blue:201/255.0 alpha:0.3].CGColor;
    self.monthFinishView.layer.shadowOffset = CGSizeMake(0,1);
    self.monthFinishView.layer.shadowOpacity = 1;
    self.monthFinishView.layer.shadowRadius = 6;
    self.monthFinishView.layer.cornerRadius = 10;
    self.monthNumberLabel.font = [UIFont ST_fontSize:21];
    self.monthNumberLabel.textColor = [UIColor ST_mainBlackColor];
    self.monthTitleLabel.font = [UIFont ST_fontSize:12];
    self.monthTitleLabel.textColor = [UIColor ST_subTitleColor];
    self.monthTitleLabel.text = @"Number of check-ins this month";
    [self addChildViewController:self.calendarVC];
    self.calendarVC.model = self.model;
    [self.calendarView addSubview:self.calendarVC.view];
    [self.calendarVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    [self.calendarVC didMoveToParentViewController:self];
    self.calendarView.backgroundColor = [UIColor whiteColor];
    self.calendarView.layer.shadowColor = [UIColor colorWithRed:165/255.0 green:177/255.0 blue:201/255.0 alpha:0.3].CGColor;
    self.calendarView.layer.shadowOffset = CGSizeMake(0,1);
    self.calendarView.layer.shadowOpacity = 1;
    self.calendarView.layer.shadowRadius = 6;
    self.calendarView.layer.cornerRadius = 10;
    self.calendarView.layer.masksToBounds = YES;
}
- (void)reloadView {
}
#pragma mark - 3.Request Data
- (void)setupData {
    self.sayingLabel.text = self.model.encourage;
    self.totalNumberLabel.text = @(self.model.totalNumber).stringValue;
    self.monthNumberLabel.text = @(self.model.monthNumber).stringValue;
}
#pragma mark - 4.UITableViewDataSource and UITableViewDelegate
#pragma mark - 5.Event Response
#pragma mark - 6.Private Methods
- (void)setupNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(calenderHide:) name:kTargetCalenderHide object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(calenderShow:) name:kTargetCalenderShow object:nil];
}
- (void)calenderHide:(id)sender {
    self.totalNumberLabel.text = @(self.model.totalNumber).stringValue;
    self.monthNumberLabel.text = @"0";
}
- (void)calenderShow:(id)sender {
    self.totalNumberLabel.text = @(self.model.totalNumber).stringValue;
    self.monthNumberLabel.text = @(self.model.monthNumber).stringValue;
}
#pragma mark - 7.GET & SET
- (STCalendarVC *)calendarVC {
    if (!_calendarVC) {
        _calendarVC = [[STCalendarVC alloc] init];
    }
    return _calendarVC;
}
@end
