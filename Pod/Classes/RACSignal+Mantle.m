//
//  RACSignal+Mantle.m
//  ReactiveMantle
//
//  Created by Martín Fernández on 1/27/15.
//  Copyright (c) 2015 Martín Fernández. All rights reserved.
//

#import "RACSignal+Mantle.h"

#import <Mantle/Mantle.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@implementation RACSignal (Mantle)

#pragma mark - Public API

- (RACSignal *)parseResponseAtKey:(id)key forClass:(Class)klass {
  return [self parseResponseWithMapping:@{ key : klass }];
}

- (RACSignal *)parseResponseForClass:(Class)klass {
  return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
    [self subscribeNext:^(id response) {
      NSError *error;

      id object = [self objectForResponse:response andKlass:klass error:&error];
      if (error) { [subscriber sendError:error]; }

      [subscriber sendNext:object];
    }];

    [self subscribeError:^(NSError *error) {
      [subscriber sendError:error];
    }];

    [self subscribeCompleted:^{
      [subscriber sendCompleted];
    }];

    return nil;
  }];
}

- (RACSignal *)parseResponseWithMapping:(NSDictionary *)mapping {
  return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
    [self subscribeNext:^(id response) {

      NSMutableDictionary *objects = [NSMutableDictionary dictionary];

      for (NSString *key in [mapping allKeys]) {
        Class klass = mapping[key];

        NSError *error;
        id object = [self objectForResponse:response[key] andKlass:klass error:&error];
        if (error) { [subscriber sendError:error]; }

        objects[key] = object;
      }

      [subscriber sendNext:objects];
    }];

    [self subscribeError:^(NSError *error) {
      [subscriber sendError:error];
    }];

    [self subscribeCompleted:^{
      [subscriber sendCompleted];
    }];

    return nil;
  }];
}

#pragma mark - Helpers

- (id)objectForResponse:(id)response andKlass:(Class)klass error:(NSError **)error {
  id object = [response isKindOfClass:[NSArray class]] ?
  [MTLJSONAdapter modelsOfClass:klass fromJSONArray:response error:error] :
  [MTLJSONAdapter modelOfClass:klass fromJSONDictionary:response error:error];

  return object;
}

@end
