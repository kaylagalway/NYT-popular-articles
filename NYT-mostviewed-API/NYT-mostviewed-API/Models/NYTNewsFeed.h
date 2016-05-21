//
//  NYTNewsFeed.h
//  NYT-mostviewed-API
//
//  Created by Kayla Galway on 5/20/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import <Foundation/Foundation.h>

//JSON Response Keys
extern NSString *const NYTNewsFeedConstants_JSONResponseKey_results;

typedef NS_ENUM(NSUInteger, NewsCategory) {
    Art,
    Sports,
    Politics,
    US,
    World
};

@interface NYTNewsFeed : NSObject

- (instancetype)initWithJson:(NSDictionary *)json;

@property (strong, nonatomic, readonly) NSDictionary *feedJson;
@property (strong, nonatomic, readonly) NSDate *creationDate;

@end
