#import "STPhotoManage.h"
#import <Photos/Photos.h>
NSString* const kSTPhotoImageFiles = @"PhotoImage/coffee_";
NSString* const kSTKitImageFiles = @"PhotoImage/kit_";
@interface STPhotoManage () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property(nonatomic, assign) STImagePickerSourceType sourceType;
@property (nonatomic, copy) void (^finishPicking)(UIImage *image);
@end
@implementation STPhotoManage
+ (instancetype)sharePhotoManage {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}
#pragma mark - Method
+ (void)presentWithViewController:(UIViewController *)viewController sourceType:(STImagePickerSourceType)sourceType finishPicking:(void (^)(UIImage *))finishPicking
{
    [STPhotoManage sharePhotoManage].sourceType = sourceType;
    [STPhotoManage sharePhotoManage].finishPicking = finishPicking;
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
    }];
    [[STPhotoManage sharePhotoManage] presentWithViewController:viewController];
}
#pragma mark - Private Method
- (void)presentWithViewController:(UIViewController *)viewController
{
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    switch (self.sourceType) {
        case STImagePickerSourceTypeCamera:
        {
            if (self.isCameraAvailable && [self doesCameraSupportTakingPhotos]) {
                controller.sourceType = UIImagePickerControllerSourceTypeCamera;
            } else {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Tips" message:@"This device does not support taking pictures" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
                return;
            }
        }
            break;
        case STImagePickerSourceTypePhotoLibrary: {
            controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
            break;
            case STImagePickerSourceTypePhotosAlbum:
            controller.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            break;
        default:
            controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
    }
    if (@available(iOS 11, *)) {
        controller.delegate = self;
        controller.allowsEditing = YES;
        [controller.navigationBar setTintColor:[UIColor ST_mainGrayColor]];
        [viewController presentViewController:controller animated:YES completion:nil];
    } else {
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusAuthorized) {
            controller.delegate = self;
            controller.allowsEditing = YES;
            [controller.navigationBar setTintColor:[UIColor ST_mainGrayColor]];
            [viewController presentViewController:controller animated:YES completion:nil];
        } else {
            UIAlertController* alertVC = [UIAlertController alertControllerWithTitle:@"Tips" message:@"Please click Go to Settings to enable the application album reading permission, otherwise the photos cannot be selected normally" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancle" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction* gotoAction = [UIAlertAction actionWithTitle:@"Go" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString: UIApplicationOpenSettingsURLString]];
            }];
            [alertVC addAction:cancelAction];
            [alertVC addAction:gotoAction];
            [STAppWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
        }
    }
}
- (void)clean
{
    self.sourceType = STImagePickerSourceTypePhotoLibrary;
    self.finishPicking = nil;
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusAuthorized) {
            UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
            self.finishPicking ? self.finishPicking(image) : NULL;
        } else {
            UIAlertController* alertVC = [UIAlertController alertControllerWithTitle:@"Tips" message:@"Please click Go to Settings to enable the application album reading permission, otherwise the photos cannot be selected normally" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancle" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction* gotoAction = [UIAlertAction actionWithTitle:@"Go" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString: UIApplicationOpenSettingsURLString]];
            }];
            [alertVC addAction:cancelAction];
            [alertVC addAction:gotoAction];
            [STAppWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
        }
    }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}
- (BOOL)isCameraAvailable
{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}
- (BOOL)isRearCameraAvailable
{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}
- (BOOL)isFrontCameraAvailable
{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}
- (BOOL)doesCameraSupportTakingPhotos
{
    return YES;
}
- (BOOL)isPhotoLibraryAvailable
{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL)canUserPickVideosFromPhotoLibrary
{
    return YES;
}
- (BOOL)canUserPickPhotosFromPhotoLibrary
{
    return YES;
}
- (BOOL)cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType
{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop = YES;
        }
    }];
    return result;
}
#pragma mark -- Image
+ (void)savaImageView:(UIImageView *)imageView fileName:(nonnull NSString *)fileName {
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString* filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, kSTPhotoImageFiles];
    NSFileManager* fileManage = [NSFileManager defaultManager];
    if (![fileManage fileExistsAtPath: filePath]) {
        BOOL isSuccess = [fileManage createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
        NSLog(@"isSiccess = %d",isSuccess);
    }
    NSData* data = UIImagePNGRepresentation(imageView.image);
    if (data) {
        NSError* error;
        NSString* imageName = [NSString stringWithFormat:@"%@/%@%@", documentsDirectory, kSTPhotoImageFiles, fileName];
        BOOL result = [data writeToFile:imageName options:NSDataWritingAtomic error: &error];
        if (error) {
            NSLog(@"Edn%d---%@", result, error);
        }
    } else {
        NSLog(@"Image conversion to PNG failed");
    }
}
+ (void)savaKitImageView:(UIImageView *)imageView fileName:(nonnull NSString *)fileName {
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString* filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, kSTKitImageFiles];
    NSFileManager* fileManage = [NSFileManager defaultManager];
    if (![fileManage fileExistsAtPath: filePath]) {
        BOOL isSuccess = [fileManage createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
        NSLog(@"isSiccess = %d",isSuccess);
    }
    NSData* data = UIImagePNGRepresentation(imageView.image);
    if (data) {
        NSError* error;
        NSString* imageName = [NSString stringWithFormat:@"%@/%@%@", documentsDirectory, kSTKitImageFiles, fileName];
        BOOL result = [data writeToFile:imageName options:NSDataWritingAtomic error: &error];
        if (error) {
            NSLog(@"end %d---%@", result, error);
        }
    } else {
        NSLog(@"Image conversion to PNG failed");
    }
}
@end
