//
// LTThread.h
// LTUtl
//
//  Auther:    田高伟
//  email:     mailto:t@ltove.com
//  webSite:   https://www.ltove.com
//  GitHub:    https://github.com/LTOVEM/
//
// Created by LTOVE on 2019/6/19.
// Copyright © 2019 LTOVE. All rights reserved.
//  线程保活
    

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^LTThreadTask)(void);

@interface LTThread : NSObject

/// start a thread exe an task
/// @param task need exe task
- (void)exeCuteTask:(LTThreadTask)task;
/// end loop
- (void)cancel;
@end

NS_ASSUME_NONNULL_END
