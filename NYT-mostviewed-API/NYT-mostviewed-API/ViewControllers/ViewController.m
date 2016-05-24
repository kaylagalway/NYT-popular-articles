//
//  ViewController.m
//  NYT-mostviewed-API
//
//  Created by Kayla Galway on 5/19/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import "ViewController.h"
#import "NYTNewsAPIClient.h"
#import "NYTNewsFeed.h"
#import "NYTNewsArticle.h"
#import "NYTCacheManager.h"
#import "NYTContentManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [NYTContentManager articlesForSection:Sports withCompletion:^(NSArray *articlesArray) {
        NSLog(@"%@", articlesArray);
        NYTNewsArticle *firstArticle = articlesArray[0];
        [NYTContentManager fullStoryImageFromStub:firstArticle inCategory:Sports withCompletion:^(NYTNewsArticle *article) {
            NSLog(@"%@", firstArticle.largeImage);
        }];
    }];

    
/*
    [NYTNewsAPIClient fetchJSONForCategory: World withCompletion:^(NSDictionary *storiesDict, NSError *error) {
        NSLog(@"%@", storiesDict);
        NYTNewsFeed *currentFeed = [[NYTNewsFeed alloc]initWithJson:storiesDict];
        NSLog(@"%@", currentFeed);
        [NYTCacheManager cacheNewsFeed:currentFeed forCategory:World];
        [NYTCacheManager fetchNewsFeedForCategory:World withCompletion:^(NYTNewsFeed *feed, ItemStatus status) {
            NSLog(@"%@", feed);
        }];
        
        
        NYTNewsArticle *newArticle = [[NYTNewsArticle alloc]initWithDictionary:storiesDict[@"results"][0]];
        
        [NYTCacheManager cacheArticle:newArticle inCategory:World];
        [NYTCacheManager fetchCachedArticle:newArticle inCategory:World withCompletion:^(NYTNewsArticle *article, ItemStatus status) {
        }];
    }];
*/
    

    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
