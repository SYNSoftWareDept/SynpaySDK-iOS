//
//  DTKExternalPluginDefines.h
//  DTKExternalModule
//
//  Created by 家琪 on 2020/12/21.
//  Copyright © 2020 DingTalk. All rights reserved.
//

#ifndef DTKExternalPluginDefines_h
#define DTKExternalPluginDefines_h

#import <DTKExternalModule/DTKExternalDefines.h>

#ifndef DTKExternalPointImplRegister
#define DTKExternalPointImplRegister(pointName, impl) char * k##pointName##impl DTKExternalSectionDATA(DTComponentSec) = ""#pointName"|"#impl"";
#endif

#endif /* DTExternalPluginDefines_h */
