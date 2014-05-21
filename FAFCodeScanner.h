//
//  FAFCodeScanner.h
//  oas-compile
//
//  Created by Manoah F Adams on 2013-08-06.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FAFStringScanner.h"


@interface FAFCodeScanner : FAFStringScanner {

}

- (NSString*) readToken;

+ (int) linesCountInArray: (NSArray*) array toIndex: (int) i;

@end
