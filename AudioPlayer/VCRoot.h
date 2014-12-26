//
//  VCRoot.h
//  AudioPlayer
//
//  Created by qianfeng on 14-12-26.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

//audioVideo基础类库
#import <AVFoundation/AVFoundation.h>

@interface VCRoot : UIViewController
{
    //系统音频播放对象
    AVAudioPlayer* _audioPlayer ;
    //播放进度
    UIProgressView* _progView ;
    //音量控制
    UISlider*       _sliderValume ;
    //播放的进度
    UISlider*       _sliderProg ;
    //播放按钮
    UIButton*       _btnPlay ;
    //停止按钮
    UIButton*       _btnStop ;
}

@end




