//
//  MagicalCreature.m
//  MCMS
//
//  Created by Brent Dady on 5/19/15.
//  Copyright (c) 2015 Brent Dady. All rights reserved.
//

#import "MagicalCreature.h"

@implementation MagicalCreature

- (instancetype)initWithName:(NSString *)name hometown:(NSString *)hometown {
    self = [super init];
    self.name = name;
    self.hometown = hometown;
    self.image = [UIImage imageNamed:name];
    return self;
}

@end
