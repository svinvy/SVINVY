//
//  WebViewDelegateProxy.h
//
//
//  Created by svinvy on 2019/11/23.
//  Copyright © 2019 svinvy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BasicDecorator.h"

NS_ASSUME_NONNULL_BEGIN

@interface WebViewTimeoutDecorator : BasicDecorator<UIWebViewDelegate>

@property(nonatomic,assign)NSTimeInterval timeoutInterval;

/*
 * Default will only stop webview loading and you could do more things by registering handle.
 */
- (void)handleForTimeoutCalling:(void(^)(UIWebView *_Nullable webView))handle;
@end

NS_ASSUME_NONNULL_END
