//
//  DTKExternalAPIRequest.h
//  DTKExternalWorker
//
//  Created by 家琪 on 2020/12/12.
//  Copyright © 2020 Alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DTKExternalModule/DTKExternalModule.h>

NS_ASSUME_NONNULL_BEGIN

@interface DTKExternalAPIRequest : NSObject <DTKExternalAPIRequest>

@property (nonatomic, copy, nullable, readwrite) NSString *apiName;
@property (nonatomic, copy, nullable, readwrite) NSDictionary *data;//js api中参数param对应的内容
@property (nonatomic, copy, nullable, readwrite) NSDictionary *plainJSParams;//js api中平摊的参数
@property (nonatomic, copy, nullable, readwrite) NSDictionary *requestParams;

@end

NS_ASSUME_NONNULL_END
