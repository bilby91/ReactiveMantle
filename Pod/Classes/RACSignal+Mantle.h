//
//  RACSignal+Mantle.h
//  ReactiveMantle
//
//  Created by Martín Fernández on 1/27/15.
//  Copyright (c) 2015 Martín Fernández. All rights reserved.
//

#import "RACSignal.h"

@class RACSignal;

@interface RACSignal (Mantle)

/**
 *  Transforms a NSDictionary value at a specified key into an MTLModel object of type klass
 *
 *  @param key   The key where response should be mapped
 *  @param klass The destination object Class
 *
 *  @return A new signal that will send the object on sendNext
 */
- (RACSignal *)parseResponseAtKey:(id)key forClass:(Class)klass;

/**
 *  Transforms a NSDictionary value into an MTLModel object of type klass
 *
 *  @param klass The destination object Class
 *
 *  @return A new signal that will send the object on sendNext
 */
- (RACSignal *)parseResponseForClass:(Class)klass;

/**
 *  Transforms a NSDictionary value at the specified keys into MTLModel objects of their given klass
 *
 *  An example mapping could be:
 *  
 *  NSDictionary *mapping = @{ @"user" : [User class], @"products" : [Product class] };
 *   
 *  @param mapping The mapping for the response
 *
 *  @return A new signal that will send the objects on sendNext
 */
- (RACSignal *)parseResponseWithMapping:(NSDictionary *)mapping;

@end
