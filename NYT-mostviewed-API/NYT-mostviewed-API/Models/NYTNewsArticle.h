//
//  NYTNewsArticle.h
//  NYT-mostviewed-API
//
//  Created by Kayla Galway on 5/19/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NYTNewsArticle : NSObject

@property (strong, nonatomic, readonly) NSString *title;
@property (strong, nonatomic, readonly) NSString *publishedDate;
@property (strong, nonatomic, readonly) NSURL *standardThumbnailURL;
@property (strong, nonatomic, readonly) NSMutableDictionary *availableImages;
@property (strong, nonatomic, readonly) NSURL *articleURL;
@property (strong, nonatomic, readonly) NSString *assetID;

@property (strong, nonatomic) UIImage *thumbnailImage;
@property (strong, nonatomic) UIImage *largeImage;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (NSURL *)largestAvailableImageURL;


@end
