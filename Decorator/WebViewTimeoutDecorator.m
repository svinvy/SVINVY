//
//  WebViewDelegateProxy.m
//  
//
//  Created by svinvy on 2019/11/23.
//  Copyright © 2019 svinvy. All rights reserved.
//

#import "WebViewTimeoutDecorator.h"
#import "WeakProxy.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

@implementation WebViewTimeoutDecorator
{
    NSTimer *_timer;
    NSInteger _coutingValue;
    UIWebView *__weak _associatingWebView;
    void(^_timeoutHandle)(UIWebView*webView);
}
-(void)handleForTimeoutCalling:(void (^)(UIWebView * _Nullable))handle
{
    _timeoutHandle = [handle copy];
}

#pragma mark - Overridden
-(BOOL)respondsToSelector:(SEL)aSelector
{
    if (aSelector==@selector(webViewDidStartLoad:)||aSelector==@selector(webViewDidFinishLoad:)||aSelector==@selector(webView:didFailLoadWithError:)) {
        return YES;//to make sure we could 
    }
    return [super respondsToSelector:aSelector];
}
#pragma mark - UIWebViewDelegate
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    if (_timer) {
        [_timer invalidate];_timer = nil;
    }
    _associatingWebView = webView;
    _coutingValue = 0;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:[BasicDecorator DecorateForTarget:self] selector:@selector(timeoutCounting) userInfo:nil repeats:YES];
    if ([self.target respondsToSelector:@selector(webViewDidStartLoad:)]) {
        [self.target webViewDidStartLoad:webView];
    }
 
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self _stopCouting];
    [self.target webViewDidFinishLoad:webView];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self _stopCouting];
    [self.target webView:webView didFailLoadWithError:error];
}

#pragma mark - TimerEvent
- (void)timeoutCounting
{
    _coutingValue++;
    if(_coutingValue>=_timeoutInterval){
        //stop
        [self _stopCouting];
    }
    //ticking
}

#pragma mark - Privates
- (void)_stopCouting
{
    [_timer invalidate];_timer = nil;
    if (_associatingWebView.isLoading) {
        [_associatingWebView stopLoading];
        if(_timeoutHandle){_timeoutHandle(_associatingWebView);}
    }
    _associatingWebView = nil;
}
@end
