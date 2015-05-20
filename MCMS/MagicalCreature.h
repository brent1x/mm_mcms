//
//  MagicalCreature.h
//  MCMS
//
//  Created by Brent Dady on 5/19/15.
//  Copyright (c) 2015 Brent Dady. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface MagicalCreature : NSObject

@property NSString *name;
@property NSString *hometown;
@property UIImage *image;
@property NSMutableArray *accessories;

- (instancetype)initWithName:(NSString *)name hometown:(NSString *)hometown accessories:(NSMutableArray *)accessories;

@end
