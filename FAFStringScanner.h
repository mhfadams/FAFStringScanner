//
//  FAFStringScanner.h
//  oas-compile
//
//  Created by Manoah F Adams on 2013-06-28.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FAFStringScanner : NSObject {
	NSString*	_string;
	int			_scanLoc;
	int			_maxLoc;
	NSRange		_lastFind;

	NSArray*			alphaNums;
	NSArray*			whiteSpaces;
}


- (id) initWithString:(NSString*)input;

- (int) scanLocation;
- (void) setScanLocation:(int)loc;
- (void) advance:(int) count;

- (BOOL) isAtEnd;

- (NSString*) readUntilString:(NSString*)findString;
- (NSString*) readUntilStringAdvancingTo:(NSString*)findString;
- (NSString*) readUntilStringAdvancingPast:(NSString*)findString;

- (NSRange) _findString:(NSString*)aString;
- (NSString*) readUntilStrings:(NSArray*)findStrings matchString:(NSString* *)string;
- (NSString*) readUntilStringsAdvancingTo:(NSArray*)findStrings matchString:(NSString* *)string;
- (NSString*) readUntilStringsAdvancingPast:(NSArray*)findStrings matchString:(NSString* *)string;

- (NSString*) readRemainder;

- (NSString*) prevCharacter;
- (NSString*) currentCharacter;
- (NSString*) nextCharacter;
- (NSString*) readCharacter;

- (NSString*) readBalanced;

- (NSString*) nextToken;
- (NSString*) readToken;
- (NSArray*) readTokensBalanced;


@end
