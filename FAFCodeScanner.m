//
//  FAFCodeScanner.m
//  oas-compile
//
//  Created by Manoah F Adams on 2013-08-06.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "FAFCodeScanner.h"


@implementation FAFCodeScanner

- (NSString*) readToken {
	NSString* token = [super readToken];
	
	if ([[NSArray arrayWithObjects:@">", @"<", @"=", @"!", nil] containsObject:token]) {
		if ([[self nextToken] isEqual:@"="]) {
			return [token stringByAppendingString:[self readToken]];
		}
		
	} else if ([token isEqual: @"+"] && [[self nextToken] isEqual:@"+"]) {
		return [token stringByAppendingString:[self readToken]];
	} else if ([token isEqual: @"-"] && [[self nextToken] isEqual:@"-"]) {
		return [token stringByAppendingString:[self readToken]];
	} else if (([token intValue] || [token isEqual:@"0"]) && [[self nextToken] isEqual:@"."]) {
		// floating point number
		[self readToken]; // past period char
		NSString* t2 = [self readToken]; // assuming for now an integer
		NSString* s = [NSString stringWithFormat:@"%@.%@", token, t2];
		return s;
	}
	
	return token;
}

- (int) currentLineCount {
	NSString *string = [_string substringToIndex:[self scanLocation]];
	unsigned numberOfLines, index, stringLength = [string length];
	for (index = 0, numberOfLines = 0; index < stringLength; numberOfLines++)
		index = NSMaxRange([string lineRangeForRange:NSMakeRange(index, 0)]);
	return numberOfLines;
}

+ (int) linesCountInArray: (NSArray*) array toIndex: (int) i {
	int count = 0;
	NSEnumerator* e = [array objectEnumerator];
	NSString* s;
	while (s = [e nextObject]) {
		if ([s isEqual:@"\n"]) count++;
	}
	return count;
}


@end
