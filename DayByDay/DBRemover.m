//
//  DBCleaner.m
//  DayByDay
//
//  Created by Admin on 03.07.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//

#import "DBRemover.h"
#import "DataController.h"
#import "Difficulties.h"

@implementation DBRemover {
    DataController *dataController;
}

- (id)init {
    if (self = [super init]) {
        dataController = [[DataController alloc] init];
        return self;
    }
    return nil;
}

- (void)removeEntireDatabase {
    [self removeSocialNetworks];
    [self removeRates];
    [self removeHotSpotCategoriesDefault];
    [self removeHotSpotActivitiesDefault];
    [self removeUserData];
    [self removePriorities];
    [self removeEnergies];
    [self removeDifficulties];
    [self removeQualities];
    [self removePeriodTypes];
}

- (void)removeUserData {
    [self removeVariables];
    [self removeTags_Results];
    [self removeResults_References];
    [self removeResults_Relationships];
    [self removeResults];
    [self removeHotSpots];
    [self removeHotSpotsDefault];
    [self removeHotSpotCategories];
    [self removeHotSpotActivities];
    [self removeUsers_SocialNetworks];
    [self removeTags];
    [self removeLocations];
    [self removeReferences];
    [self removeUsers];
}

- (void)removeDifficulties {
    [self deleteAllObjects:@"Difficulties"];
}

- (void)removeEnergies {
    [self deleteAllObjects:@"Energies"];
}

- (void)removeHotSpotActivities {
    [self deleteAllObjects:@"HotSpotActivities"];
}

- (void)removeHotSpotActivitiesDefault {
    [self deleteAllObjects:@"HotSpotActivitiesDefault"];
}

- (void)removeHotSpotCategories {
    [self deleteAllObjects:@"HotSpotCategories"];
}

- (void)removeHotSpotCategoriesDefault {
    [self deleteAllObjects:@"HotSpotCategoriesDefault"];
}

- (void)removeHotSpots {
    [self deleteAllObjects:@"HotSpots"];
}

- (void)removeHotSpotsDefault {
    [self deleteAllObjects:@"HotSpotsDefault"];
}

- (void)removeLocations {
    [self deleteAllObjects:@"Locations"];
}

- (void)removePeriodTypes {
    [self deleteAllObjects:@"PeriodTypes"];
}

- (void)removePriorities {
    [self deleteAllObjects:@"Priorities"];
}

- (void)removeQualities {
    [self deleteAllObjects:@"Qualities"];
}

- (void)removeRates {
    [self deleteAllObjects:@"Rates"];
}

- (void)removeReferences {
    [self deleteAllObjects:@"References"];
}

- (void)removeResults {
    [self deleteAllObjects:@"Results"];
}

- (void)removeResults_Relationships {
    [self deleteAllObjects:@"Results_Relationships"];
}

- (void)removeResults_References {
    [self deleteAllObjects:@"Results_References"];
}

- (void)removeSocialNetworks {
    [self deleteAllObjects:@"SocialNetworks"];
}

- (void)removeTags {
    [self deleteAllObjects:@"Tags"];
}

- (void)removeTags_Results {
    [self deleteAllObjects:@"Tags_Results"];
}

- (void)removeUsers {
    [self deleteAllObjects:@"Users"];
}

- (void)removeUsers_SocialNetworks {
    [self deleteAllObjects:@"Users_SocialNetworks"];
}

- (void)removeVariables {
    [self deleteAllObjects:@"Variables"];
}

- (void) deleteAllObjects: (NSString *) entityDescription  {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityDescription inManagedObjectContext:dataController.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *items = [dataController.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    for (NSManagedObject *managedObject in items) {
        [dataController.managedObjectContext deleteObject:managedObject];
        NSLog(@"%@ object deleted",entityDescription);
    }
    if (![dataController.managedObjectContext save:&error]) {
        NSLog(@"Error deleting %@ - error:%@",entityDescription,error);
    }
    
}

@end
