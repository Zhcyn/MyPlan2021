#import "STCollectionViewCell.h"
@implementation STCollectionViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    self.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1].CGColor;
    self.layer.shadowOffset = CGSizeMake(0,1);
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = 4;
    self.layer.cornerRadius = 10;
}
- (void)setModel:(STMyCenterModel *)model {
    _model = model;
    if (model.imageName) {
        self.imageView.image = [UIImage imageNamed: model.imageName];
    }
    self.textLabel.text = model.title;
    if (STIsString(model.route)) {
        self.accessoryType = 1;
    } else {
        self.accessoryType = 0;
    }
}
- (void)layoutSubviews {
    [super layoutSubviews];
}
@end
