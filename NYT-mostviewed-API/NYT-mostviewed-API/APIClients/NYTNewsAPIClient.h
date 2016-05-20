//
//  NYTNewsAPIClient.h
//  NYT-mostviewed-API
//
//  Created by Kayla Galway on 5/19/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NYTNewsAPIClient : NSObject

+ (void)fetchPoliticsJSONWithCompletion: (void(^)(NSDictionary *politicsJSON, NSError *error))completion;
+ (void)fetchArtJSONWithCompletion: (void(^)(NSDictionary *artJSON, NSError *error))completion;
+ (void)fetchSportsJSONWithCompletion: (void(^)(NSDictionary *sportsJSON, NSError *error))completion;
+ (void)fetchUSJSONWithCompletion: (void(^)(NSDictionary *usJSON, NSError *error))completion;
+ (void)fetchWorldJSONWithCompletion: (void(^)(NSDictionary *worldJSON, NSError *error))completion;

@end
