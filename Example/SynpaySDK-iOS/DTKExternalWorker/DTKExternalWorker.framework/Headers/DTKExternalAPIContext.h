//
//  DTKExternalAPIContext.h
//  DTKExternalWorker
//
//  Created by 家琪 on 2020/12/12.
//  Copyright © 2020 Alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DTKExternalModule/DTKExternalModule.h>

NS_ASSUME_NONNULL_BEGIN

@interface DTKExternalAPIContext : NSObject <DTKExternalAPIContext>

@property (nonatomic, copy, nonnull, readwrite) NSString *bundleId;

@end

NS_ASSUME_NONNULL_END
