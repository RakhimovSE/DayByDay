//
//  Users.h
//  DayByDay
//
//  Created by Admin on 18.07.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class HotSpotActivities, HotSpotCategories, Locations, References, Results, Tags, Users_SocialNetworks;

NS_ASSUME_NONNULL_BEGIN

@interface Users : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

@end

NS_ASSUME_NONNULL_END

#import "Users+CoreDataProperties.h"
