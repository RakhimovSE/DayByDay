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
    [self removeDifficulties];
    [self removeEnergies];
    [self removeHotSpotActivities];
    [self removeHotSpotActivitiesDefault];
    [self removeHotSpotCategories];
    [self removeHotSpotCategoriesDefault];
    [self removeHotSpots];
    [self removeHotSpotsDefault];
    [self removeLocations];
    [self removePeriodTypes];
    [self removePriorities];
    [self removeQualities];
    [self removeRates];
    [self removeReferences];
    [self removeResults];
    [self removeResultsLinks];
    [self removeResultsReferences];
    [self removeSocialNetworks];
    [self removeTags];
    [self removeTagsResults];
    [self removeUsers];
    [self removeUsersSocialNetworks];
    [self removeWeekLimits];
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

- (void)removeResultsLinks {
    [self deleteAllObjects:@"ResultsLinks"];
}

- (void)removeResultsReferences {
    [self deleteAllObjects:@"ResultsReferences"];
}

- (void)removeSocialNetworks {
    [self deleteAllObjects:@"SocialNetworks"];
}

- (void)removeTags {
    [self deleteAllObjects:@"Tags"];
}

- (void)removeTagsResults {
    [self deleteAllObjects:@"TagsResults"];
}

- (void)removeUsers {
    [self deleteAllObjects:@"Users"];
}

- (void)removeUsersSocialNetworks {
    [self deleteAllObjects:@"UsersSocialNetworks"];
}

- (void)removeWeekLimits {
    [self deleteAllObjects:@"WeekLimits"];
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
