//
//  NYTCacheManager.h
//  NYT-mostviewed-API
//
//  Created by Kayla Galway on 5/19/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NYTNewsArticle.h"

typedef NS_ENUM(NSUInteger, ItemStatus) {
    Valid,
    Expired,
    NotFound
};

@interface NYTCacheManager : NSObject

+ (void)fetchPoliticsJSONWithCompletion: (void(^)(NSDictionary *politicsJSON, ItemStatus status))completion;
+ (void)fetchArtJSONWithCompletion: (void(^)(NSDictionary *artJSON, ItemStatus status))completion;
+ (void)fetchSportsJSONWithCompletion: (void(^)(NSDictionary *sportsJSON, ItemStatus status))completion;
+ (void)fetchUSJSONWithCompletion: (void(^)(NSDictionary *usJSON, ItemStatus status))completion;
+ (void)fetchWorldJSONWithCompletion: (void(^)(NSDictionary *worldJSON, ItemStatus status))completion;

+ (void)cacheArticle: (NYTNewsArticle *)article;
+ (void)fetchNewsArticleFromCacheWithId: (NSString *)articleID;


@end
