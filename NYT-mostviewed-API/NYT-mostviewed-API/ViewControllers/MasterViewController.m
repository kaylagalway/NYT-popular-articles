//
//  ViewController.m
//  NYT-mostviewed-API
//
//  Created by Kayla Galway on 5/19/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import "MasterViewController.h"
#import "NYTNewsAPIClient.h"
#import "NYTNewsFeed.h"
#import "NYTNewsArticle.h"
#import "NYTCacheManager.h"
#import "NYTContentManager.h"
#import "HomePageTableView.h"

@interface MasterViewController () <UITableViewDelegate, UITableViewDataSource, UITabBarDelegate, HomePageTableViewDelegate>

@property (strong, nonatomic) HomePageTableView *tableView;

@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[HomePageTableView alloc]init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    self.view.backgroundColor = [UIColor blackColor];
    [self addBannerImage];
    [self.tableView reloadData];
    [self addTableView];
//
//    [NYTContentManager articlesForSection:Sports withCompletion:^(NSArray *articlesArray) {
//        NSLog(@"%@", articlesArray);
//        NYTNewsArticle *firstArticle = [[NYTNewsArticle alloc]initWithDictionary: articlesArray[0]];
//        [NYTContentManager imageForArticle:firstArticle inCategory:World withCompletion:^(UIImage *largeImage) {
//            NSLog(@"%@", largeImage);
//        }];
//    }];

    
/*
    [NYTNewsAPIClient fetchJSONForCategory: World withCompletion:^(NSDictionary *storiesDict, NSError *error) {
        NSLog(@"%@", storiesDict);
        NYTNewsFeed *currentFeed = [[NYTNewsFeed alloc]initWithJson:storiesDict];
        NSLog(@"%@", currentFeed);
        [NYTCacheManager cacheNewsFeed:currentFeed forCategory:World];
        [NYTCacheManager fetchNewsFeedForCategory:World withCompletion:^(NYTNewsFeed *feed, ItemStatus status) {
            NSLog(@"%@", feed);
        }];
    }];
*/
}


-(void)addTableView {
    HomePageTableView *homeTableView = [[HomePageTableView alloc]init];
    homeTableView.delegate = self;
    homeTableView.dataSource = self;
    homeTableView.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview: homeTableView];
    [homeTableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [homeTableView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor].active = YES;
    [homeTableView.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:0.75].active = YES;
    [homeTableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rows = [self.tableView numberOfRows];
    return rows;

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    cell = [self.tableView cellForArticleAtIndex:indexPath];
    cell.textLabel.numberOfLines = 6;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

-(void)addBannerImage {
    UIImageView *bannerImage = [[UIImageView alloc]init];
    bannerImage.image = [UIImage imageNamed:@"snewyorktimes"];
    bannerImage.contentMode = UIViewContentModeScaleAspectFit;
    bannerImage.clipsToBounds = YES;
    [self.view addSubview:bannerImage];
    [bannerImage setTranslatesAutoresizingMaskIntoConstraints:NO];
    [bannerImage.widthAnchor constraintEqualToAnchor:self.view.widthAnchor].active = YES;
    [bannerImage.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:25].active = YES;
    [bannerImage.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:0.15].active = YES;
}

- (void)tableViewDidLoad {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

@end
