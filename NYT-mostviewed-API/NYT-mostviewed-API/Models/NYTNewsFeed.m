//
//  NYTNewsFeed.m
//  NYT-mostviewed-API
//
//  Created by Kayla Galway on 5/20/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import "NYTNewsFeed.h"

NSString *const NYTNewsFeedConstants_JSONResponseKey_results = @"results";

@interface NYTNewsFeed () <NSCoding>

@property (strong, nonatomic, readwrite) NSDictionary *feedJson;
@property (strong, nonatomic, readwrite) NSDate *creationDate;

@end

@implementation NYTNewsFeed

- (instancetype)initWithJson:(NSDictionary *)json {
    self = [super init];
    if (self) {
        _feedJson = json;
        _creationDate = [NSDate date];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.feedJson forKey:@"feedJson"];
    [aCoder encodeObject:self.creationDate forKey:@"creationDate"];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _feedJson = [aDecoder decodeObjectForKey:@"feedJson"];
        _creationDate = [aDecoder decodeObjectForKey:@"creationDate"];
    }
    return self;
}



@end
