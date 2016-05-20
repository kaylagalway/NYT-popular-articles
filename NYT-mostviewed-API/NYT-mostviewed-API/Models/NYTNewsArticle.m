//
//  NYTNewsArticle.m
//  NYT-mostviewed-API
//
//  Created by Kayla Galway on 5/19/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import "NYTNewsArticle.h"

typedef NS_ENUM(NSUInteger, ImageType) {
    Square320,
    StandardThumbnail,
    Normal,
    Large,
    Jumbo,
    SuperJumbo,
    Square640,
    LargeThumbnail,
    MediumThreeByTwo210,
    MediumThreeByTwo440
};

NSString *const NYTNewsArticleConstants_dictionaryKey_title = @"abstract";
NSString *const NYTNewsArticleConstants_dictionaryKey_publishDate = @"published_date";
NSString *const NYTNewsArticleConstants_dictionaryKey_media = @"media";
NSString *const NYTNewsArticleConstants_dictionaryKey_caption = @"caption";
NSString *const NYTNewsArticleConstants_dictionaryKey_mediaMetaData = @"media-metadata";
NSString *const NYTNewsArticleConstants_dictionaryKey_articleURLString = @"url";
NSString *const NYTNewsArticleConstants_dictionaryKey_imageURL = @"url";
NSString *const NYTNewsArticleConstants_dictionaryKey_assetID = @"asset_id";

@interface NYTNewsArticle ()
@property (strong, nonatomic, readwrite) NSString *title;
@property (strong, nonatomic, readwrite) NSString *publishedDate;
@property (strong, nonatomic, readwrite) NSURL *thumbnailURL;
@property (strong, nonatomic, readwrite) NSURL *largeImageURL;
@property (strong, nonatomic, readwrite) NSURL *articleURL;
@property (strong, nonatomic, readwrite) NSString *assetID;
@end

@implementation NYTNewsArticle

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _title = dictionary[NYTNewsArticleConstants_dictionaryKey_title];
        _publishedDate = dictionary[NYTNewsArticleConstants_dictionaryKey_publishDate];
        _articleURL = [NSURL URLWithString: [dictionary[NYTNewsArticleConstants_dictionaryKey_articleURLString]stringValue]];
        _assetID = dictionary[NYTNewsArticleConstants_dictionaryKey_assetID];
        
        NSArray *mediaDictArray = dictionary[NYTNewsArticleConstants_dictionaryKey_media][NYTNewsArticleConstants_dictionaryKey_mediaMetaData];
        _thumbnailURL = [NSURL URLWithString: [mediaDictArray[StandardThumbnail][NYTNewsArticleConstants_dictionaryKey_imageURL] stringValue]];
        _largeImageURL = [NSURL URLWithString: [mediaDictArray[Large][NYTNewsArticleConstants_dictionaryKey_imageURL]stringValue]];
    }
    return self;
}


@end

/*
 On the list, you need to show the article title and the publish date but you have free reign to show more if you wish to do so (e.g. the article's thumbnail).
 When tapping an article on the list, you need to display the details for that article.
 On the detail view, you need to show (at least) the article's title, publish date, and one of the larger images. Again, feel free to display any other information you feel might be relevant — keep in mind the response from the API will not contain the body of the article so you're not required to show it.
 */