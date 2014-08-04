//
//  MyWhatsit.m
//  MyStuff
//
//  Created by Prasong on 4/08/2014.
//  Copyright (c) 2014 Prasong Techapanyo. All rights reserved.
//

#import "MyWhatsit.h"

@implementation MyWhatsit

-(id)initWithName:(NSString *)name location:(NSString *)location
{
    self = [super init];
    if (self) {
        self.name = name;
        self.location = location;
    }
    return self;
}
@end
