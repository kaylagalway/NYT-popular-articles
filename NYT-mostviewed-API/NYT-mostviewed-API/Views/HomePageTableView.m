//
//  HomePageTableView.m
//  NYT-mostviewed-API
//
//  Created by Kayla Galway on 5/19/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import "HomePageTableView.h"

@interface HomePageTableView ()

@property (strong, nonatomic, readwrite) NSArray *newsStoriesArray;

@end

@implementation HomePageTableView


-(void)setConstraintsForCell:(UITableViewCell *)cell {
    [cell.textLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [cell.textLabel.widthAnchor constraintEqualToAnchor:cell.widthAnchor multiplier:0.5].active = YES;
    [cell.textLabel.centerYAnchor constraintEqualToAnchor:cell.centerYAnchor].active = YES;
    [cell.textLabel.leftAnchor constraintEqualToAnchor:cell.leftAnchor constant:25].active = YES;
    
    [cell.detailTextLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [cell.detailTextLabel.topAnchor constraintEqualToAnchor:cell.topAnchor constant:10].active = YES;
    [cell.detailTextLabel.rightAnchor constraintEqualToAnchor:cell.rightAnchor constant:-25].active = YES;
}

-(void)reloadData {
    __weak typeof(self) weakSelf = self;
    [NYTContentManager articlesForSection:World withCompletion:^(NSArray *articlesArray) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSMutableArray *articles = [@[]mutableCopy];
        for (NSDictionary *newsArticleDict in articlesArray) {
            [articles addObject: [[NYTNewsArticle alloc] initWithDictionary:newsArticleDict]];
        }
        strongSelf.newsStoriesArray = articles;
        if (strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(tableViewDidLoad)]) {
            [strongSelf.delegate tableViewDidLoad];
        }
    }];
}



-(NSInteger)numberOfRows {
    return [self.newsStoriesArray count];
}

-(UITableViewCell *)cellForArticleAtIndex:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    NYTNewsArticle *currentArticle = self.newsStoriesArray[indexPath.row];
    cell.textLabel.text = currentArticle.title;
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:12];
    cell.textLabel.textColor = [UIColor lightGrayColor];
    NSLog(@"%@", currentArticle.publishedDate);
    cell.detailTextLabel.text = currentArticle.publishedDate;
    cell.detailTextLabel.font = [UIFont fontWithName:@"Helvetica" size:12];
    cell.detailTextLabel.textColor = [UIColor whiteColor];

cell.backgroundColor = [UIColor blackColor];
[self setConstraintsForCell:cell];
    
return cell;
}

@end
