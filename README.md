# ReactiveMantle

[![CI Status](http://img.shields.io/travis/bilby91/ReactiveMantle.svg?style=flat)](https://travis-ci.org/bilby91/ReactiveMantle)
[![Version](https://img.shields.io/cocoapods/v/ReactiveMantle.svg?style=flat)](http://cocoadocs.org/docsets/ReactiveMantle)
[![License](https://img.shields.io/cocoapods/l/ReactiveMantle.svg?style=flat)](http://cocoadocs.org/docsets/ReactiveMantle)
[![Platform](https://img.shields.io/cocoapods/p/ReactiveMantle.svg?style=flat)](http://cocoadocs.org/docsets/ReactiveMantle)

## Usage

ReactiveMantle transforms NSDictionary values from a RACSignal into Mantle objects, just that.

For example, if we use `AFNetworking-RACExtensions` for Networking, you code could look like this:

Mantle model:

```
#import <Mantle/Mantle.h>

@interface Product : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSNumber *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSNumber *price;

@end

@implementation Product

#pragma mark - MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return @{
           @"id" : @"id",
           @"name" : @"name",
           @"price" : @"price"
           };
}

@end
```

Then we can make a request and transform the signal value like this:

```
@interface APIClient : NSObject

@property (strong, nonatomic) AFHTTPSessionManager *manager;

- (RACSignal *)getProducts;

@end

@implementation APIClient

- (RACSignal *)getProducts {
  NSString *path = @"/products.json";

  return [[[[self.manager rac_GET:path parameters:nil]
  replayLazily]
  parseResponseForClass:[Product class]]
  transformError];
}

@end
```

Take a look at the documentation for more information. :)

## Installation

ReactiveMantle is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "ReactiveMantle"

## Author

Martin Fernandez, fmartin91@gmail.com

## License

ReactiveMantle is available under the MIT license. See the LICENSE file for more info.

