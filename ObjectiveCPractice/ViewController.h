//
//  ViewController.h
//  ObjectiveCPractice
//
//  Created by parker amundsen on 3/27/20.
//  Copyright © 2020 Parker Buhler Amundsen. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, NSURLSessionDelegate>
@property(nonatomic, strong) UITextField *textInput;
@property(nonatomic, strong) UIButton *casesButton;
@property(nonatomic, strong) UIButton *deathsButton;
@property(nonatomic, strong) UIButton *recoveredButton;
@property(nonatomic, strong) UITableView *table;
@property(nonatomic, strong) BarGraph* graph;
@end

