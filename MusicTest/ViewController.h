//
//  ViewController.h
//  MusicTest
//
//  Created by Yohei Yoshikawa on 11/11/04.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/MusicPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>
#import "MidiPlayer.h"


@interface ViewController : UIViewController<UITableViewDelegate>
{
    MidiPlayer  *player;
    NSMutableArray *aupresetFiles;
    NSMutableArray *songs;
    NSUInteger currentSongIndex;
}

@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (nonatomic, strong) IBOutlet UILabel  *currentPresetLabel;


@property (nonatomic, strong) NSMutableArray *aupresetFiles;
@property (nonatomic, strong) NSMutableArray *songs;
@property (nonatomic) NSUInteger currentSongIndex;


- (IBAction)clickedStartButton:(UIButton *)sender;
- (IBAction)clickedStopButton:(UIButton *)sender;

- (IBAction)clickedLoadPreset:(UIButton *)sender;
- (IBAction)startPlayLowNote:(UIButton *)sender;
- (IBAction)stopPlayLowNote:(UIButton *)sender;
- (IBAction)startPlayMidNote:(UIButton *)sender;
- (IBAction)stopPlayMidNote:(UIButton *)sender;
- (IBAction)startPlayHighNote:(UIButton *)sender;
- (IBAction)stopPlayHighNote:(UIButton *)sender;


@end
