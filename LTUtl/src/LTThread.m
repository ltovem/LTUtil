//
// LTThread.m
// LTUtl
//
//  Auther:    田高伟
//  email:     mailto:t@ltove.com
//  webSite:   https://www.ltove.com
//  GitHub:    https://github.com/LTOVEM/
//
// Created by LTOVE on 2019/6/19.
// Copyright © 2019 LTOVE. All rights reserved.
//


#import "LTThread.h"

@interface LTThread ()
@property (nonatomic,strong)NSThread *thread;
@end

@implementation LTThread

- (instancetype)init{
    if(self = [super init]){
        self.thread = [[NSThread alloc]initWithBlock:^{
           
            CFRunLoopSourceContext content = {0};
            CFRunLoopSourceRef source = CFRunLoopSourceCreate(kCFAllocatorDefault, 0, &content);
            CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopDefaultMode);
            CFRelease(source);
            CFRunLoopRunInMode(kCFRunLoopDefaultMode, 1.0e10, false);
        }];
        [self.thread start];
    }
    return self;
}

- (void)exeCuteTask:(LTThreadTask)task{
    if(!self.thread || !task) return;
    [self performSelector:@selector(__executeTask:) onThread:self.thread withObject:nil waitUntilDone:NO];
}

- (void)cancel{
    if(!self.thread) return;
    [self performSelector:@selector(__stop) onThread:self.thread withObject:nil waitUntilDone:YES];
}
- (void)dealloc{
    [self cancel];
}
#pragma mark - private methods

- (void)__stop{
    CFRunLoopStop(CFRunLoopGetCurrent());
    self.thread = nil;
}

- (void)__executeTask:(LTThreadTask)task{
    task();
}
@end
