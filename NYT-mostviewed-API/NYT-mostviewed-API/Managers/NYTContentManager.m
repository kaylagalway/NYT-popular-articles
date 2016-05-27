//
//  NYTContentManager.m
//  NYT-mostviewed-API
//
//  Created by Kayla Galway on 5/20/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import "NYTContentManager.h"

@implementation NYTContentManager

+ (void)addCachedNewsFeed:(NSDictionary *)newsFeedJson toArray:(NSMutableArray *)newsFeedArray {
    NSDictionary *articlesFeed = newsFeedJson;
    for (NSDictionary *articleDict in articlesFeed) {
        [newsFeedArray addObject:articleDict];
    }
}

+ (void)addNewsFeedfromCategory:(NewsCategory)newsCategory toArray:(NSMutableArray *)newsFeedArray withDictionary:storiesJson {
    NSDictionary *arcticlesFeed = storiesJson[NYTNewsFeedConstants_JSONResponseKey_results];
    [NYTCacheManager cacheNewsFeed:[[NYTNewsFeed alloc]initWithJson:storiesJson] forCategory:newsCategory];
    for (NSDictionary *articleDict in arcticlesFeed) {
        [newsFeedArray addObject:articleDict];
    }
}


+ (void)articlesForSection:(NewsCategory)category withCompletion:(void(^)(NSArray *articlesArray))completion {
    NSMutableArray *articles = [@[]mutableCopy];
    [NYTCacheManager fetchNewsFeedForCategory:category withCompletion:^(NYTNewsFeed *feed, ItemStatus status) {
        switch (status) {
            case Valid:
            {
                [self addCachedNewsFeed:feed.feedJson[NYTNewsFeedConstants_JSONResponseKey_results] toArray:articles];
                completion(articles);
            }
                break;
            case NotFound:
            {
                [NYTNewsAPIClient fetchJSONForCategory:category withCompletion:^(NSDictionary *storiesDict, NSError *error) {
                    [self addNewsFeedfromCategory:category toArray:articles withDictionary:storiesDict];
                    completion(articles);
                }];
            }
                break;
            case Expired:
            {
                [NYTNewsAPIClient fetchJSONForCategory:category withCompletion:^(NSDictionary *storiesDict, NSError *error) {
                    if (storiesDict == nil) {
                        [self addCachedNewsFeed:feed.feedJson[NYTNewsFeedConstants_JSONResponseKey_results] toArray:articles];
                        completion(articles);
                    } else {
                        [self addNewsFeedfromCategory:category toArray:articles withDictionary:storiesDict];
                    }
                }];
            }
                break;
            default:
                break;
        }
    }];
}

+ (void)fetchImageForStory:(NYTNewsArticle *)article withCompletion:(void(^)(UIImage *articleImage))completion {
    if (article.largeImage == nil) {
        NSURL *largeImageURL = [article largestAvailableImageURL];
        [NYTNewsAPIClient downloadImagesForURL:largeImageURL withCompletion:^(UIImage *articleLargeImage, NSError *error) {
            if (!error) {
                completion(articleLargeImage);
            } else {
                return;
            }
        }];
    }
}

+ (void)fullStoryItemFromStub:(NYTNewsArticle *)article inCategory:(NewsCategory)category withCompletion:(void(^)(NYTNewsArticle *article))completion {
    [self fetchImageForStory:article withCompletion:^(UIImage *articleImage) {
        article.largeImage = articleImage;
        [NYTCacheManager cacheArticle:article inCategory:category];
    }];
}

+ (void)imageForArticle:(NYTNewsArticle *)article inCategory:(NewsCategory)category withCompletion:(void(^)(UIImage *largeImage))completion {
    if (article.largeImage) {
        completion(article.largeImage);
    } else {
        [self fullStoryItemFromStub:article inCategory:category withCompletion:^(NYTNewsArticle *article) {
            completion(article.largeImage);
        }];
    }
}



@end
