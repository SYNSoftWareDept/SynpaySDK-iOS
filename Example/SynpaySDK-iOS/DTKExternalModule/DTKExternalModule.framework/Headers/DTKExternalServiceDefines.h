//
//  DTKExternalServiceDefines.h
//  DTKExternalModule
//
//  Created by 家琪 on 2020/12/25.
//  Copyright © 2020 DingTalk. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#ifndef DTKExternalGetImpl
#define DTKExternalGetImpl(bundleId, protocolName) _DTExternalGetImpl(bundleId, @protocol(protocolName))
#endif

FOUNDATION_EXTERN id _DTExternalGetImpl(NSString *bundleId, Protocol *protocol);

NS_ASSUME_NONNULL_END
