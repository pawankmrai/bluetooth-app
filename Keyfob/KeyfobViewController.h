//
//  KeyfobViewController.h
//  Keyfob
//
//  Created by Muhammad Ulislam on 12/2/11.
//  Copyright (c) 2011 Bluetooth SIG, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "AVFoundation/AVFoundation.h"
#import "CoreBluetooth/CBUUID.h"
#import "CoreBluetooth/CBCentralManager.h"
#import "CoreBluetooth/CBPeripheral.h"
#import "CoreBluetooth/CBService.h"
#import "CoreBluetooth/CBCharacteristic.h"

#define kCBAdvDataLocalName @"kCBAdvDataLocalName"
#define kCBAdvDataServiceUUIDs @"kCBAdvDataServiceUUIDs"

@interface KeyfobViewController : UIViewController 
    <CBCentralManagerDelegate, CBPeripheralDelegate, AVAudioPlayerDelegate>
{
    CBCentralManager *manager;
    
    IBOutlet UIButton *connectionButton;
    IBOutlet UILabel *statusLabel;
    IBOutlet UILabel *welcomeLabel;    
    IBOutlet UILabel *rssiLabel;
}

@property (nonatomic, retain) CBPeripheral *peripheral;
@property (nonatomic, retain) NSString *state;
@property (nonatomic) BOOL bluetoothOn;

- (IBAction)connectButtonPressed:(id)sender;

- (void)search;
- (void)connect:(CBPeripheral *)aPeripheral;
- (void)disconnect;

@end
