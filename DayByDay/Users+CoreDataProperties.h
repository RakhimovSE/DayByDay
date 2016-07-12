//
//  Users+CoreDataProperties.h
//  DayByDay
//
//  Created by Admin on 11.07.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Users.h"
#import "HotSpotActivities.h"
#import "HotSpotCategories.h"
#import "Locations.h"
#import "References.h"
#import "Results.h"
#import "Users_SocialNetworks.h"

NS_ASSUME_NONNULL_BEGIN

@interface Users (CoreDataProperties)

@property (nullable, nonatomic, retain) NSData *user_avatar;
@property (nonatomic) BOOL user_deleted;
@property (nullable, nonatomic, retain) NSString *user_email;
@property (nonatomic) double user_energy;
@property (nonatomic) int32_t user_id;
@property (nullable, nonatomic, retain) NSString *user_name;
@property (nullable, nonatomic, retain) NSString *user_password;
@property (nonatomic) NSTimeInterval user_registry;
@property (nonatomic) int32_t user_score;
@property (nonatomic) NSTimeInterval user_updated;
@property (nonatomic) BOOL user_emailConfirmed;
@property (nullable, nonatomic, retain) NSSet<HotSpotActivities *> *hotSpotActivities;
@property (nullable, nonatomic, retain) NSSet<HotSpotCategories *> *hotSpotCategories;
@property (nullable, nonatomic, retain) NSSet<Locations *> *locations;
@property (nullable, nonatomic, retain) NSSet<References *> *references;
@property (nullable, nonatomic, retain) NSSet<Results *> *results;
@property (nullable, nonatomic, retain) NSSet<Users_SocialNetworks *> *users_socialNetworks;
@property (nullable, nonatomic, retain) NSSet<Tags *> *tags;

@end

@interface Users (CoreDataGeneratedAccessors)

- (void)addHotSpotActivitiesObject:(HotSpotActivities *)value;
- (void)removeHotSpotActivitiesObject:(HotSpotActivities *)value;
- (void)addHotSpotActivities:(NSSet<HotSpotActivities *> *)values;
- (void)removeHotSpotActivities:(NSSet<HotSpotActivities *> *)values;

- (void)addHotSpotCategoriesObject:(HotSpotCategories *)value;
- (void)removeHotSpotCategoriesObject:(HotSpotCategories *)value;
- (void)addHotSpotCategories:(NSSet<HotSpotCategories *> *)values;
- (void)removeHotSpotCategories:(NSSet<HotSpotCategories *> *)values;

- (void)addLocationsObject:(Locations *)value;
- (void)removeLocationsObject:(Locations *)value;
- (void)addLocations:(NSSet<Locations *> *)values;
- (void)removeLocations:(NSSet<Locations *> *)values;

- (void)addReferencesObject:(References *)value;
- (void)removeReferencesObject:(References *)value;
- (void)addReferences:(NSSet<References *> *)values;
- (void)removeReferences:(NSSet<References *> *)values;

- (void)addResultsObject:(Results *)value;
- (void)removeResultsObject:(Results *)value;
- (void)addResults:(NSSet<Results *> *)values;
- (void)removeResults:(NSSet<Results *> *)values;

- (void)addUsers_socialNetworksObject:(Users_SocialNetworks *)value;
- (void)removeUsers_socialNetworksObject:(Users_SocialNetworks *)value;
- (void)addUsers_socialNetworks:(NSSet<Users_SocialNetworks *> *)values;
- (void)removeUsers_socialNetworks:(NSSet<Users_SocialNetworks *> *)values;

- (void)addTagsObject:(Tags *)value;
- (void)removeTagsObject:(Tags *)value;
- (void)addTags:(NSSet<Tags *> *)values;
- (void)removeTags:(NSSet<Tags *> *)values;

@end

NS_ASSUME_NONNULL_END
