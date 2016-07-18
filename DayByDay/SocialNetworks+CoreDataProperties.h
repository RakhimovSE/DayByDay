//
//  SocialNetworks+CoreDataProperties.h
//  DayByDay
//
//  Created by Admin on 18.07.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "SocialNetworks.h"

NS_ASSUME_NONNULL_BEGIN

@interface SocialNetworks (CoreDataProperties)

@property (nonatomic) BOOL socialNetwork_deleted;
@property (nonatomic) int32_t socialNetwork_id;
@property (nullable, nonatomic, retain) NSString *socialNetwork_link;
@property (nullable, nonatomic, retain) NSString *socialNetwork_name;
@property (nonatomic) NSTimeInterval socialNetwork_updated;
@property (nullable, nonatomic, retain) NSSet<Users_SocialNetworks *> *users_socialNetworks;

@end

@interface SocialNetworks (CoreDataGeneratedAccessors)

- (void)addUsers_socialNetworksObject:(Users_SocialNetworks *)value;
- (void)removeUsers_socialNetworksObject:(Users_SocialNetworks *)value;
- (void)addUsers_socialNetworks:(NSSet<Users_SocialNetworks *> *)values;
- (void)removeUsers_socialNetworks:(NSSet<Users_SocialNetworks *> *)values;

@end

NS_ASSUME_NONNULL_END
