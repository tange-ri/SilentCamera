//
//  CameraManager.h
//  SilentCamera
//
//  Created by Eri Tange on 2014/05/05.
//  Copyright (c) 2014年 Eri Tange. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CameraManager : NSObject
<AVCaptureVideoDataOutputSampleBufferDelegate>

+(instancetype)sharedManager;
-(void)takePhoto;

@end
