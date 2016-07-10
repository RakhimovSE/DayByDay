//
//  DeviceToServerSync.m
//  DayByDay
//
//  Created by Admin on 01.04.16.
//  Copyright © 2016 Sevastyan Rakhimov. All rights reserved.
//

#import "DeviceToServerSync.h"
#import "DataController.h"

@implementation DeviceToServerSync {
    DataController *dataController;
}

- (id)init {
    if (self = [super init]) {
        dataController = [[DataController alloc] init];
        return self;
    }
    return nil;
}

- (void)AllData {
    [self difficulties];
    [self energies];
    [self hotSpotActivities];
    [self hotSpotActivitiesDefault];
    [self hotSpotCategories];
    [self hotSpotCategoriesDefault];
    [self hotSpots];
    [self hotSpotsDefault];
    [self locations];
    [self periodTypes];
    [self priorities];
    [self qualities];
    [self rates];
    [self references];
    [self results];
    [self resultsLinks];
    [self resultsReferences];
    [self socialNetworks];
    [self tags];
    [self tagsResults];
    [self users];
    [self usersSocialNetworks];
}

- (void)difficulties {
    
}

- (void)energies {
    
}

- (void)hotSpotActivities {
    
}

- (void)hotSpotActivitiesDefault {
    
}

- (void)hotSpotCategories {
    
}

- (void)hotSpotCategoriesDefault {
    
}

- (void)hotSpots {
    
}

- (void)hotSpotsDefault {
    
}

- (void)locations {
    
}

- (void)periodTypes {
    
}

- (void)priorities {
    
}

- (void)qualities {
    
}

- (void)rates {
    
}

- (void)references {
    
}

- (void)results {
    
}

- (void)resultsLinks {
    
}

- (void)resultsReferences {
    
}

- (void)socialNetworks {
    
}

- (void)tags {
    
}

- (void)tagsResults {
    
}

- (void)users {
    
}

- (void)usersSocialNetworks {
    
}

- (void)weekLimits {
    
}

@end
