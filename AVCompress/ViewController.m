//
//  ViewController.m
//  AVCompress
//
//  Created by zhifanYoung on 16/6/27.
//  Copyright © 2016年 zhifanYoung. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation ViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    UIImagePickerController *imgPicVc = [[UIImagePickerController alloc] init];
    imgPicVc.delegate = self;
    imgPicVc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    imgPicVc.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    
    [self presentViewController:imgPicVc animated:YES completion:nil];
}

// 选择视频
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {

    NSLog(@"%@", info);
    [picker dismissViewControllerAnimated:YES completion: nil];
    [self compressingMovie:info[UIImagePickerControllerMediaURL]];
}

// 压缩视频
- (void)compressingMovie:(NSURL *)url {
    
    AVAsset *asset = [AVAsset assetWithURL:url];
    
    /** 
     压缩质量
     AVAssetExportPresetLowQuality
     AVAssetExportPresetMediumQuality
     AVAssetExportPresetHighestQuality
     */
    
    AVAssetExportSession *session = [[AVAssetExportSession alloc]initWithAsset:asset presetName:AVAssetExportPresetLowQuality];
    
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"123.mov"];
    
    [[NSFileManager defaultManager]removeItemAtPath:path error:nil];
    
    session.outputURL = [NSURL fileURLWithPath:path];

    session.outputFileType = AVFileTypeQuickTimeMovie;
    
    [session exportAsynchronouslyWithCompletionHandler:^{
        
        NSLog(@"导出完成! %@", [NSThread currentThread]);
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
