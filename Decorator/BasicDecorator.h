//
//  BasicProxy.h
//
//  Created by svinvy on 2019/11/23.
//  Copyright © 2019 svinvy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BasicDecorator : NSProxy
/*
 * @brief    Intercept for the other object means we should know the principle and role the target we are proxying.So all subclasses should better obviously declare and implement the interface intercepting.The another important thing is you should konw which method is "required" and which is "optional".
  Eg.@interface UIWebViewDelegateInterceptor:BasicInterceptor<UIWebViewDelegate> @end
*/
+ (id)DecorateForTarget:(id)target;

/*
 * @brief   Default will respond as the target does,which means you could not intercept the optional calling if target is not responding.So if you want to do stuff for optional methods,you MUST overridden this to OBVIOUSLY declare the selectors and before you retransfer them to the target, you should check if she could responds.
 */
- (BOOL)respondsToSelector:(SEL)aSelector;


/*
 * @brief   The target will retain the decorator to make sure both of them have the same life cycle.And the other ones should not keep the decorator to do any thing.
 * Additional,we using weak type to keep target,so you could use this for weak retaining.
 */
@property(nonatomic,weak,readonly)id target;
@end

NS_ASSUME_NONNULL_END
