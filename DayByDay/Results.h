//
//  Results.h
//  DayByDay
//
//  Created by Admin on 03.04.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Difficulties, Energies, HotSpots, Locations, PeriodTypes, Priorities, Qualities, References, Tags, Users;

NS_ASSUME_NONNULL_BEGIN

@interface Results : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

@end

NS_ASSUME_NONNULL_END

#import "Results+CoreDataProperties.h"