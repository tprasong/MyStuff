//
//  MyWhatsit.h
//  MyStuff
//
//  Created by Prasong on 4/08/2014.
//  Copyright (c) 2014 Prasong Techapanyo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyWhatsit : NSObject
@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *location;
-(id)initWithName:(NSString*)name location:(NSString*)location;
@end
