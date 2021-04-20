#import "STCalendarVC.h"
#import <MDCCollectionViewCell.h>
#import "STTargetHeaderReusableView.h"
#import "STCalenderViewCell.h"
#import "STCalendarViewModel.h"
#import <JTCalendar.h>
#import <FSCalendar.h>
@interface STCalendarVC ()
@property (nonatomic, strong) STTargetHeaderReusableView* headerView;
@property (nonatomic, strong) NSArray* weekArray;
@property (nonatomic, strong) STCalendarViewModel* viewModel;
@property (strong, nonatomic) STTargetManage *manage;
@property (assign, nonatomic) CGFloat cellWidthHeight;
@end
@implementation STCalendarVC
static NSString * const reuseIdentifier = @"Cell";
static NSString * const headerReuseIdentifier = @"header";
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
#pragma mark - 2.SettingView and Style
- (void)setupNavBar {
}
- (void)setupView {
    self.view.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerNib:[UINib nibWithNibName:@"STCalenderViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:reuseIdentifier];
    [self.view addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(70);
    }];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(self.headerView.mas_bottom);
    }];
    self.cellWidthHeight = ((ScreenWidth - 30) - (6 * 10) - 20) / 7;
    [self.collectionView reloadData];
}
- (void)reloadView {
}
#pragma mark - 3.Request Data
- (void)setupData {
    [self.viewModel update];
}
#pragma mark - 4.UITableViewDataSource and UITableViewDelegate
#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 7;
    } else {
        return (self.viewModel.titleArray.count + self.viewModel.index); 
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    STCalenderViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.titleLabel.text = self.weekArray[indexPath.item];
        cell.contentView.backgroundColor = [UIColor whiteColor];
    } else {
        if (indexPath.item >= self.viewModel.index) {
            cell.titleLabel.text = self.viewModel.titleArray[indexPath.row - self.viewModel.index]; 
            if (self.viewModel.isShowCurrentMonth) { 
                if (self.viewModel.dayIndex == indexPath.item) {
                    cell.contentView.backgroundColor = [UIColor ST_mainBlueColor];
                    NSLog(@"---zexidao%ld----------", indexPath.item);
                    BOOL isFinish = [self.manage checkoutFinishStatus:self.model];
                    if (isFinish) {
                        cell.titleLabel.textColor = [UIColor whiteColor];
                    } else {
                        cell.titleLabel.textColor = [UIColor ST_mainBlackColor];
                    }
                } else {
                    if (self.viewModel.isShowCurrentMonth) {
                        NSString* yearMonth = @"2021-04";
                        NSInteger day = indexPath.row - self.viewModel.index + 1;
                        NSString* dayString;
                        if (day < 10) {
                            dayString = [NSString stringWithFormat:@"0%ld", day];
                        } else {
                            dayString = @(day).stringValue;
                        }
                        NSString* yearMonthDay = [NSString stringWithFormat:@"%@-%@",yearMonth ,dayString];
                        BOOL isFinish = [self.manage checkoutFinishStatus:self.model yearMonthDay:yearMonthDay];
                        if (isFinish) {
                            cell.titleLabel.textColor = [UIColor ST_mainBlueColor];
                        } else {
                            cell.titleLabel.textColor = [UIColor ST_mainBlackColor];
                        }
                    } else {
                        cell.titleLabel.textColor = [UIColor ST_mainBlackColor];
                    }
                }
            } else {
                cell.contentView.backgroundColor = [UIColor whiteColor];
                cell.titleLabel.textColor = [UIColor ST_mainBlackColor];
            }
        } else {
            cell.titleLabel.text = nil;
        }
    }
    cell.layer.cornerRadius = self.cellWidthHeight / 2;
    cell.layer.masksToBounds = YES;
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.cellWidthHeight, self.cellWidthHeight);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
        return UIEdgeInsetsMake(0, 10, 10, 10);
    } else {
        return UIEdgeInsetsMake(0, 10, 15, 10);
    }
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
#pragma mark <UICollectionViewDelegate>
#pragma mark - 5.Event Response
- (void)onTouchHeaderViewLeftButton:(UIButton *)sender {
    [self.viewModel lastMonthd];
    [self.collectionView reloadData];
    self.headerView.titleLabel.text = [NSString stringWithFormat:@"%ld Year %ld Month", self.viewModel.year, self.viewModel.month];
    if (self.viewModel.month == 8) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kTargetCalenderShow object:nil];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:kTargetCalenderHide object:nil];
    }
}
- (void)onTouchHeaderViewRightButton:(UIButton *)sender {
    [self.viewModel nextMonthd];
    [self.collectionView reloadData];
    self.headerView.titleLabel.text = [NSString stringWithFormat:@"%ld Year %ld Month", self.viewModel.year, self.viewModel.month];
    if (self.viewModel.month == 8) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kTargetCalenderShow object:nil];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:kTargetCalenderHide object:nil];
    }
}
#pragma mark - 6.Private Methods
- (void)setupNotification {
}
#pragma mark - 7.GET & SET
- (STTargetHeaderReusableView *)headerView {
    if (!_headerView) {
        _headerView = [[NSBundle mainBundle] loadNibNamed:@"STTargetHeaderReusableView" owner:nil options:nil].lastObject;
        [_headerView.leftButton addTarget:self action:@selector(onTouchHeaderViewLeftButton:) forControlEvents:UIControlEventTouchUpInside];
        [_headerView.rightButton addTarget:self action:@selector(onTouchHeaderViewRightButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headerView;
}
- (NSArray *)weekArray {
    if (!_weekArray) {
        _weekArray = @[@"Sun",@"Mon",@"Tues",@"Wed",@"Thur",@"Fri",@"Sat",
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
- (STTargetManage *)manage {
    if (!_manage) {
        _manage = [STTargetManage sharedInstance];
    }
    return _manage;
}
@end
