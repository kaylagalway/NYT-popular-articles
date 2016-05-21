//
//  NYTContentManager.m
//  NYT-mostviewed-API
//
//  Created by Kayla Galway on 5/20/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import "NYTContentManager.h"

@implementation NYTContentManager

+ (void)articlesForSection:(NewsCategory)category withCompletion:(void(^)(NSArray *articlesArray))completion {
    NSMutableArray *articles = [@[]mutableCopy];
    [NYTCacheManager fetchNewsFeedForCategory:category withCompletion:^(NYTNewsFeed *feed, ItemStatus status) {
        switch (status) {
            case Valid:
            {
                NSDictionary *articlesFeed = feed.feedJson[NYTNewsFeedConstants_JSONResponseKey_results];
                for (NSDictionary *articleDict in articlesFeed) {
                    [articles addObject:articleDict];
                }
                completion(articles);
            }
                break;
            case NotFound:
            {
                [NYTNewsAPIClient fetchJSONForCategory:category withCompletion:^(NSDictionary *storiesDict, NSError *error) {
                    NSDictionary *arcticlesFeed = storiesDict[NYTNewsFeedConstants_JSONResponseKey_results];
                    [NYTCacheManager cacheNewsFeed:[[NYTNewsFeed alloc]initWithJson:storiesDict] forCategory:category];
                    for (NSDictionary *articleDict in arcticlesFeed) {
                        [articles addObject:articleDict];
                    }
                    completion(articles);
                }];
            }
                break;
            case Expired:
            {
                [NYTNewsAPIClient fetchJSONForCategory:category withCompletion:^(NSDictionary *storiesDict, NSError *error) {
                    if (storiesDict == nil) {
                        NSDictionary *articlesFeed = feed.feedJson[NYTNewsFeedConstants_JSONResponseKey_results];
                        for (NSDictionary *articleDict in articlesFeed) {
                            [articles addObject:articleDict];
                        }
                        completion(articles);
                    } else {
                        [NYTNewsAPIClient fetchJSONForCategory:category withCompletion:^(NSDictionary *storiesDict, NSError *error) {
                            [NYTCacheManager cacheNewsFeed:feed forCategory:category];
                            NSDictionary *arcticlesFeed = storiesDict[NYTNewsFeedConstants_JSONResponseKey_results];
                            for (NSDictionary *articleDict in arcticlesFeed) {
                                [articles addObject:articleDict];
                            }
                            completion(articles);
                        }];
                    }
                }];
            }
                break;
            default:
                break;
        }
    }];
}

@end
