#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
extern NSString* const kSTPhotoImageFiles;
extern NSString* const kSTKitImageFiles;
typedef NS_ENUM(NSInteger, STImagePickerSourceType) {
    STImagePickerSourceTypePhotoLibrary = 0,
    STImagePickerSourceTypeCamera,
    STImagePickerSourceTypePhotosAlbum,
};
@interface STPhotoManage : NSObject
+ (void)presentWithViewController:(UIViewController *)viewController
                       sourceType:(STImagePickerSourceType)sourceType
                    finishPicking:(void (^)(UIImage *image))finishPicking;
+ (void)savaImageView:(UIImageView *)imageView fileName:(NSString *)fileName;
+ (void)savaKitImageView:(UIImageView *)imageView fileName:(nonnull NSString *)fileName;
@end
NS_ASSUME_NONNULL_END
