//
//  ViewController.m
//  NYT-mostviewed-API
//
//  Created by Kayla Galway on 5/19/16.
//  Copyright © 2016 edu.self. All rights reserved.
//

#import "ViewController.h"
#import "NYTNewsAPIClient.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [NYTNewsAPIClient fetchWorldJSONWithCompletion:^(NSDictionary *worldJSON, NSError *error) {
        NSLog(@"%@", worldJSON);
    }];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
