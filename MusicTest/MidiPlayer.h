
#import <AudioToolbox/MusicPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>

@interface MidiPlayer : NSObject<AVAudioSessionDelegate>
{
    MusicPlayer musicPlayer;
    CFURLRef inPathToMIDIFile;
    NSString *_aupreset;
    NSString *_song;
    int curTime;
    
    AudioUnit samplerUnit1;
    AudioUnit samplerUnit2;
    AUNode samplerNode1;
    AUNode samplerNode2;
    
    AUNode multiChannelMixerNode;
}

@property (nonatomic,retain) NSString *aupreset;
@property (nonatomic,retain) NSString *song;

@property (nonatomic) MusicTimeStamp curTime;

@property (readwrite) Float64 graphSampleRate;
@property (readwrite) AUGraph processingGraph;

@property (readwrite) AudioUnit samplerUnit1;
@property (readwrite) AudioUnit samplerUnit2;
@property (readwrite) AUNode samplerNode1;
@property (readwrite) AUNode samplerNode2;

@property (readwrite) AUNode multiChannelMixerNode;
@property (readwrite) AudioUnit multiChannelMixerAudioUnit;

- (void)load;
- (void)unload;

- (void)initPresets;
- (void)loadPreset:(NSString *)presetName;

- (void)playMusic:(NSString *)soundName;
- (void)stopMusic;

- (BOOL)setupAudioSession;
- (OSStatus)loadSynthFromPresetURL:(NSURL *)presetURL;
- (BOOL)createAUGraph;
- (void)playNoteOn:(UInt32)noteNum :(UInt32)velocity;
- (void)playNoteOff:(UInt32)noteNum;

- (OSStatus)loadSynthFromPresetURL:(NSURL *) presetURL;

- (BOOL)createAUGraph;
- (void)configureAndStartAudioProcessingGraph: (AUGraph) graph;
- (void)stopAudioProcessingGraph;
- (void)restartAudioProcessingGraph;


//
extern AudioStreamBasicDescription AUCanonicalASBD(Float64 sampleRate, UInt32 channel);
extern AudioStreamBasicDescription CanonicalASBD(Float64 sampleRate, UInt32 channel);

//
static void musicEventUserDataCallback(void *inclientData, MusicSequence inSequence, MusicTrack inTrack, MusicTimeStamp inEventTime, const MusicEventUserData *inEventData, MusicTimeStamp inStartSliceBeat, MusicTimeStamp inEndSliceBeat);

@end
