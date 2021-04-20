#import "STMyCenterHeaderView.h"
@interface STMyCenterHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet MDCButton *settingButton;
@end
@implementation STMyCenterHeaderView
- (void)awakeFromNib {
    [super awakeFromNib];
    self.headImageView.backgroundColor = [UIColor ST_mainBlueColor];
    self.headImageView.layer.cornerRadius = 34;
    self.headImageView.layer.masksToBounds = YES;
    self.headImageView.image = [UIImage imageNamed:@"user"];
    self.nameLabel.font = [UIFont ST_fontSize:21];
    self.nameLabel.textColor = [UIColor ST_mainBlackColor];
    self.nameLabel.text = @"Jersey Bro";
    [self.settingButton setImage:[UIImage imageNamed:@"setting"] forState:UIControlStateNormal];
}
- (void)setModel:(STUserModel *)model {
    self.nameLabel.text = model.userName;
    if (STIsString(model.userImageView)) {
        NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSString* filePath = [NSString stringWithFormat:@"%@/%@.png", documentsDirectory, model.userImageView];
        self.headImageView.image = [UIImage imageWithContentsOfFile:filePath];
    } else {
        self.headImageView.image = [UIImage imageNamed:@"user"];
        NSLog(@"Use default");
    }
}
@end
