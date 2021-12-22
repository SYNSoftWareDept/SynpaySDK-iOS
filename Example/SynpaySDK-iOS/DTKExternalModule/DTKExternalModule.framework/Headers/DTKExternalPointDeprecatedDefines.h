//
//  DTKExternalPointDeprecatedDefines.h
//  DTKExternalModule
//
//  Created by 家琪 on 2021/3/11.
//  Copyright © 2021 DingTalk. All rights reserved.
//

#ifndef DTKExternalPointDeprecatedDefines_h
#define DTKExternalPointDeprecatedDefines_h

#import <DTKExternalModule/DTKExternalDefines.h>
#import <DTKExternalModule/DTKExternalPointDefines.h>

// old api. please use DTKExternalPointImplRegister instead.
#ifndef DTKExternalPluginRegister
#define DTKExternalPluginRegister(name, class) DTKExternalPointImplRegister(name, class)
#endif


#endif /* DTKExternalPointDeprecatedDefines_h */
