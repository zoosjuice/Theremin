//
//  VWWThereminNotes.m
//  Theremin
//
//  Created by Zakk Hoyt on 8/12/12.
//  Copyright (c) 2012 Zakk Hoyt. All rights reserved.
//

#import "VWWThereminNotes.h"

#define NWF(x) [NSNumber numberWithFloat:x]

@interface VWWThereminNotes ()
@property (nonatomic, retain) NSArray* notes;
@property (nonatomic, retain) NSArray* notesInAMinor;
@property (nonatomic, retain) NSArray* notesInAMajor;
@property (nonatomic, retain) NSArray* notesInBMinor;
@property (nonatomic, retain) NSArray* notesInBMajor;
@property (nonatomic, retain) NSArray* notesInCMajor;
@property (nonatomic, retain) NSArray* notesInDMinor;
@property (nonatomic, retain) NSArray* notesInDMajor;
@property (nonatomic, retain) NSArray* notesInEMinor;
@property (nonatomic, retain) NSArray* notesInEMajor;
@property (nonatomic, retain) NSArray* notesInFMajor;
@property (nonatomic, retain) NSArray* notesInGMinor;
@property (nonatomic, retain) NSArray* notesInGMajor;

-(void)initializeClass;
@end

@implementation VWWThereminNotes


+(VWWThereminNotes *)sharedInstance{
    static VWWThereminNotes* instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[VWWThereminNotes alloc]init];
    });
    return instance;
}


-(id)init{
    self = [super init];
    if(self){
        [self initializeClass];
    }
    return self;
}

+(float)getClosestNoteForFrequency:(float)frequency{
    return [[VWWThereminNotes sharedInstance]getClosestNote:frequency];
}

+(float)getClosestNoteForFrequency:(float)frequency inKey:(NoteKey)key{
    return [[VWWThereminNotes sharedInstance]getClosestNote:frequency inKey:key];
}



-(float)getClosestNote:(float)frequency inKey:(NoteKey)key{
//// TODO: Implement this and uncomment. for now we are just using chromatic
//    switch(key){
//        case kNoteKeyAMinor:
//            break;
//        case kNoteKeyAMajor:
//            break;
//        case kNoteKeyBMinor:
//            break;
//        case kNoteKeyBMajor:
//            break;
//        case kNoteKeyCMajor:
//            break;
//        case kNoteKeyDMinor:
//            break;
//        case kNoteKeyDMajor:
//            break;
//        case kNoteKeyEMinor:
//            break;
//        case kNoteKeyFMajor:
//            break;
//        case kNoteKeyGMinor:
//            break;
//        case kNoteKeyGMajor:
//            break;
//        case kNoteKeyChromatic:
//        default:
//            break;
//            return [self getClosestNote:frequency];
//    }
    return [self getClosestNote:frequency];
}



-(float)getClosestNote:(float)frequency{
    // Since our notes are sorted ascending, use binary search pattern
    
    int min = 0;
    int max = self.notes.count;
    int mid = 0;
    
    bool foundValue = false;
    while(min < max){
        mid = (min + max) / 2;
//        NSLog(@"min = %i , max = %i, mid = %i",min,max,mid);
        float temp = ((NSNumber*)[self.notes objectAtIndex:mid]).floatValue;
//        NSLog(@"temp = %f frequency = %f", temp, frequency);
        if (temp == frequency){
            foundValue = true;
            break;
        }
        else if (frequency > ((NSNumber*)[self.notes objectAtIndex:mid]).floatValue){
            min = mid+1;
        }
        else{
            max = mid-1;
        }
    }
    
    // frequency likely falls between two indicies. See which one it's closer to and return that
    float r = 0;
    if(mid == 0){
        // This is to catch a bug. The code below can potentially try to
        // access objectAtIndex:-1. Just return 0 if we are already at 0
        r = ((NSNumber*)[self.notes objectAtIndex:mid]).floatValue;
    }
    else{
        if(frequency < ((NSNumber*)[self.notes objectAtIndex:mid]).floatValue){
            // See if it's closer to mid or mid-1
            float temp1 = abs(frequency - ((NSNumber*)[self.notes objectAtIndex:mid]).floatValue);
            float temp2 = abs(frequency - ((NSNumber*)[self.notes objectAtIndex:mid-1]).floatValue);
            if(temp1 < temp2)
                r = ((NSNumber*)[self.notes objectAtIndex:mid]).floatValue;
            else
                r = ((NSNumber*)[self.notes objectAtIndex:mid-1]).floatValue;
        }
        else{
            // See if it's closer to mid of mid+1
            float temp1 = abs(frequency - ((NSNumber*)[self.notes objectAtIndex:mid]).floatValue);
            float temp2 = abs(frequency - ((NSNumber*)[self.notes objectAtIndex:mid+1]).floatValue);
            if(temp1 < temp2)
                r = ((NSNumber*)[self.notes objectAtIndex:mid]).floatValue;
            else
                r = ((NSNumber*)[self.notes objectAtIndex:mid+1]).floatValue;
        }
    }
    return r;
}

// I precalculated these frequendies with the formula f = 2^n/12 * 27.5 with n from 1 .. 114
-(void)initializeAllNotes{
    self.notes = [NSArray arrayWithObjects:NWF(27.50),
                  NWF(29.14),
                  NWF(30.87),
                  NWF(32.70),
                  NWF(34.65),
                  NWF(36.71),
                  NWF(38.89),
                  NWF(41.20),
                  NWF(43.65),
                  NWF(46.25),
                  NWF(49.00),
                  NWF(51.91),
                  NWF(55.00),
                  NWF(58.27),
                  NWF(61.74),
                  NWF(65.41),
                  NWF(69.30),
                  NWF(73.42),
                  NWF(77.78),
                  NWF(82.41),
                  NWF(87.31),
                  NWF(92.50),
                  NWF(98.00),
                  NWF(103.83),
                  NWF(110.00),
                  NWF(116.54),
                  NWF(123.47),
                  NWF(130.81),
                  NWF(138.59),
                  NWF(146.83),
                  NWF(155.56),
                  NWF(164.81),
                  NWF(174.61),
                  NWF(185.00),
                  NWF(196.00),
                  NWF(207.65),
                  NWF(220.00),
                  NWF(233.08),
                  NWF(246.94),
                  NWF(261.63),
                  NWF(277.18),
                  NWF(293.66),
                  NWF(311.13),
                  NWF(329.63),
                  NWF(349.23),
                  NWF(369.99),
                  NWF(392.00),
                  NWF(415.30),
                  NWF(440.00),
                  NWF(466.16),
                  NWF(493.88),
                  NWF(523.25),
                  NWF(554.37),
                  NWF(587.33),
                  NWF(622.25),
                  NWF(659.26),
                  NWF(698.46),
                  NWF(739.99),
                  NWF(783.99),
                  NWF(830.61),
                  NWF(880.00),
                  NWF(932.33),
                  NWF(987.77),
                  NWF(1046.50),
                  NWF(1108.73),
                  NWF(1174.66),
                  NWF(1244.51),
                  NWF(1318.51),
                  NWF(1396.91),
                  NWF(1479.98),
                  NWF(1567.98),
                  NWF(1661.22),
                  NWF(1760.00),
                  NWF(1864.66),
                  NWF(1975.53),
                  NWF(2093.00),
                  NWF(2217.46),
                  NWF(2349.32),
                  NWF(2489.02),
                  NWF(2637.02),
                  NWF(2793.83),
                  NWF(2959.96),
                  NWF(3135.96),
                  NWF(3322.44),
                  NWF(3520.00),
                  NWF(3729.31),
                  NWF(3951.07),
                  NWF(4186.01),
                  NWF(4434.92),
                  NWF(4698.64),
                  NWF(4978.03),
                  NWF(5274.04),
                  NWF(5587.65),
                  NWF(5919.91),
                  NWF(6271.93),
                  NWF(6644.88),
                  NWF(7040.00),
                  NWF(7458.62),
                  NWF(7902.13),
                  NWF(8372.02),
                  NWF(8869.84),
                  NWF(9397.27),
                  NWF(9956.06),
                  NWF(10548.08),
                  NWF(11175.30),
                  NWF(11839.82),
                  NWF(12543.85),
                  NWF(13289.75),
                  NWF(14080.00),
                  NWF(14917.24),
                  NWF(15804.27),
                  NWF(16744.04),
                  NWF(17739.69),
                  NWF(18794.55),
                  NWF(19912.13),
                  nil];
}


//// major = 0, 2, 4, 5, 7, 9, 11
// Guitar pattern
//D:9xBCx
//A:45x7x
//E:x0x2x

//// minor = 0, 2, 3, 5, 7, 8, 10,
// Guitar pattern
//D:xAxCx
//A:x5x78
//E:x0x23



-(void)initializeNotesInAMinor{
    _notesInAMinor = [NSArray new];
}

-(void)initializeNotesInAMajor{
    _notesInAMajor = [NSArray new];
}
-(void)initializeNotesInBMinor{
    _notesInBMinor = [NSArray new];
}
-(void)initializeNotesInBMajor{
    _notesInBMajor = [NSArray new];
}
-(void)initializeNotesInCMajor{
    _notesInCMajor = [NSArray new];
}
-(void)initializeNotesInDMinor{
    _notesInDMinor = [NSArray new];
}
-(void)initializeNotesInDMajor{
    _notesInDMajor = [NSArray new];
}
-(void)initializeNotesInEMinor{
    _notesInEMinor = [NSArray new];
}
-(void)initializeNotesInEMajor{
    _notesInEMajor = [NSArray new];
}
-(void)initializeNotesInFMajor{
    _notesInFMajor = [NSArray new];
}
-(void)initializeNotesInGMinor{
    _notesInGMinor = [NSArray new];
}
-(void)initializeNotesInGMajor{
    _notesInGMajor = [NSArray new];
}


-(void)initializeClass{
    [self initializeAllNotes];
    [self initializeNotesInAMinor];
    [self initializeNotesInAMajor];
    [self initializeNotesInBMinor];
    [self initializeNotesInBMajor];
    [self initializeNotesInCMajor];
    [self initializeNotesInDMinor];
    [self initializeNotesInDMajor];
    [self initializeNotesInEMinor];
    [self initializeNotesInEMajor];
    [self initializeNotesInFMajor];
    [self initializeNotesInGMinor];
    [self initializeNotesInGMajor];
}


@end



