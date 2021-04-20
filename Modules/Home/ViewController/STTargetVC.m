#import "STTargetVC.h"
#import "STCalenderHeaderView.h"
#import "STTargetTableViewCell.h"
#import "STTargetDetailVC.h"
#import "STCalendarViewModel.h"
#import "STTargetManage.h"
static NSString* const kSTTargetCell = @"cell";
NSString* const kTargetListChangeNotification = @"targetListChangeNotification";
@interface STTargetVC () <STCalenderHeaderViewDelegate, UITableViewDelegate, UITableViewDataSource, MGSwipeTableCellDelegate, STTargetTableViewCellDelegate>
@property (nonatomic, strong) STCalenderHeaderView* headerView;
@property (nonatomic, strong) UITableView* tableView;
@property (strong, nonatomic) STCalendarViewModel *calendarViewModel;
@property (strong, nonatomic) STTargetManage *targetManage;
@property (copy, nonatomic) NSString *yearMonthDay; 
@end
@implementation STTargetVC
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
    self.title = @"My Plan";
}
- (void)setupView {
    self.view.backgroundColor = [UIColor ST_mainGrayColor];
    [self.view addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(72);
    }];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(self.headerView.mas_bottom);
    }];
}
- (void)reloadView {
}
#pragma mark - 3.Request Data
- (void)setupData {
    [self.calendarViewModel updateTarget];
}
#pragma mark - 4.UITableViewDataSource and UITableViewDelegate
#pragma mark - UITableView Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.targetManage.viewModel.currentDaylistArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    STTargetTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:kSTTargetCell forIndexPath:indexPath];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"STTargetTableViewCell" owner:nil options:nil].lastObject;
    }
    STTargetModel* model = self.targetManage.viewModel.currentDaylistArray[indexPath.row];
    [cell setModel:model];
    cell.delegate = self;
    cell.rightButtons = @[[MGSwipeButton buttonWithTitle:@"Edit" backgroundColor:[UIColor blueColor]],
                          [MGSwipeButton buttonWithTitle:@"Delete" backgroundColor:[UIColor redColor]]
                          ];
    cell.leftSwipeSettings.transition = MGSwipeTransitionDrag;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 85;
}
#pragma mark - STTargetTableViewCellDelegate
- (void)onTouchFinishModel:(STTargetModel *)model {
    BOOL isfinish = [self.targetManage checkoutFinishStatus:model];
    if (isfinish) {
        UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"Tips" message:@"Are you sure you want to cancel this check-in?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancle" style:UIAlertActionStyleCancel handler:nil];
        @weakify(self)
        UIAlertAction* confirm = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            @strongify(self)
            [self.targetManage cancelFnishTargetModel:model];
            MDCSnackbarManager* manager = [MDCSnackbarManager defaultManager];
            MDCSnackbarMessage* meesage = [MDCSnackbarMessage messageWithText:@"This check-in has been cancelled"];
            [manager showMessage:meesage];
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:confirm];
        [self presentViewController:alertController animated:YES completion:nil];
    } else {
        [self.targetManage finishTargetModel:model];
        MDCSnackbarManager* manager = [MDCSnackbarManager defaultManager];
        MDCSnackbarMessage* meesage = [MDCSnackbarMessage messageWithText:@"Check in successfully"];
        [manager showMessage:meesage];
    }
}
#pragma mark - MGSwipeTableCellDelegate
- (BOOL)swipeTableCell:(MGSwipeTableCell *)cell tappedButtonAtIndex:(NSInteger)index direction:(MGSwipeDirection)direction fromExpansion:(BOOL)fromExpansion {
    STTargetTableViewCell* STCell = (STTargetTableViewCell* )cell;
    STTargetModel* model = STCell.model;
    switch (index) {
        case 1:{ 
            UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"Tips" message:@"Are you sure you want to delete this goal? Unable to restore!" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancle" style:UIAlertActionStyleCancel handler:nil];
            @weakify(self)
            UIAlertAction* confirm = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                @strongify(self)
                [self.targetManage removeTargetModel:model];
                MDCSnackbarManager* manager = [MDCSnackbarManager defaultManager];
                MDCSnackbarMessage* meesage = [MDCSnackbarMessage messageWithText:@"This goal has been deleted!"];
                [manager showMessage:meesage];
            }];
            [alertController addAction:cancelAction];
            [alertController addAction:confirm];
            [self presentViewController:alertController animated:YES completion:nil];
        }
            break;
        case 0:{ 
            STAddTargetVC* editTargetVC = [[STAddTargetVC alloc] init];
            editTargetVC.model = model;
            editTargetVC.edit = YES;
            [self.navigationController pushViewController:editTargetVC animated:YES];
        }
        default:
            break;
    }
    return YES;
}
#pragma mark - UITableView Delegate methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    STTargetModel* model = self.targetManage.viewModel.currentDaylistArray[indexPath.row];
    STTargetDetailVC* targetDetailVC = [[STTargetDetailVC alloc] init];
    targetDetailVC.model = model;
    [self.navigationController pushViewController:targetDetailVC animated:YES];
}
#pragma mark -- STCalenderHeaderViewDelegate
- (void)onTouchCalenderHeaderViewIndex:(NSInteger)index {
    NSLog(@"切换日期");
}
#pragma mark - 5.Event Response
#pragma mark - 6.Private Methods
- (void)setupNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(targetListChangeNotification:) name:kTargetListChangeNotification object:nil];
}
- (void)targetListChangeNotification:(id)sender {
    [self.tableView reloadData];
}
#pragma mark - 7.GET & SET
- (STCalenderHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[STCalenderHeaderView alloc] init];
        _headerView.backgroundColor = [UIColor whiteColor];
    }
    return _headerView;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:@"STTargetTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kSTTargetCell];
         _tableView.backgroundColor = [UIColor ST_mainGrayColor];
         _tableView.delegate = self;
         _tableView.dataSource = self;
         _tableView.tableFooterView = [[UIView alloc] init];
         _tableView.tableHeaderView = [[UIView alloc] init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
     }
         return _tableView;
 }
- (STCalendarViewModel *)calendarViewModel {
    if (!_calendarViewModel) {
        _calendarViewModel = [[STCalendarViewModel alloc] init];
    }
    return _calendarViewModel;
}
- (STTargetManage *)targetManage {
    if (!_targetManage) {
        _targetManage = [STTargetManage sharedInstance];
    }
    return _targetManage;
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
