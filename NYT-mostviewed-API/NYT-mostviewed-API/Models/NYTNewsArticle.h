//
//  NYTNewsArticle.h
//  NYT-mostviewed-API
//
//  Created by Kayla Galway on 5/19/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NYTNewsArticle : NSObject

@property (strong, nonatomic, readonly) NSString *title;
@property (strong, nonatomic, readonly) NSString *publishedDate;
@property (strong, nonatomic, readonly) NSURL *thumbnailURL;
@property (strong, nonatomic, readonly) NSURL *largeImageURL;
@property (strong, nonatomic, readonly) NSURL *articleURL;
@property (strong, nonatomic, readonly) NSString *assetID;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
