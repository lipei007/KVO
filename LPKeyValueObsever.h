//
//  LPKeyValueObsever.h
//  KVC&KVO
//
//  Created by Jack on 2018/6/28.
//  Copyright © 2018年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LPKeyValueObsever : NSObject

@property (nonatomic,weak) id target;
@property (nonatomic) SEL selector;

+ (instancetype)observerObject:(id)object keyPath:(NSString *)keyPath target:(id)target selector:(SEL)selector options:(NSKeyValueObservingOptions)options;
+ (instancetype)observerObject:(id)object keyPath:(NSString *)keyPath target:(id)target selector:(SEL)selector;

@end
