//
//  ViewController.m
//  OCDebuggerDemo
//
//  Created by 崔 明辉 on 15/6/8.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import "ViewController.h"
#import "OCDebugger.h"
#import "OCDPrefixHeader.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.github.com"]]];
    [self test];
    [NSTimer scheduledTimerWithTimeInterval:15.0
                                     target:self
                                   selector:@selector(test)
                                   userInfo:nil
                                    repeats:YES];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)test {
    NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://raw.githubusercontent.com/CocoaPods/Specs/master/Specs/AFNetworking/2.5.4/AFNetworking.podspec.json"]];
    [postRequest setHTTPMethod:@"POST"];
    NSData *postData = [@"key1=value1&key2=value2" dataUsingEncoding:NSUTF8StringEncoding];
    [postRequest setHTTPBody:postData];
    
    [NSURLConnection sendAsynchronousRequest:postRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
    }];
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com/"]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
    }];
    NSLog(@"testPoint Bool = %d", [self testPoint]);
    NSLog(@"testText text = %@", [self testText]);
}

- (BOOL)testPoint {
    OCDValuePoint(@"test", YES);
    return NO;
}

- (NSString *)testText {
    OCDObjectPoint(@"How", @"How?");
    return @"What?";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
