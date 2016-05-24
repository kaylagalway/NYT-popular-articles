//
//  NYTCacheManager.h
//  NYT-mostviewed-API
//
//  Created by Kayla Galway on 5/19/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NYTNewsArticle.h"
#import "NYTNewsFeed.h"
#import "NYTNewsAPIClient.h"

typedef NS_ENUM(NSUInteger, ItemStatus) {
    Valid,
    Expired,
    NotFound
};

@interface NYTCacheManager : NSObject

+ (void)cacheNewsFeed:(NYTNewsFeed *)newsFeed forCategory:(NewsCategory)category;
+ (void)fetchNewsFeedForCategory:(NewsCategory)category withCompletion:(void(^)(NYTNewsFeed *feed, ItemStatus status))completion;

+ (void)cacheArticle:(NYTNewsArticle *)article inCategory:(NewsCategory)category;
//this method is taking an article stub and passing a full article object including images
//prevents us from requesting/downloading images unnecessary
+ (void)fetchCachedArticle:(NYTNewsArticle *)article inCategory:(NewsCategory)category withCompletion:(void(^)(NYTNewsArticle *article, ItemStatus status))completion;


@end
