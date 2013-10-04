//
//  ViewController.m
//  MusicTest
//
//  Created by Yohei Yoshikawa on 11/11/04.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import <AssertMacros.h>

@implementation ViewController

@synthesize aupresetFiles = _aupresetFiles;
@synthesize songs = _songs;
@synthesize currentSongIndex = _currentSongIndex;

@synthesize startButton = _startButton;
@synthesize stopButton = _stopButton;
@synthesize currentPresetLabel = _currentPresetLabel;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    _currentSongIndex = 0;
    _aupresetFiles = [NSMutableArray arrayWithObjects:@"Piano1", @"Trombone1", @"Vibraphone1", nil];
    _songs = [NSMutableArray arrayWithObjects:@"FurElise", @"Sonatina in C-Latour", @"WonderChristmas", @"HappyXmas", @"silent_night_jz", @"JingleBell", nil];
    player = [[MidiPlayer alloc] init];
    [player load];
    [self loadPreset:0];
}

- (void)loadPreset:(NSUInteger)index
{
    NSLog(@"--- loadPresete ---");
    if (index > [_aupresetFiles count] - 1) return;
    NSString *presetName = [_aupresetFiles objectAtIndex:index];
	[player loadPreset:presetName];
}

- (void)viewDidUnload
{
    NSLog(@"--- viewDidUnload ---");
    [player unload];
    [self setAupresetFiles:nil];
    [self setSongs:nil];
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}


#pragma -
#pragma IBAction
- (IBAction)clickedStartButton:(UIButton *)sender {
    NSString *soundName = [_songs objectAtIndex:_currentSongIndex];
    [player playMusic:soundName];
}

- (IBAction)clickedStopButton:(UIButton *)sender {
    [player stopMusic];
}

- (IBAction)clickedLoadPreset:(UIButton *)sender
{
    [player loadPreset:0];
}

- (IBAction) startPlayLowNote:(UIButton *)sender
{
    [player playNoteOn:sender.tag :127];
}

- (IBAction) stopPlayLowNote:(UIButton *)sender
{
	[player playNoteOff:sender.tag];
}

- (IBAction) startPlayMidNote:(UIButton *)sender
{
	[player playNoteOn:sender.tag :127];
}

- (IBAction) stopPlayMidNote:(UIButton *)sender
{
	[player playNoteOff:sender.tag];
}

- (IBAction) startPlayHighNote:(UIButton *)sender
{
	[player playNoteOn:sender.tag :127];
}

- (IBAction)stopPlayHighNote:(UIButton *)sender
{
	[player playNoteOff:sender.tag];
}


#pragma mark - Application state management
- (void)registerForUIApplicationNotifications
{
    NSLog(@"--- registerForUIApplicationNotifications ---");
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver: self
                           selector: @selector (handleResigningActive:)
                               name: UIApplicationWillResignActiveNotification
                             object: [UIApplication sharedApplication]];
    
    [notificationCenter addObserver: self
                           selector: @selector (handleBecomingActive:)
                               name: UIApplicationDidBecomeActiveNotification
                             object: [UIApplication sharedApplication]];
}


- (void)handleResigningActive: (id) notification
{
    [player stopAudioProcessingGraph];
}

- (void)handleBecomingActive: (id) notification
{
    [player restartAudioProcessingGraph];
}

#pragma -
#pragma UITableView Delegate Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (tableView.tag) {
        case 1:
            return [_songs count];
        case 2:
            return [_aupresetFiles count];
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    switch (tableView.tag) {
        case 1:
            cell.textLabel.text = [_songs objectAtIndex:indexPath.row];
            break;
        case 2:
            cell.textLabel.text = [_aupresetFiles objectAtIndex:indexPath.row];
            break;
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (tableView.tag) {
        case 1:
            [player stopMusic];
            _currentSongIndex = [indexPath row];
            [player playMusic:[_songs objectAtIndex:_currentSongIndex]];
            break;
        case 2:
            [self loadPreset:[indexPath row]];
            break;
        default:
            break;
    }
}



@end
