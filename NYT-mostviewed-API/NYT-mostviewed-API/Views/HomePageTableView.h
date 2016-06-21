//
//  HomePageTableView.h
//  NYT-mostviewed-API
//
//  Created by Kayla Galway on 5/19/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NYTContentManager.h"
#import "NYTNewsAPIClient.h"
#import "NYTNewsFeed.h"
#import "NYTNewsArticle.h"

@class HomePageTableView;

@protocol HomePageTableViewDelegate <NSObject>

@optional

-(void)tableViewDidLoad;

@end

@interface HomePageTableView : UITableView;

@property (weak, nonatomic) id<HomePageTableViewDelegate> delegate;

-(NSInteger)numberOfRows;
-(UITableViewCell *)cellForArticleAtIndex:(NSIndexPath *)indexPath;
-(void)reloadData;

@end

