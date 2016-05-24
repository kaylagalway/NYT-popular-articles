//
//  NYTNewsArticle.m
//  NYT-mostviewed-API
//
//  Created by Kayla Galway on 5/19/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import "NYTNewsArticle.h"

NSString *const NYTNewsArticleConstants_dictionaryKey_title = @"abstract";
NSString *const NYTNewsArticleConstants_dictionaryKey_publishDate = @"published_date";
NSString *const NYTNewsArticleConstants_dictionaryKey_media = @"media";
NSString *const NYTNewsArticleConstants_dictionaryKey_caption = @"caption";
NSString *const NYTNewsArticleConstants_dictionaryKey_mediaMetadata = @"media-metadata";
NSString *const NYTNewsArticleConstants_dictionaryKey_mediaFormat = @"format";
NSString *const NYTNewsArticleConstants_dictionaryKey_articleURLString = @"url";
NSString *const NYTNewsArticleConstants_dictionaryKey_imageURL = @"url";
NSString *const NYTNewsArticleConstants_dictionaryKey_assetID = @"asset_id";

//Image format keys
NSString *const NYTNewsArticleConstants_imageFormat_standardThumbnail = @"Standard Thumbnail";
NSString *const NYTNewsArticleConstants_imageFormat_largeThumbnail = @"Large Thumbnail";
NSString *const NYTNewsArticleConstants_imageFormat_mediumThreeByTwo210 = @"mediumThreeByTwo210";
NSString *const NYTNewsArticleConstants_imageFormat_normal = @"Normal";
NSString *const NYTNewsArticleConstants_imageFormat_square320 = @"square320";
NSString *const NYTNewsArticleConstants_imageFormat_large = @"Large";
NSString *const NYTNewsArticleConstants_imageFormat_mediumThreeByTwo440 = @"mediumThreeByTwo440";
NSString *const NYTNewsArticleConstants_imageFormat_square640 = @"square640";
NSString *const NYTNewsArticleConstants_imageFormat_jumbo = @"Jumbo";
NSString *const NYTNewsArticleConstants_imageFormat_superJumbo = @"superJumbo";

@interface NYTNewsArticle () <NSCoding>

@property (strong, nonatomic, readwrite) NSString *title;
@property (strong, nonatomic, readwrite) NSString *publishedDate;
@property (strong, nonatomic, readwrite) NSURL *thumbnailURL;
@property (strong, nonatomic, readwrite) NSMutableDictionary *availableImages;
@property (strong, nonatomic, readwrite) NSURL *articleURL;
@property (strong, nonatomic, readwrite) NSString *assetID;

@end

@implementation NYTNewsArticle

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _title = dictionary[NYTNewsArticleConstants_dictionaryKey_title];
        _publishedDate = dictionary[NYTNewsArticleConstants_dictionaryKey_publishDate];
        _articleURL = [NSURL URLWithString: dictionary[NYTNewsArticleConstants_dictionaryKey_articleURLString]];
        _assetID = dictionary[NYTNewsArticleConstants_dictionaryKey_assetID];
        _availableImages = [@{}mutableCopy];
        
        NSArray *mediaDictionaries = dictionary[NYTNewsArticleConstants_dictionaryKey_media][0][NYTNewsArticleConstants_dictionaryKey_mediaMetadata];
        for (NSDictionary *metadataDictionary in mediaDictionaries) {
            [self mapMediaMetadata:metadataDictionary];
        }
    }
    return self;
}

-(void)mapMediaMetadata:(NSDictionary *)metaDataDict {
    NSString *imageFormat = metaDataDict[NYTNewsArticleConstants_dictionaryKey_mediaFormat];
    NSURL *imageURL = [NSURL URLWithString: metaDataDict[NYTNewsArticleConstants_dictionaryKey_imageURL]];
    _availableImages[imageFormat] = imageURL;
}

-(NSURL *)largestAvailableImageURL {
    NSArray *orderedFormatStrings = @[NYTNewsArticleConstants_imageFormat_superJumbo,
                                      NYTNewsArticleConstants_imageFormat_jumbo,
                                      NYTNewsArticleConstants_imageFormat_square640,
                                      NYTNewsArticleConstants_imageFormat_mediumThreeByTwo440,
                                      NYTNewsArticleConstants_imageFormat_large,NYTNewsArticleConstants_imageFormat_square320,
                                      NYTNewsArticleConstants_imageFormat_normal,
                                      NYTNewsArticleConstants_imageFormat_mediumThreeByTwo210,
                                      NYTNewsArticleConstants_imageFormat_largeThumbnail,
                                      NYTNewsArticleConstants_imageFormat_standardThumbnail];
    
    NSURL *imageURL;
    for (NSString *format in orderedFormatStrings) {
        imageURL = self.availableImages[format];
        if (imageURL){
            break; }
    }
    return imageURL;
}

- (NSURL *)availableThumbnailURL {
    NSURL *imageURL = self.availableImages[NYTNewsArticleConstants_imageFormat_standardThumbnail];
    return imageURL;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.publishedDate forKey:@"publishedDate"];
    [aCoder encodeObject:self.standardThumbnailURL forKey:@"standardThumbnailURL"];
    [aCoder encodeObject:self.availableImages forKey:@"availableImages"];
    [aCoder encodeObject:self.articleURL forKey:@"articleURL"];
    [aCoder encodeObject:self.assetID forKey:@"assetID"];
    [aCoder encodeObject:self.thumbnailImage forKey:@"thumbnailImage"];
    [aCoder encodeObject:self.largeImage forKey:@"largeImage"];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _title = [aDecoder decodeObjectForKey:@"title"];
        _publishedDate = [aDecoder decodeObjectForKey:@"publishedDate"];
        _standardThumbnailURL = [aDecoder decodeObjectForKey:@"standardThumbnailURL"];
        _availableImages = [aDecoder decodeObjectForKey:@"availableImages"];
        _articleURL = [aDecoder decodeObjectForKey:@"articleURL"];
        _assetID = [aDecoder decodeObjectForKey:@"assetID"];
        _thumbnailURL = [aDecoder decodeObjectForKey:@"thumbnailImage"];
        _largeImage = [aDecoder decodeObjectForKey:@"largeImage"];
    }
    return self;
}


@end

/*
 On the list, you need to show the article title and the publish date but you have free reign to show more if you wish to do so (e.g. the article's thumbnail).
 When tapping an article on the list, you need to display the details for that article.
 On the detail view, you need to show (at least) the article's title, publish date, and one of the larger images. Again, feel free to display any other information you feel might be relevant — keep in mind the response from the API will not contain the body of the article so you're not required to show it.
 */