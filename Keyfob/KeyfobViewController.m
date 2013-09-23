//
//  KeyfobViewController.m
//  Keyfob
//
//  Created by Muhammad Ulislam on 12/2/11.
//  Copyright (c) 2011 Bluetooth SIG, Inc. All rights reserved.
//

#import "KeyfobViewController.h"
#import "constants.h"


@interface KeyfobViewController ()
{

    CBCharacteristic    *vibratorCharacteristic;
    CBCharacteristic    *heaterCharacteristic;
    
    NSMutableData *data;
    
    NSInteger lastInstruction;
}

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btnVibrator;
@property (weak, nonatomic) IBOutlet UIButton *btnHeater;

@end

@implementation KeyfobViewController

// Four Keyfob Peripherals
@synthesize peripheral = _peripheral;
@synthesize state = _state;
@synthesize bluetoothOn = _bluetoothOn;


char rssiValue = -100;
BOOL bShowRSSI;
NSString *pName;

//==========================================================================================================================================//
#pragma mark -
#pragma mark - Vibrator Function

-(IBAction)vibratorAction:(UIButton*)sender{
    
    
    unsigned char tempByte[]={0xA8,0xCC,0xF0,0x81,0xAE};
    
    data = [NSMutableData dataWithBytes:&tempByte length:sizeof(tempByte)];
    
    
    switch ([sender tag]) {
        case 10:
            if (sender.selected) {
                
                lastInstruction=lastInstruction & ~CCF_VIBRATOR_V1;
                Byte appendByteOffV1=(Byte)lastInstruction;
                
                [sender setBackgroundColor:[UIColor whiteColor]];
                [data appendBytes:&appendByteOffV1 length:sizeof(appendByteOffV1)];
            }
            else{
               
                lastInstruction=lastInstruction | CCF_VIBRATOR_V1;
                Byte appendByteOnV1=(Byte)lastInstruction;
                
                [sender setBackgroundColor:[UIColor redColor]];
                [data appendBytes:&appendByteOnV1 length:sizeof(appendByteOnV1)];
            }
            break;
            
         case 11:
            if (sender.selected) {
                
                lastInstruction=lastInstruction & ~CCF_VIBRATOR_V2;
                Byte appendByteOffV2=(Byte)lastInstruction;
                
                [sender setBackgroundColor:[UIColor whiteColor]];
                [data appendBytes:&appendByteOffV2 length:sizeof(appendByteOffV2)];
            }
            else{
                
                lastInstruction=lastInstruction | CCF_VIBRATOR_V2;
                Byte appendByteOnV2=(Byte)lastInstruction;
                [sender setBackgroundColor:[UIColor redColor]];
                [data appendBytes:&appendByteOnV2 length:sizeof(appendByteOnV2)];
            }
            break;
            
        case 12:
            if (sender.selected) {
                lastInstruction=lastInstruction & ~CCF_VIBRATOR_V3;
                Byte appendByteOffV2=(Byte)lastInstruction;
                [sender setBackgroundColor:[UIColor whiteColor]];
                [data appendBytes:&appendByteOffV2 length:sizeof(appendByteOffV2)];
            }
            else{
                
                lastInstruction=lastInstruction | CCF_VIBRATOR_V3;
                Byte appendByteOnV3=(Byte)lastInstruction;
                [sender setBackgroundColor:[UIColor redColor]];
                [data appendBytes:&appendByteOnV3 length:sizeof(appendByteOnV3)];
            }
            break;
        case 13:
            if (sender.selected) {
                
                lastInstruction=lastInstruction & ~CCF_VIBRATOR_V4;
                Byte appendByteOffV2=(Byte)lastInstruction;
                [sender setBackgroundColor:[UIColor whiteColor]];
                [data appendBytes:&appendByteOffV2 length:sizeof(appendByteOffV2)];
            }
            else{
                lastInstruction=lastInstruction | CCF_VIBRATOR_V4;
                Byte appendByteOnV4=(Byte)lastInstruction;
                [sender setBackgroundColor:[UIColor redColor]];
                [data appendBytes:&appendByteOnV4 length:sizeof(appendByteOnV4)];
            }
            break;
            
        case 14:
            if (sender.selected) {
                lastInstruction=lastInstruction & ~CCF_VIBRATOR_V5;
                Byte appendByteOffV2=(Byte)lastInstruction;
                [sender setBackgroundColor:[UIColor whiteColor]];
                [data appendBytes:&appendByteOffV2 length:sizeof(appendByteOffV2)];
            }
            else{
                lastInstruction=lastInstruction | CCF_VIBRATOR_V5;
                Byte appendByteOnV5=(Byte)lastInstruction;
                [sender setBackgroundColor:[UIColor redColor]];
                [data appendBytes:&appendByteOnV5 length:sizeof(appendByteOnV5)];
            }
            break;
        case 15:
            if (sender.selected) {
                 lastInstruction=lastInstruction & ~CCF_VIBRATOR_V6;
                Byte appendByteOffV2=(Byte)lastInstruction;
                [sender setBackgroundColor:[UIColor whiteColor]];
                [data appendBytes:&appendByteOffV2 length:sizeof(appendByteOffV2)];
            }
            else{
                lastInstruction=lastInstruction | CCF_VIBRATOR_V6;
                Byte appendByteOnV6=(Byte)lastInstruction;
                [sender setBackgroundColor:[UIColor redColor]];
                [data appendBytes:&appendByteOnV6 length:sizeof(appendByteOnV6)];
            }
            break;
        case 20:
            if (sender.selected) {
                
                lastInstruction=lastInstruction & ~CCF_HEATER_ON;
                Byte appendByteOffV2=(Byte)lastInstruction;
                [sender setBackgroundColor:[UIColor whiteColor]];
                [data appendBytes:&appendByteOffV2 length:sizeof(appendByteOffV2)];
            }
            else{
                
                lastInstruction=lastInstruction | CCF_HEATER_ON;
                Byte appendByteOnH=(Byte)lastInstruction;
                [sender setBackgroundColor:[UIColor redColor]];
                [data appendBytes:&appendByteOnH length:sizeof(appendByteOnH)];
            }
            break;
            
        default:
            break;
    }
    Byte EndByte=(Byte)CCF_END_BYTE;
    
    [data appendBytes:&EndByte length:sizeof(EndByte)];/////append to make protocal commplete
    
    NSLog(@"print instruction--%@",[data description]);
    
    [_peripheral writeValue:data forCharacteristic:vibratorCharacteristic type:CBCharacteristicWriteWithoutResponse];
    
    ////reverse the selection process
    sender.selected = !sender.selected;
    
    NSInteger len=[data length];
    Byte *byteData = (Byte*)malloc(len);
    memcpy(byteData, [data bytes], len);
    
    NSLog(@"6 position value--%02x",byteData[5]);
    
    lastInstruction=(int)byteData[5];
   
    free(byteData);
    
    /////cache last instruction
    
}
-(void)writeVibratorService:(int)high{
    
}

#pragma mark -
#pragma mark - Heater Function


- (IBAction)heaterAction:(UIButton*)sender {
    
    
    
}

//==========================================================================================================================================//
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
//================================ LIFE CYCLE METHODS =====================================

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear");
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
    NSLog(@"viewWillDisappear");
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
    NSLog(@"viewDidDIsappear");
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    BOOL supported;
    
    // Return YES for supported orientations
    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortrait:
            supported = YES;
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            supported = YES;
            break;
        case UIInterfaceOrientationLandscapeLeft:
            supported = NO;
            break;
        case UIInterfaceOrientationLandscapeRight:
            supported = NO;
            break;
        default:
            supported = NO;
            break;
    }
    return supported;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //
    // Setup Bluetooth support and start looking for devices.
    //
    manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    [connectionButton setEnabled:NO];
    statusLabel.text = @"Searching";
    [self search];
}

- (void)viewDidUnload
{
    welcomeLabel = nil;
    rssiLabel = nil;
    connectionButton = nil;
    statusLabel = nil;
    
    [self setBtnVibrator:nil];
    [self setBtnHeater:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



//================================ CENTRAL MANAGER DELEGATE METHODS =====================================
#pragma mark - CBCentralManager delegate methods

/*
 Invoked whenever the central manager's state is updated.
 */
- (void) centralManagerDidUpdateState:(CBCentralManager *)central 
{
    NSLog(@"KeyfobViewController centralManagerDidUpdateState");
    
    self.bluetoothOn = NO;
    switch ([central state]) 
    {
        case CBCentralManagerStateUnsupported:
            self.state = @"Not Supported.";
            break;
        case CBCentralManagerStateUnauthorized:
            self.state = @"Not Authorized.";
            break;
        case CBCentralManagerStatePoweredOff:
            self.state = @"Powered Off.";
            break;
        case CBCentralManagerStatePoweredOn:
            self.state = @"Powered On.";
            self.bluetoothOn = YES;
            break;
        case CBCentralManagerStateUnknown:
        default:
            self.state = @"Unknown.";            
    }
    
    NSLog(@"Central manager state: %@", self.state);
    
}

/*
 Invoked when the central discovers a peripheral while scanning.
 */
- (void) centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)aPeripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI 
{     
    NSLog(@"KeyfobViewController didDiscoverPeripheral %@ advertisementData items: %d", aPeripheral, advertisementData.count);
    
    NSArray *keys = advertisementData.allKeys;
    NSArray *values = advertisementData.allValues;
    
    int i;
    for( i = 0; i < advertisementData.count; i++ )
    {
        NSLog(@"advertisementData %d: %@ %@", i, [keys objectAtIndex:i], [values objectAtIndex:i]);
    }
    
    //
    // There can be multiple didDiscoverPeripheral calls for the same peripheral as
    // advertisement data is discovered. As such, ensure there isn't already a
    // BluetoothDevice for this discovered peripheral.
    //
    
    
    //
    // If the adverstiment data has the local name, check to see if it is our magic keyfob.
    //
    NSString *localName = [advertisementData valueForKey:kCBAdvDataLocalName];
    if( localName != nil )
    {
        if([localName isEqualToString:ADV_DATA])
        {
            NSLog(@"Matched key fob");
            
            //
            // We have the device we want, can stop scanning.
            //
            [manager stopScan];
            
            //
            // Found the demo device, save it and connect to the device.
            //
            self.peripheral = aPeripheral;
            [self connect:aPeripheral];
            
        }
    }
}

/*
 Invoked when the central manager retrieves the list of known peripherals.
 */
- (void)centralManager:(CBCentralManager *)central didRetrievePeripherals:(NSArray *)peripherals
{
    NSLog(@"KeyfobViewController didRetrievePeripheral");
}


/*
 Invoked whenever a connection is succesfully created with the peripheral. 
 */
- (void) centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)aPeripheral 
{

    NSLog(@"KeyfobViewController didConnectPeripheral");
    [connectionButton setEnabled:YES];
    
    if( [self.peripheral.services count] == 0 )
    {
        //
        // Get the services
        //
        statusLabel.text = @"Finding Services";
        [self.peripheral discoverServices:@[[CBUUID UUIDWithString:CCF_SERVICE_UUID]]];
        [self.peripheral setDelegate:self];
    }
    bShowRSSI = YES;
    
    [[self peripheral] readRSSI];
    
}

/*
 Invoked whenever an existing connection with the peripheral is torn down. 
 */
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)aPeripheral error:(NSError *)error
{
    NSLog(@"KeyfobViewController didDisconnectPeripheral");
    statusLabel.text = @"Disconnected";    
    bShowRSSI = NO;
}

/*
 Invoked whenever the central manager fails to create a connection with the peripheral.
 */
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)aPeripheral error:(NSError *)error
{
    NSLog(@"KeyfobViewController Fail to connect to peripheral: %@ with error = %@", aPeripheral, [error localizedDescription]);
    statusLabel.text = @"Failed To Connect";    
}

#pragma mark - CBPeripheral delegate methods

/*
 Invoked upon completion of a -[discoverServices:] request.
 Discover available characteristics on interested services
 */
- (void) peripheral:(CBPeripheral *)aPeripheral didDiscoverServices:(NSError *)error 
{
    for (CBService *aService in aPeripheral.services) 
    {
        NSLog(@"KeyfobViewController Service found with UUID: %@", aService.UUID);
        if ([aService.UUID isEqual:[CBUUID UUIDWithString:CCF_SERVICE_UUID]])
        
        {
            NSLog(@"Found Service with 128 bit UUID");
            statusLabel.text = @"Finding Characteristics";
            [aPeripheral discoverCharacteristics:nil forService:aService];
            //[aPeripheral discoverCharacteristics:@[[CBUUID UUIDWithString:kServiceUUID]] forService:aService];
        }
    }
}

/*
 Invoked upon completion of a -[discoverCharacteristics:forService:] request.
 Perform appropriate operations on interested characteristics
 */
- (void) peripheral:(CBPeripheral *)aPeripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error 
{    
    NSLog(@"KeyfobViewController didDiscoverCharacteristicForService %@", service.UUID);
        
    if ([service.UUID isEqual:[CBUUID UUIDWithString:CCF_SERVICE_UUID]])
        
    {
        for (CBCharacteristic *aChar in service.characteristics) 
        {
            NSLog(@"characteristic found %@", aChar);
            if ([aChar.UUID isEqual:[CBUUID UUIDWithString:CCF_CHARACTERISTICS_NAME_UUID]])
            {
                NSLog(@"128 bit characteristic found--%@",[aChar value]);
                statusLabel.text = @"Reading Value for characteristic";
    
                [aPeripheral readValueForCharacteristic:aChar];
            }
        }
    }
}


/*
 Invoked upon completion of a -[readValueForCharacteristic:] request or on the reception of a notification/indication.
 */
- (void) peripheral:(CBPeripheral *)aPeripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error 
{
    
    if([aPeripheral isConnected])
    //if (!error)
    {
        
        //if ([characteristic properties] == CBCharacteristicPropertyWrite) {
            
            NSLog(@"type--%d\nbool--%d\nnotify--%d",[characteristic properties],[characteristic isBroadcasted], [characteristic isNotifying]);
        //}
        NSLog(@"KeyfobViewController didUpdateValueForCharacteristic %@", [characteristic descriptors]);
        
        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:CCF_CHARACTERISTICS_NAME_UUID]])
        {
            
            vibratorCharacteristic=characteristic;
        }

    }
    else
    {
    
        NSLog(@"Error while update %@",[error localizedDescription]);
    }
}
- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic

             error:(NSError *)error {
    
    if (error) {
        
        NSLog(@"Error writing characteristic value: %@",
              
              [error localizedDescription]);
        
    }
    else NSLog(@"value--%@",[[characteristic value] bytes]);
}

//////////setup delegate to receive notification
- (void)peripheral:(CBPeripheral *)peripheral

didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic

             error:(NSError *)error {
    
    if (error) {
        
        NSLog(@"Error changing notification state: %@",
              
              [error localizedDescription]);
        
    }
}

- (void) peripheralDidUpdateRSSI:(CBPeripheral *)aPeripheral error:(NSError *)error
{
    if(aPeripheral == nil)
        return;
    
    rssiValue = [aPeripheral.RSSI intValue];
    
    rssiLabel.text = [NSString stringWithFormat:@"%d", rssiValue];
    
    if(bShowRSSI == NO)
    {
        rssiLabel.text = @"----";
        welcomeLabel.text = @"Welcome, ----";
        return;
    }
    
    if([[self peripheral] isConnected] == YES)
    {
        rssiLabel.text = [NSString stringWithFormat:@"%d", rssiValue];
        
        if(rssiValue > RSSI_THRESHOLD)
        {
            NSString * pWelcome = [[NSString alloc] initWithFormat:@"Welcome to AHM, %@", pName];
            welcomeLabel.text = pWelcome;
        }
        else
            welcomeLabel.text = @"WELCOME, ----";
        
        [[self peripheral] readRSSI];
    }
}


#pragma mark - UI Methods

- (IBAction)connectButtonPressed:(id)sender
{
    UIButton *theButton = (UIButton *)sender;
    
    NSLog(@"connectionButtonPressed");
    if( [theButton.titleLabel.text isEqualToString:@"Disconnect"] )
    {
        [self disconnect];
    }
    else
    {
        [self connect:self.peripheral];
    }
}

#pragma mark - Utility Methods


- (void) search
{
    self.state = @"Scanning";
    [manager scanForPeripheralsWithServices:nil options:nil];
    
}

- (void) connect: (CBPeripheral *)aPeripheral
{
    [connectionButton setTitle:@"Disconnect" forState:UIControlStateNormal];
    //
    // If there is an existing peripheral different from the new one, disconnect.
    //
    if( self.peripheral != nil && self.peripheral != aPeripheral)
    {
        [self disconnect];
    }
    
    self.peripheral = aPeripheral;
    
    //
    // If there isn't a new peripheral, no need to continue.
    //
    if( aPeripheral == nil )
    {
        return;
    }
    
    //
    // In the demo, we are a one-stop class. Be the peripheral delegate as well.
    //
    [aPeripheral setDelegate:self];
    
    //
    // If not already, connect to the device.
    //
    if( ![self.peripheral isConnected] )
    {
        [manager connectPeripheral:aPeripheral options:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:CBConnectPeripheralOptionNotifyOnDisconnectionKey]];
    }
}

- (void) disconnect
{
    [connectionButton setTitle:@"Connect" forState:UIControlStateNormal];
    if( self.peripheral != nil)
    {
        if( [self.peripheral isConnected] )
        {
            [manager cancelPeripheralConnection:self.peripheral];
        }
    }
}

@end

/////////////////////////////////////////////////////////////////////////////////////////////////
////extra documents & code based on the research


//    for(CBService *service in _peripheral.services)
//    {
//        NSLog(@"UUID--%@\nCharacterstics--%@",service.UUID,service.characteristics);
//
//        //if([service.UUID isEqual:kServiceUUID])
//        {
//            for(CBCharacteristic *charac in service.characteristics)
//            {
//                //if([charac.UUID isEqual:HELLOBLUETOOTH_CHARACTERISTICS_NAME_UUID])
//                {
//
//                    CBUUID *characteristicUUID = [CBUUID UUIDWithString:kCharactersticsUUID];
//
//                    NSLog(@"Char UUID--%@",characteristicUUID);
//                    //char dataByte = 0x10;
//                    NSData *data = [NSData dataWithBytes:&tempByte length:6];
//                    CBMutableCharacteristic *testCharacteristic = [[CBMutableCharacteristic alloc] initWithType:characteristicUUID properties:CBCharacteristicPropertyRead|CBCharacteristicPropertyWrite value:data permissions:CBAttributePermissionsReadable|CBAttributePermissionsWriteable];
//                    [_peripheral writeValue:data forCharacteristic:testCharacteristic type:CBCharacteristicWriteWithResponse];
//
//                }
//            }
//        }
//    }


// pName = [[NSString alloc] initWithUTF8String:[[characteristic value]bytes]];

//             unsigned char tempByte[]={0xA8,0xCC,0xF0,0x81,0xAE,0x00};
//             NSData *data = [NSData dataWithBytes:&tempByte length:6];
//
//            //NSString *payLoad=@"0xA80xCC0xF00x810xAE0x010xEF";
//            //NSData *data = [payLoad dataUsingEncoding:NSUTF8StringEncoding];
//
//
//            [aPeripheral writeValue:data forCharacteristic:characteristic type:CBCharacteristicWriteWithoutResponse];

/////set a notification to interesting characterstics
//[aPeripheral setNotifyValue:YES forCharacteristic:characteristic];

