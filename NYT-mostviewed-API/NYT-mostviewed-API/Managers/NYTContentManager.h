//
//  NYTContentManager.h
//  NYT-mostviewed-API
//
//  Created by Kayla Galway on 5/20/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NYTNewsFeed.h"
#import "NYTNewsArticle.h"
#import "NYTCacheManager.h"
#import "NYTNewsAPIClient.h"

//download images in api client
//turn them into UIImages
//pass them in a block


@interface NYTContentManager : NSObject

+ (void)articlesForSection:(NewsCategory)category withCompletion:(void(^)(NSArray *articlesArray))completion;

+ (void)fullStoryImageFromStub:(NYTNewsArticle *)article inCategory:(NewsCategory)category withCompletion:(void(^)(NYTNewsArticle *article))completion;

@end
