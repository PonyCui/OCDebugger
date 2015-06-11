//
//  ViewController.m
//  OCDebuggerDemo
//
//  Created by 崔 明辉 on 15/6/8.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import "ViewController.h"
#import "OCDebugger.h"
#import "OCDLogCore.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self test];
    [NSTimer scheduledTimerWithTimeInterval:15.0
                                     target:self
                                   selector:@selector(test)
                                   userInfo:nil
                                    repeats:YES];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)test {
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://huodong.duowan.com/videoSubscribe/?r=subscribe/checksubsnew&time_ago=0"]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
    }];
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com/"]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
    }];
    NSLog(@"testPoint Bool = %d", [self testPoint]);
}

- (BOOL)testPoint {
    [OCDebugger addPointWithIdentifier:@"test" pointValue:YES pointObject:nil];
    if ([OCDebugger isPointValid:@"test"]) {
        return [OCDebugger pointValue:@"test"];
    }
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
