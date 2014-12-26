//
//  VCRoot.m
//  AudioPlayer
//
//  Created by qianfeng on 14-12-26.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import "VCRoot.h"

@interface VCRoot ()

@end

@implementation VCRoot

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _btnPlay = [UIButton buttonWithType:UIButtonTypeRoundedRect] ;
    [_btnPlay addTarget:self action:@selector(pressPlay) forControlEvents:UIControlEventTouchUpInside] ;
    
    [_btnPlay setTitle:@"播放" forState:UIControlStateNormal] ;
    _btnPlay.frame = CGRectMake(80, 360, 80, 40) ;
    
    _btnStop = [UIButton buttonWithType:UIButtonTypeRoundedRect] ;
    
    [_btnStop addTarget:self action:@selector(pressStop) forControlEvents:UIControlEventTouchUpInside] ;
    
    [_btnStop setTitle:@"停止" forState:UIControlStateNormal] ;
    _btnStop.frame = CGRectMake(180, 360, 80, 40) ;
    
    //进度条
    _progView = [[UIProgressView alloc] init] ;
    
    _progView.frame = CGRectMake(10, 40, 300, 40) ;
    //播放进度
    _sliderProg = [[UISlider alloc] init] ;
    
    _sliderProg.frame = CGRectMake(10, 90, 300, 40) ;
    //音量控制
    _sliderValume = [[UISlider alloc] init] ;
    
    _sliderValume.frame = CGRectMake(10, 150, 300, 40);
    
    [_sliderProg addTarget:self action:@selector(sliderProg:) forControlEvents:UIControlEventValueChanged] ;
    
    [_sliderValume addTarget:self action:@selector(sliderValume:) forControlEvents:UIControlEventValueChanged] ;
    
    [self.view addSubview:_btnPlay] ;
    [self.view addSubview:_btnStop] ;
    [self.view addSubview:_sliderValume] ;
    [self.view addSubview:_sliderProg] ;
    [self.view addSubview:_progView] ;
    //
    _audioPlayer = [[AVAudioPlayer alloc] init] ;
}

-(void) pressPlay
{
    NSString* strURL = @"http://192.168.81.208/1407/001.mp3";
    
    //获取音频文件
    NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:strURL]] ;
    
    //创建音频播放对象,传入音频数据
    _audioPlayer = [[AVAudioPlayer alloc] initWithData:data error:nil] ;
    //将音频文件从mp3存储格式转化为wav文件(解码过程)
    BOOL isReady = [_audioPlayer prepareToPlay] ;
    
    //停止播放
    [_audioPlayer stop] ;
    //获取音频文件的声道到数量
    //1:单声道
    //2:立体声
    //5.1:6声道
    _audioPlayer.numberOfChannels;
    //设置循环播放次数
    _audioPlayer.numberOfLoops = 5 ;
    //开启快进或(慢放)功能
    _audioPlayer.enableRate = YES ;
    //设置播放的快进的比例
    //1.0正常进度
    //2.0一倍速度播放
    //0.5慢放:
    _audioPlayer.rate = 0.5f ;
    
    if (_audioPlayer.isPlaying == YES)
    {
        //暂停播放
        [_audioPlayer pause] ;
        [_btnPlay setTitle:@"播放" forState:UIControlStateNormal];

    }
    else if(!_audioPlayer.isPlaying)
    {
        //更新播放的时间进度
        [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateProg) userInfo:nil repeats:YES] ;
        
        //开始播放
        [_audioPlayer play] ;
        [_btnPlay setTitle:@"暂停" forState:UIControlStateNormal];
    }
}
-(void) updateProg
{
    //进度＝当前时间/总时间长度
    float progress = _audioPlayer.currentTime/_audioPlayer.duration ;
    
    _progView.progress = progress ;
}

-(void) sliderProg:(UISlider*) slider
{
    _audioPlayer.currentTime = slider.value * _audioPlayer.duration;
}

-(void) sliderValume:(UISlider*) slider
{
    //音量从0到1
    _audioPlayer.volume = slider.value ;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
