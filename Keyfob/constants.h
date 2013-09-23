//
//  constants.h
//  Keyfob
//
//  Created by Muhammad Ulislam on 6/5/12.
//  Copyright (c) 2012 Bluetooth SIG, Inc. All rights reserved.
//

#ifndef Keyfob_constants_h
#define Keyfob_constants_h

//#define HELLOBLUETOOTH_SERVICE_UUID                      @"5AB20001-B355-4D8A-96EF-2963812DD0B8"
//#define HELLOBLUETOOTH_CHARACTERISTICS_NAME_UUID         @"5AB20002-B355-4D8A-96EF-2963812DD0B8"

#define CCF_SERVICE_UUID                      @"1882"
#define CCF_CHARACTERISTICS_NAME_UUID         @"2A16"

// If the adverstiment data has the local name, check to see if it is our magic keyfob.
#define ADV_DATA                                         @"CCF Shoe-L"

//RSSI Threshold Low in dBm
#define RSSI_THRESHOLD                                  -65
#define CCF_END_BYTE                                    0xEF

#define CCF_VIBRATOR_V1                                 0x01
#define CCF_VIBRATOR_V2                                 0x02
#define CCF_VIBRATOR_V3                                 0x04
#define CCF_VIBRATOR_V4                                 0x08
#define CCF_VIBRATOR_V5                                 0x10
#define CCF_VIBRATOR_V6                                 0x20
#define CCF_HEATER_ON                                   0x40


#define CCF_VIBRATOR_OFF                                0x00






#endif







/*
 
 #define BTLE_OFF_ALL                                        0x00
 
 #define TI_KEYFOB_PROXIMITY_ALERT_ON_VAL                    0x01
 #define TI_KEYFOB_PROXIMITY_ALERT_OFF_VAL                   0x00
 #define TI_KEYFOB_PROXIMITY_ALERT_WRITE_LEN                 1
 #define TI_KEYFOB_PROXIMITY_TX_PWR_SERVICE_UUID             0x1804
 #define TI_KEYFOB_PROXIMITY_TX_PWR_NOTIFICATION_UUID        0x2A07
 #define TI_KEYFOB_PROXIMITY_TX_PWR_NOTIFICATION_READ_LEN    1
 
 #define TI_KEYFOB_BATT_SERVICE_UUID                         0xFFB0
 #define TI_KEYFOB_LEVEL_SERVICE_UUID                        0xFFB1
 #define TI_KEYFOB_POWER_STATE_UUID                          0xFFB2
 #define TI_KEYFOB_LEVEL_SERVICE_READ_LEN                    1
 
 #define TI_KEYFOB_ACCEL_SERVICE_UUID                        0xFFA0
 #define TI_KEYFOB_ACCEL_ENABLER_UUID                        0xFFA1
 #define TI_KEYFOB_ACCEL_RANGE_UUID                          0xFFA2
 #define TI_KEYFOB_ACCEL_READ_LEN                            1
 #define TI_KEYFOB_ACCEL_X_UUID                              0xFFA3
 #define TI_KEYFOB_ACCEL_Y_UUID                              0xFFA4
 #define TI_KEYFOB_ACCEL_Z_UUID                              0xFFA5
 
 #define TI_KEYFOB_KEYS_SERVICE_UUID                         0xFFE0
 #define TI_KEYFOB_KEYS_NOTIFICATION_UUID                    0xFFE1
 #define TI_KEYFOB_KEYS_NOTIFICATION_READ_LEN                1  */