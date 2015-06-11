//
//  OCDDashboardSharkHooker.m
//  OCDebugger
//
//  Created by 崔 明辉 on 15/6/11.
//  Copyright (c) 2015年 PonyCui. All rights reserved.
//

#import "OCDDashboardShakeHooker.h"
#import "OCDCore.h"
#import <Aspects/Aspects.h>
#import <UIKit/UIKit.h>

@interface OCDDashboardShakeHooker ()

@property (nonatomic, strong) id<AspectToken> viewDidAppearToken;
@property (nonatomic, strong) id<AspectToken> motionEndToken;

@end

@implementation OCDDashboardShakeHooker

- (void)install {
    self.viewDidAppearToken = [UIViewController aspect_hookSelector:@selector(viewDidAppear:)
                              withOptions:AspectPositionAfter
                               usingBlock:^(id<AspectInfo> info){
                                   UIViewController *viewController = [info instance];
                                   [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
                                   [viewController becomeFirstResponder];
                               }
                                    error:NULL];
    self.motionEndToken = [UIResponder aspect_hookSelector:@selector(motionEnded:withEvent:)
                              withOptions:AspectPositionAfter
                               usingBlock:^(){
                                   [[[[OCDCore sharedCore] dashboard] wireframe] showAlertView];
                               }
                                    error:NULL];
}

- (void)uninstall {
    [self.viewDidAppearToken remove];
    [self.motionEndToken remove];
}

@end
