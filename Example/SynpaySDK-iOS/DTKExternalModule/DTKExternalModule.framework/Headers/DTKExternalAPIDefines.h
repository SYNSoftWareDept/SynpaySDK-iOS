//
//  DTKExternalAPIDefines.h
//  DTKExternalModule
//
//  Created by 家琪 on 2020/12/10.
//  Copyright © 2020 DingTalk. All rights reserved.
//

#ifndef DTKExternalAPIDefines_h
#define DTKExternalAPIDefines_h

#import <Foundation/Foundation.h>
#import <DTKExternalModule/DTKExternalDefines.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DTKExternalAPIRequest <NSObject>

@property (nonatomic, copy, nullable) NSString *apiName;
@property (nonatomic, copy, nullable) NSDictionary *data __DTKExternalDeprecated("Use plainJSParams instead.");//js api中参数param对应的内容
/**
 @brief js api中平摊的参数，如需取原来废弃的data字段，请调用plainJSParams[@"param"]
 */
@property (nonatomic, copy, nullable, readwrite) NSDictionary *plainJSParams;

@property (nonatomic, copy, nullable, readwrite) NSDictionary *requestParams;
@end

@protocol DTKExternalAPIContext <NSObject>

@property (nonatomic, copy, nonnull) NSString *externalAppId __DTKExternalDeprecated("Use bundleId instead.");
@property (nonatomic, copy, nonnull) NSString *bundleId;

@end

typedef void(^DTKExternalAPICallback)(id _Nullable responseData);


NS_ASSUME_NONNULL_END


#endif /* DTExternalAPIDefines_h */
