//
//  ViewController.m
//  AutoLayout
//
//  Created by yunlian on 15/5/4.
//  Copyright (c) 2015年 yunlian. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic,strong) UIView *backgroundView;
@property (nonatomic,strong) UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    self.title = @"自动适配";
    
    UIButton *firstButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [firstButton setTitle:@"First"forState:UIControlStateNormal];
    [firstButton sizeToFit];
    [firstButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    firstButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:firstButton];
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:firstButton attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0f constant:20.f];
    
    constraint = [NSLayoutConstraint constraintWithItem:firstButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0f constant:100.f];
    
    [self.view addConstraint:constraint];
    
    UIButton *secondButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [secondButton setTitle:@"录制视频"forState:UIControlStateNormal];
    [secondButton sizeToFit];
    [secondButton addTarget:self action:@selector(videoRecord) forControlEvents:UIControlEventTouchUpInside];
    secondButton.translatesAutoresizingMaskIntoConstraints =NO;
    
    [self.view addSubview:secondButton];
    
    
    constraint = [NSLayoutConstraint constraintWithItem:secondButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0f constant:-40.f];
    
    [self.view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:secondButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f];
    
    [self.view addConstraint:constraint];
    
    
    
//    [self.view addSubview:self.backgroundView];
    
//    [self addConstraints];
//    
//    [self.view addSubview:self.label];
}



-(void)addConstraints
{
   //先注释掉，等有空找原因
    
//    id views = @{@"background": self.backgroundView};
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[background]|" options:0 metrics:nil views:views]];
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[background]|" options:0 metrics:nil views:views]];
    
    
    
//    id views = @{@"image": self.imageView, @"label": self.label};
//    id metrics = @{@"margin": @6};
//    
//    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-margin-[image]-margin-[label]-margin-|" options:NSLayoutFormatAlignAllCenterY metrics:metrics views:views]];
//    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-margin-[image]-margin-|" options:0 metrics:metrics views:views]];
}

- (UIView *)backgroundView
{
    if (!_backgroundView)
    {
        _backgroundView = [[UIView alloc] init];
        _backgroundView.backgroundColor = [UIColor redColor];
        [_backgroundView setContentMode:UIViewContentModeScaleAspectFill];
    }
    
    [_backgroundView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    return _backgroundView;
}


-(UILabel *)label
{
    if (!_label)
    {
        _label = [[UILabel alloc] init];
        [_label setText:@"Hashrocket"];
        _label.textColor = [UIColor redColor];
        [_label setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    return _label;
}



- (void)videoRecord
{
    NSLog(@"录制视频");
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.videoQuality = UIImagePickerControllerQualityTypeIFrame960x540;//视频质量设置
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        imagePicker.videoMaximumDuration = 300.0f;//设置最长录制5分钟
        imagePicker.mediaTypes = [NSArray arrayWithObject:@"public.movie"];
        //        [self presentModalViewController:imagePicker animated:YES];
        
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}


#pragma mark  __录制完之后的回调方法：

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //    sourceURL = [info objectForKey:UIImagePickerControllerMediaURL];
    //
    //    NSString *filePath = [NSString stringWithFormat:@"%f s", [self getVideoLength:sourceURL]];//这个url为什么可以呢，因为这里必须这样
    //    fileSizeLabel.text = [NSString stringWithFormat:@"%f kb", [self getFileSize:[[sourceURL absoluteString] substringFromIndex:16]]];//文件并没有存储在sourceURL所指的地方，因为这里自己加上了所以要将这段字符串去掉，这个Label是测试时工程中用到的显示所拍摄文件大小的标签
    //    NSLog([[sourceURL absoluteString] substringFromIndex:16]);
    //    [self dismissViewControllerAnimated:YES completion:nil];
}


//- (void)convert:(id)sender
//{
//    //转换时文件不能已存在，否则出错
//    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:sourceURL options:nil];
//    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
//    if ([compatiblePresets containsObject:resultQuality]) {
//        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:resultQuality];
//        NSDateFormatter *formater = [[NSDateFormatter alloc] init];//用时间给文件全名，以免重复，在测试的时候其实可以判断文件是否存在若存在，则删除，重新生成文件即可
//        [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
//        resultPath = [[NSHomeDirectory() stringByAppendingFormat:@"/Documents/output-%@.mp4", [formater stringFromDate:[NSDate date]]] retain];
//        NSLog(resultPath);
//        [formater release];
//        exportSession.outputURL = [NSURL fileURLWithPath:resultPath];
//        exportSession.outputFileType = AVFileTypeMPEG4;
//        [exportSession exportAsynchronouslyWithCompletionHandler:^(void)
//         {
//             switch (exportSession.status) {
//                 case AVAssetExportSessionStatusUnknown:
//                     NSLog(@"AVAssetExportSessionStatusUnknown");
//                     break;
//                 case AVAssetExportSessionStatusWaiting:
//                     NSLog(@"AVAssetExportSessionStatusWaiting");
//                     break;
//                 case AVAssetExportSessionStatusExporting:
//                     NSLog(@"AVAssetExportSessionStatusExporting");
//                     break;
//                 case AVAssetExportSessionStatusCompleted:
//                     NSLog(@"AVAssetExportSessionStatusCompleted");
//                     break;
//                 case AVAssetExportSessionStatusFailed:
//                     NSLog(@"AVAssetExportSessionStatusFailed");
//                     break;
//             }
//             [exportSession release];
//         }];
//    }
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
