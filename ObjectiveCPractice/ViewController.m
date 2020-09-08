//
//  ViewController.m
//  ObjectiveCPractice
//
//  Created by parker amundsen on 3/27/20.
//  Copyright © 2020 Parker Buhler Amundsen. All rights reserved.
//

#import "ViewController.h"
#import "ObjectiveCPractice-Swift.h"

@interface ViewController (){
    @private int counter;
    @private NSString* arr[1000];
}
- (void) addSubViews;
- (void) setConstraints;
- (void) configureButtons;
- (void) configureTextInput;
- (void) configureTable;
- (void) makeRequest: (NSURL*) url;
- (void) onCasesButtonPress;
- (void) onDeathsButtonPress;
- (void) onRecoveredButtonPress;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self->counter = 0;
    for (int i = 0; i < 1000; i ++) {
        arr[i] = @"";
    }
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.textInput = [UITextField new];
    self.casesButton = [UIButton new];
    self.deathsButton = [UIButton new];
    self.recoveredButton = [UIButton new];
    self.table = [UITableView new];    

    [self addSubViews];
    [self setConstraints];
    [self configureTable];
    [self.table reloadData];
    [self configureButtons];
    [self configureTextInput];
}

- (void) onCasesButtonPress {
    self->counter = 0;
    [self.view endEditing:true];
    NSURL* url = [self generateURL: 0];
    [self makeRequest:url];
}

- (void) onDeathsButtonPress {
    self->counter = 0;
    [self.view endEditing:true];
    NSURL* url = [self generateURL: 1];
    [self makeRequest:url];
}

- (void) onRecoveredButtonPress {
    self->counter = 0;
    [self.view endEditing:true];
    NSURL* url = [self generateURL:2];
    [self makeRequest: url];
}

- (void) addSubViews {
    [self.view addSubview: self.textInput];
    [self.view addSubview:self.casesButton];
    [self.view addSubview:self.deathsButton];
    [self.view addSubview:self.recoveredButton];
    [self.view addSubview:self.table];
}

- (void) setConstraints {
    [self.textInput.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = true;
    [self.textInput.topAnchor constraintLessThanOrEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:100].active = true;
    [self.textInput.heightAnchor constraintEqualToConstant:self.view.frame.size.height/20].active = true;
    
    [self.casesButton.topAnchor constraintEqualToAnchor:self.textInput.bottomAnchor constant:10].active = true;
    [self.casesButton.widthAnchor constraintEqualToConstant:self.view.frame.size.width/4].active = true;
    [self.casesButton.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:self.view.frame.size.width/16].active = true;
    
    [self.deathsButton.topAnchor constraintEqualToAnchor:self.textInput.bottomAnchor constant:10].active = true;
    [self.deathsButton.widthAnchor constraintEqualToConstant:self.view.frame.size.width/4].active = true;
    [self.deathsButton.leadingAnchor constraintEqualToAnchor:self.casesButton.trailingAnchor constant:self.view.frame.size.width/16].active = true;

    [self.recoveredButton.topAnchor constraintEqualToAnchor:self.textInput.bottomAnchor constant:10].active = true;
    [self.recoveredButton.widthAnchor constraintEqualToConstant:self.view.frame.size.width/4].active = true;
    [self.recoveredButton.leadingAnchor constraintEqualToAnchor:self.deathsButton.trailingAnchor constant:self.view.frame.size.width/16].active = true;

    [self.table.topAnchor constraintEqualToAnchor:self.casesButton.bottomAnchor constant:10].active = true;
    [self.table.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = true;
    [self.table.widthAnchor constraintEqualToAnchor:self.view.widthAnchor].active = true;
    [self.table.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-10].active = true;
}

- (void) configureButtons {
    [self.casesButton addTarget:self action: @selector(onCasesButtonPress) forControlEvents:UIControlEventTouchUpInside];
    self.casesButton.translatesAutoresizingMaskIntoConstraints = false;
    [self.casesButton setTitle:@"  Cases  " forState:UIControlStateNormal];
    self.casesButton.layer.cornerRadius = 10;
    self.casesButton.backgroundColor = UIColor.systemYellowColor;
    
    [self.deathsButton addTarget:self action: @selector(onDeathsButtonPress) forControlEvents:UIControlEventTouchUpInside];
    self.deathsButton.translatesAutoresizingMaskIntoConstraints = false;
    [self.deathsButton setTitle:@"  Deaths  " forState:UIControlStateNormal];
    self.deathsButton.layer.cornerRadius = 10;
    self.deathsButton.backgroundColor = UIColor.systemRedColor;
    
    [self.recoveredButton addTarget:self action: @selector(onRecoveredButtonPress) forControlEvents:UIControlEventTouchUpInside];
    self.recoveredButton.translatesAutoresizingMaskIntoConstraints = false;
    [self.recoveredButton setTitle:@"  Recovered  " forState:UIControlStateNormal];
    self.recoveredButton.layer.cornerRadius = 10;
    self.recoveredButton.backgroundColor = UIColor.systemGreenColor;
}
 
- (void) configureTextInput {
    self.textInput.translatesAutoresizingMaskIntoConstraints = false;
    self.textInput.placeholder = @"  Enter country here  ";
    self.textInput.backgroundColor = UIColor.whiteColor;
    self.textInput.textAlignment = NSTextAlignmentCenter;
    [self.textInput setUserInteractionEnabled:true];
    self.textInput.layer.cornerRadius = 10;
    self.textInput.autocorrectionType = UITextAutocorrectionTypeNo;
}

- (void) configureTable {
    self.table.translatesAutoresizingMaskIntoConstraints = false;
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.layer.cornerRadius = 10;
    self.table.clipsToBounds = true;
    [self.table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell* cell = [self.table dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    if (cell == nil) {
      cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    [cell.textLabel setText:arr[indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self->counter;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSURL*)generateURL: (int) requestType {
    NSString* base = @"https://api.covid19api.com/total/country/";
    
    NSString* ending;
    switch (requestType) {
        case 0:
            ending = @"/status/confirmed";
            break;
        case 1:
            ending = @"/status/deaths";
            break;
        case 2:
            ending = @"/status/recovered";
            break;
        default:
            return nil;
            break;
    }
    NSString* urlString = [NSString stringWithFormat:@"%@%@%@", base, self.textInput.text, ending];
    NSLog(urlString);
    NSURL* url = [NSURL URLWithString:urlString];
    return url;
}

- (void)makeRequest: (NSURL*) url {
    NSURLSession* session = [NSURLSession sessionWithConfiguration:NSURLSessionConfiguration.defaultSessionConfiguration
                                                          delegate:self
                                                     delegateQueue: [NSOperationQueue mainQueue]];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask* task = [session dataTaskWithRequest:request];
    [task resume];
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    NSArray* json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    if (!json) {
        NSLog(@"ERROR");
    } else {
        for (NSDictionary *item in json) {
            NSNumber* cases = item[@"Cases"];
            int intCases = [cases intValue];
            NSString* date = item[@"Date"];
            date = [date substringToIndex:10];
            NSString* concatinatedString = [NSString stringWithFormat:@"%@ %@ %d", date, @"Cases:", intCases];
            self->arr[self->counter] = concatinatedString;
            self->counter ++;
        }
        if (self->counter == 0) {
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"No countries matching"
                                       message:@"-For multi-worded countries insert \"-\".\n-Be sure to remove any whitespace"
                                       preferredStyle:UIAlertControllerStyleAlert];

            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction * action) {}];

            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
        [self.table reloadData];
    }
}
    @end
