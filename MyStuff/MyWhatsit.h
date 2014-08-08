//
//  MyWhatsit.h
//  MyStuff
//
//  Created by Prasong on 4/08/2014.
//  Copyright (c) 2014 Prasong Techapanyo. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kWhatsitDidChangeNotification @"MyWhatsitDidChange"
@interface MyWhatsit : NSObject
@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *location;
@property (strong, nonatomic) UIImage *image;
@property (readonly, nonatomic) UIImage *viewImage;
-(id)initWithName:(NSString*)name location:(NSString*)location;
-(void)postDidChangeNotification;
@end
