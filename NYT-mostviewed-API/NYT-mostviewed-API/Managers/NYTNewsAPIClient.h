//
//  NYTNewsAPIClient.h
//  NYT-mostviewed-API
//
//  Created by Kayla Galway on 5/19/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NYTNewsFeed.h"
#import "NYTNewsArticle.h"

@interface NYTNewsAPIClient : NSObject


+ (void)fetchJSONForCategory:(NewsCategory) category withCompletion:(void(^)(NSDictionary *storiesDict, NSError *error)) completion;
+ (void)downloadImagesForURL:(NSURL *)largeImageURL withCompletion:(void(^)(UIImage *articleLargeImage, NSError *error))completion;


@end
