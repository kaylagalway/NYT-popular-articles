//
//  NYTCacheManager.m
//  NYT-mostviewed-API
//
//  Created by Kayla Galway on 5/19/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import "NYTCacheManager.h"

@interface CacheItem: NSObject <NSCoding>

@property (strong, nonatomic) id contentItem;
@property (strong, nonatomic) NSDate *expirationDate;

@end

@implementation CacheItem

- (instancetype)initWithItem:(id)item {
    self = [super init];
    if (self) {
        _contentItem = item;
        _expirationDate = [[NSCalendar currentCalendar] dateByAddingUnit:NSCalendarUnitDay value:1 toDate:[NSDate date] options:0];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        _contentItem = [coder decodeObjectForKey:@"contentItem"];
        _expirationDate = [coder decodeObjectForKey:@"expirationDate"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.contentItem forKey:@"contentItem"];
    [aCoder encodeObject:self.expirationDate forKey:@"epirationDate"];
}


@end

@implementation NYTCacheManager

+ (void)fetchPoliticsJSONWithCompletion: (void(^)(NSDictionary *politicsJSON, ItemStatus status))completion{
    
}

+ (void)fetchArtJSONWithCompletion: (void(^)(NSDictionary *artJSON, ItemStatus status))completion{
    
}

+ (void)fetchSportsJSONWithCompletion: (void(^)(NSDictionary *sportsJSON, ItemStatus status))completion{
    
}

+ (void)fetchUSJSONWithCompletion: (void(^)(NSDictionary *usJSON, ItemStatus status))completion{
    
}

+ (void)fetchWorldJSONWithCompletion: (void(^)(NSDictionary *worldJSON, ItemStatus status))completion{
    
}

+ (void)cacheArticle: (NYTNewsArticle *)article{
    
}

+ (void)fetchNewsArticleFromCacheWithId: (NSString *)articleID withCompletion: (void(^)(NYTNewsArticle *article, ItemStatus status))completion{
    
}

+ (void)storeItem: (id)item {
    
}

@end
