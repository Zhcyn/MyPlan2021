#import <MessageUI/MessageUI.h>
#import "STFeedBacksVC.h"
static NSString* const kFeedBackSussessTip = @"Thank you very much for using easy small goals, we will carefully review your feedback information, and try to improve it!";
static NSString* const kFeedBackTip = @"Thank you very much for your easy use of small goals, and you are welcome to provide us with any suggestions!";
static NSString* const kFeedBackEmail = @"lueliaosou54909@163.com";
static NSString* const kFeedBackEmailTitle = @"App feedback";
static NSString* const kFeedBackEmailSubTitle = @"Hi. Friend \n I found a problem while using the app.";
static NSString* const kFeedBackErrorTipTitle = @"Tips";
static NSString* const kFeedBackErrorTipSubTitle = @"Please open \"(Mail App)\" to set up your email account";
@interface STFeedBacksVC () <MFMailComposeViewControllerDelegate>
@property (nonatomic, strong) UILabel* tipLabel;
@property (nonatomic, strong) MDCRaisedButton* senderEmail;
@property (nonatomic, copy) NSString* emailText;
@end
@implementation STFeedBacksVC
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
    self.navigationItem.title = @"Feedback";
}
- (void)setupView {
    self.view.backgroundColor = [UIColor ST_grayColor];
    [self.view addSubview:self.tipLabel];
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
    }];
    self.senderEmail = [[MDCRaisedButton alloc] init];
    [self.senderEmail setTitle:@"send email" forState:UIControlStateNormal];
    [self.senderEmail addTarget:self action:@selector(onTouchSendEmail:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.senderEmail];
    [self.senderEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(self.tipLabel.mas_bottom).mas_equalTo(30);
    }];
    if ([MFMailComposeViewController canSendMail]) {
        [self setupEmailAction]; 
    }else{
        UIAlertView* alerView = [[UIAlertView alloc] initWithTitle:kFeedBackErrorTipTitle message:kFeedBackErrorTipSubTitle delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alerView show];
    }
}
-(void)setupEmailAction{
    MFMailComposeViewController *mailCompose = [[MFMailComposeViewController alloc] init];
    [mailCompose setMailComposeDelegate:self];
    [mailCompose setToRecipients:@[kFeedBackEmail]];
    [mailCompose setSubject:kFeedBackEmailTitle];
    NSString *emailContent = kFeedBackEmailSubTitle;
    [mailCompose setMessageBody:emailContent isHTML:NO];
    [self presentViewController:mailCompose animated:YES completion:nil];
}
- (void)reloadView {
}
#pragma mark - 3.Request Data
- (void)setupData {
}
#pragma mark - 4.UITableViewDataSource and UITableViewDelegate
#pragma mark - MFMailComposeViewControllerDelegate的代理方法：
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    switch (result) {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail send canceled: User canceled editing");
            [self dismissViewControllerAnimated:YES completion: ^{
            }];
            break;
        case MFMailComposeResultSaved:
            [self dismissViewControllerAnimated:YES completion: ^{
            }];
            break;
        case MFMailComposeResultSent: {
            NSLog(@"Mail sent: User clicks to send");
            MDCSnackbarManager* manager = [MDCSnackbarManager defaultManager];
            MDCSnackbarMessage* message = [MDCSnackbarMessage messageWithText: kFeedBackSussessTip];
            [self dismissViewControllerAnimated:YES completion: ^{
                [manager showMessage:message];
            }];
            break;
        }
        case MFMailComposeResultFailed:
            NSLog(@"Mail send errored: %@ : User failed to save or send mail", [error localizedDescription]);
            break;
    }
}
#pragma mark - 5.Event Response
- (void)onTouchSendEmail:(id) sender {
    if ([MFMailComposeViewController canSendMail]) {
        [self setupEmailAction]; 
    }else{
        UIAlertView* alerView = [[UIAlertView alloc] initWithTitle:kFeedBackErrorTipTitle message:kFeedBackErrorTipSubTitle delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alerView show];
    }
}
#pragma mark - 6.Private Methods
- (void)setupNotification {
}
#pragma mark - 7.GET & SET
- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.font = [UIFont systemFontOfSize:20];
        _tipLabel.numberOfLines = 0;
        _tipLabel.text = kFeedBackTip;
    }
    return _tipLabel;
}
@end
