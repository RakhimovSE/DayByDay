//
//  Users_SocialNetworks+CoreDataProperties.h
//  DayByDay
//
//  Created by Admin on 18.07.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Users_SocialNetworks.h"

NS_ASSUME_NONNULL_BEGIN

@interface Users_SocialNetworks (CoreDataProperties)

@property (nonatomic) BOOL user_socialNetwork_deleted;
@property (nonatomic) BOOL user_socialNetwork_main;
@property (nonatomic) NSTimeInterval user_socialNetwork_updated;
@property (nullable, nonatomic, retain) SocialNetworks *socialNetwork;
@property (nullable, nonatomic, retain) Users *user;

@end

NS_ASSUME_NONNULL_END
