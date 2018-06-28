//
//  LPKeyValueObsever.m
//  KVC&KVO
//
//  Created by Jack on 2018/6/28.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import "LPKeyValueObsever.h"

@interface LPKeyValueObsever ()

@property (nonatomic,weak) id observer;
@property (nonatomic,copy) NSString *keyPath;

@end

@implementation LPKeyValueObsever

- (instancetype)initWithObject:(id)object keyPath:(NSString *)keyPath target:(id)target selector:(SEL)selector options:(NSKeyValueObservingOptions)options {
    if (object == nil) {
        return nil;
    }
    NSParameterAssert(target != nil);
    NSParameterAssert([target respondsToSelector:selector]);
    
    if (self = [super init]) {
        self.observer = object;
        self.target = target;
        self.selector = selector;
        self.keyPath = keyPath;
        
        [object addObserver:self forKeyPath:keyPath options:options context:(__bridge void * _Nullable)(self)];
    }
    return self;
}

+ (instancetype)observerObject:(id)object keyPath:(NSString *)keyPath target:(id)target selector:(SEL)selector options:(NSKeyValueObservingOptions)options {
    return [[self alloc] initWithObject:object keyPath:keyPath target:target selector:selector options:options];
}

+ (instancetype)observerObject:(id)object keyPath:(NSString *)keyPath target:(id)target selector:(SEL)selector {
    return [[self alloc] initWithObject:object keyPath:keyPath target:target selector:selector options:NSKeyValueObservingOptionNew];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (context == (__bridge void * _Nullable)(self)) {
        [self didChange:change];
    }
}

- (void)didChange:(NSDictionary *)change {
    id strongTarget = self.target;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [strongTarget performSelector:self.selector withObject:change];
#pragma clang diagnostic pop
}

- (void)dealloc {
    [self.observer removeObserver:self forKeyPath:self.keyPath];
}

@end


