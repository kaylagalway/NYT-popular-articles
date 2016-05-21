//
//  NYTNewsAPIClient.m
//  NYT-mostviewed-API
//
//  Created by Kayla Galway on 5/19/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import "NYTNewsAPIClient.h"

//URL–Path Components
NSString *const NYTNewsAPIClientConstants_urlComponent_baseUrl = @"api.nytimes.com";
NSString *const NYTNewsAPIClientConstants_urlComponent_apiService = @"svc";
NSString *const NYTNewsAPIClientConstants_urlComponent_category = @"mostpopular";
NSString *const NYTNewsAPIClientConstants_urlComponent_version = @"v2";
NSString *const NYTNewsAPIClientConstants_urlComponent_sort = @"mostviewed";
NSString *const NYTNewsAPIClientConstants_urlComponent_timePeriod = @"7";
NSString *const NYTNewsAPIClientConstants_urlComponent_format = @".json";

//Category Components
NSString *const NYTNewsAPIClientConstants_urlComponent_category_art = @"arts";
NSString *const NYTNewsAPIClientConstants_urlComponent_category_sports = @"sports";
NSString *const NYTNewsAPIClientConstants_urlComponent_category_politics = @"politics";
NSString *const NYTNewsAPIClientConstants_urlComponent_category_US = @"u.s.";
NSString *const NYTNewsAPIClientConstants_urlComponent_category_world = @"world";
NSString *const NYTNewsAPIClientConstants_urlComponent_category_allSections = @"all-sections";

//Parameter Keys
NSString *const NYTNewsAPIClientConstants_urlParameter_apiKey = @"api-key";

//Parameter Values
NSString *const NYTNewsAPIClientConstants_urlParameterValue_apiKey = @"896558ac243a867968c80e069833ad69:4:73884796";

//NSString *const NYTNewsAPIClientConstants_offset = @"&offset=200";

@implementation NYTNewsAPIClient

#pragma mark: Factories
+(NSURL *)urlForCategory:(NewsCategory) category{
    NSString *categoryPathComponent;
    switch (category) {
        case Art:
            categoryPathComponent = NYTNewsAPIClientConstants_urlComponent_category_art;
            break;
        case Sports:
            categoryPathComponent = NYTNewsAPIClientConstants_urlComponent_category_sports;
            break;
        case Politics:
            categoryPathComponent = NYTNewsAPIClientConstants_urlComponent_category_politics;
            break;
        case US:
            categoryPathComponent = NYTNewsAPIClientConstants_urlComponent_category_US;
            break;
        case World:
            categoryPathComponent = NYTNewsAPIClientConstants_urlComponent_category_world;
        default:
            categoryPathComponent = NYTNewsAPIClientConstants_urlComponent_category_allSections;
            break;
    }
    
    NSURLComponents *components = [[NSURLComponents alloc]init];
    components.scheme = @"https";
    components.host = NYTNewsAPIClientConstants_urlComponent_baseUrl;
    components.path = [NSString stringWithFormat:@"/%@/%@/%@/%@/%@/%@%@", NYTNewsAPIClientConstants_urlComponent_apiService,
                       NYTNewsAPIClientConstants_urlComponent_category,
                       NYTNewsAPIClientConstants_urlComponent_version,
                       NYTNewsAPIClientConstants_urlComponent_sort,
                       categoryPathComponent,
                       NYTNewsAPIClientConstants_urlComponent_timePeriod,
                       NYTNewsAPIClientConstants_urlComponent_format];
    components.query = [NSString stringWithFormat:@"%@=%@", NYTNewsAPIClientConstants_urlParameter_apiKey, NYTNewsAPIClientConstants_urlParameterValue_apiKey];
    
    return components.URL;
}

#pragma mark: URL Requests

+ (void)fetchJSONForCategory:(NewsCategory) category withCompletion:(void(^)(NSDictionary *storiesDict, NSError *error)) completion
{
    NSURL *url = [NYTNewsAPIClient urlForCategory: category];
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            completion(nil, error);
        }
        NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        completion(jsonResponse, error);
    }] resume];
}


@end
