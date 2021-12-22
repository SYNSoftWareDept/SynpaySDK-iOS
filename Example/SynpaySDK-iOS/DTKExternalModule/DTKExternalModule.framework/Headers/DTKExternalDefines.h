//
//  DTKExternalDefines.h
//  DTKExternalModule
//
//  Created by 家琪 on 2020/12/10.
//  Copyright © 2020 DingTalk. All rights reserved.
//

#ifndef DTKExternalDefines_h
#define DTKExternalDefines_h

#ifndef DTKExternalSectionDATA
#define DTKExternalSectionDATA(sectName) __attribute((used, section("__DATA,"#sectName" ")))
#endif

#ifndef DTKExternalDeprecated
#define __DTKExternalDeprecated(message) __attribute__((deprecated(message)))
#endif


#endif /* DTExternalDefines_h */
