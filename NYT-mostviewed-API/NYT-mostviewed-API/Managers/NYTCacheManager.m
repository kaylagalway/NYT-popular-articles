//
//  NYTCacheManager.m
//  NYT-mostviewed-API
//
//  Created by Kayla Galway on 5/19/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import "NYTCacheManager.h"

NSString *const NYTCacheManagerConstants_feedJsonCachePath = @"Feeds";
NSString *const NYTCacheManagerConstants_articleCachePath = @"Articles";
NSUInteger const NYTCacheManagerConstants_hoursBeforeExpiration = 24;

@implementation NYTCacheManager

//returns user writable path directory
+ (NSString *)cacheDirectory {
    NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return searchPaths.firstObject;
}

//filepath factories
+ (NSString *)cacheLocationForFeedCategory:(NewsCategory)category {
    NSString *feedsDirectory = [[self cacheDirectory]stringByAppendingPathComponent:NYTCacheManagerConstants_feedJsonCachePath];
    NSString *categoryDirectory = [feedsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%lu", (unsigned long)category]];
    if (![[NSFileManager defaultManager] fileExistsAtPath:categoryDirectory]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:categoryDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return categoryDirectory;
}

+(NSString *)cacheLocationForArticle:(NYTNewsArticle *)article inCategory:(NewsCategory)category {
    NSString *articleDirectory = [[self cacheLocationForFeedCategory:category] stringByAppendingPathComponent:NYTCacheManagerConstants_articleCachePath];
    if (![[NSFileManager defaultManager] fileExistsAtPath:articleDirectory]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:articleDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return articleDirectory;
}

//checking if article status expired
+ (ItemStatus)cacheStatusForFeed:(NYTNewsFeed *)feed {
    NSTimeInterval distanceBetweenDates = [[NSDate date] timeIntervalSinceDate:feed.creationDate];
    double secondsPerHour = 3600;
    if ((distanceBetweenDates / secondsPerHour) < NYTCacheManagerConstants_hoursBeforeExpiration) {
        return Valid;
    }
    return Expired;
}

+ (void)clearCacheForCategory:(NewsCategory)category {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *directory = [self cacheLocationForFeedCategory:category];
    [fileManager removeItemAtPath:directory error:nil];
}

+ (void)cacheNewsFeed:(NYTNewsFeed *)newsFeed forCategory:(NewsCategory)category {
    [self clearCacheForCategory:category];
    NSString *fileName = [[self cacheLocationForFeedCategory:category] stringByAppendingPathComponent:@"feedArchive.cache"];
    [NSKeyedArchiver archiveRootObject:newsFeed toFile:fileName];
}

+ (void)fetchNewsFeedForCategory:(NewsCategory)category withCompletion:(void (^)(NYTNewsFeed *feed, ItemStatus status))completion {
    NSString *fileName = [[self cacheLocationForFeedCategory:category] stringByAppendingPathComponent:@"feedArchive.cache"];
    //can only use archiveRootObject or unarchiveObjectWithFile if the class(NYTNewsFeed) conforms to NSCoder
    NYTNewsFeed *newsFeed = [NSKeyedUnarchiver unarchiveObjectWithFile:fileName];
    if (!newsFeed) {
        completion(nil, NotFound);
        return;
    }
    completion(newsFeed, [self cacheStatusForFeed:newsFeed]);
}

+ (void)cacheArticle:(NYTNewsArticle *)article inCategory:(NewsCategory)category {
    NSString *fileName = [NSString stringWithFormat:@"%@.cache", article.assetID];
    NSString *filePath = [[self cacheLocationForArticle:article inCategory:category]stringByAppendingPathComponent:fileName];
    [NSKeyedArchiver archiveRootObject:article toFile:filePath];
}

+ (void)fetchCachedArticle:(NYTNewsArticle *)article inCategory:(NewsCategory)category withCompletion:(void (^)(NYTNewsArticle *, ItemStatus))completion {
    NSString *fileName = [NSString stringWithFormat:@"%@.cache", article.assetID];
    NSString *filePath = [[self cacheLocationForArticle:article inCategory:category]stringByAppendingPathComponent:fileName];
    NYTNewsArticle *cachedArticle = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    if (!cachedArticle) {
        completion(nil, NotFound);
        return;
    }
    completion(cachedArticle, Valid);
}





//implement file paths - where are we allowed to read and write data?

//we have a case where our cached items expire, need to be able to validate items(valid, expired, not found)

//need to be able to clear a cache

//need to be able to archive and unarchive objects and put them in the right place so that we know how to access them, what to remove when we are done with them



@end
