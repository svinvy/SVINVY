//
//  BasicProxy.m
//

#import "BasicDecorator.h"
#import <objc/runtime.h>

@interface BasicDecorator()

@property(nonatomic,weak)id target;
@end
@implementation BasicDecorator

+(id)DecorateForTarget:(id)target
{
    BasicDecorator* proxy = [[self class] alloc];
    proxy.target = target;
    objc_setAssociatedObject(target, _cmd, proxy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return proxy;
}

#pragma mark - Overriden
-(BOOL)respondsToSelector:(SEL)aSelector
{
    //NECESSARRY:make sure we are doing the same work as the target.
    return [self.target respondsToSelector:aSelector];
}

- (id)forwardingTargetForSelector:(SEL)selector
{
    //NECESSARRY:forwarding the methods we are not decorating.
    return _target;
}

-(BOOL)isProxy
{
    //just mark,actually we are all proxy.
    return YES;
}

-(BOOL)isEqual:(id)object
{
    //gennerally we don't need this,except being stored as a key of dictionary,and so on
    return [_target isEqual:object];
}
-(NSUInteger)hash
{
    //as same as [isEqual:]
    return [_target hash];
}
-(Class)superclass
{
    //gennerally we don't need this,because we are doing a proxy.
    return [_target superclass];
}
-(Class)class
{
    //as same as [superClass]
    return [_target class];
}
-(BOOL)isKindOfClass:(Class)aClass
{
    //as same as [superClass]
    return [_target isKindOfClass:aClass];
}

-(NSString *)description
{
    //for debuuging
    return [_target description];
}

-(NSString *)debugDescription
{
    //for debuuging
    return [_target debugDescription];
}
@end
