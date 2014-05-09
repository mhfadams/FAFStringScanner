//
//  FAFStringScannerTokenTests.m
//  FAFStringScannerTester
//
//  Created by Manoah F Adams on 2014-05-01.
//  Copyright 2014 Manoah F. Adams. All rights reserved.
//

#import "FAFStringScannerTokenTests.h"
#import "FAFStringScanner.h"
#import "FAFCodeScanner.h"


@implementation FAFStringScannerTokenTests

- (void) setUp 
{ 
    // Create data structures here.
	NSLog(@"SET UP");

	
} 

- (void) tearDown 
{ 
    // Release data structures here. 
	NSLog(@"TEAR DOWN");
} 





- (void) test_readToken_tokenEnding
{
	FAFStringScanner* scanner = [[FAFStringScanner alloc] initWithString:@"Happy days are here again"];
	
	STAssertEqualObjects( [scanner readToken] , @"Happy" , @"Scanner failed at beginning of string.");
	
	STAssertEqualObjects( [scanner readToken] , @"days" , @"Scanner failed in middle of string.");
	
	[scanner readToken];
	[scanner readToken];
	STAssertEqualObjects( [scanner readToken] , @"again" , @"Scanner failed at end of string.");
	
	STAssertNil( [scanner readToken] , @"Failed to return nil at end of string.");
	
	[scanner release];
}

- (void) test_nextToken_tokenEnding
{
	FAFStringScanner* scanner = [[FAFStringScanner alloc] initWithString:@"Happy days are here again"];
	
	STAssertEqualObjects( [scanner nextToken] , @"Happy" , @"Scanner failed at beginning of string.");
	
	[scanner advance:5];
	STAssertEqualObjects( [scanner nextToken] , @"days" , @"Scanner failed in middle of string.");
	
	[scanner advance:14];
	STAssertEqualObjects( [scanner nextToken] , @"again" , @"Scanner failed at end of string.");
	
	
	[scanner release];
}

- (void) test_readToken_mixed_types
{
	FAFStringScanner* scanner = [[FAFStringScanner alloc] initWithString:@"Happy days; are +here again"];
	
	STAssertEqualObjects( [scanner readToken] , @"Happy" , nil);
	
	STAssertEqualObjects( [scanner readToken] , @"days" , nil);
	
	STAssertEqualObjects( [scanner readToken] , @";" , nil);
	
	STAssertEqualObjects( [scanner readToken] , @"are" , nil);
	
	STAssertEqualObjects( [scanner readToken] , @"+" , nil);
	
	STAssertEqualObjects( [scanner readToken] , @"here" , nil);
	
	[scanner release];
}

- (void) test_readToken_quoted_strings
{
	FAFStringScanner* scanner = [[FAFStringScanner alloc] initWithString:@"Happy da\"ys; are +here a\"gain \"Really\""];
	
	[scanner setShouldTokenizeQuotedStrings:YES];
	
	[scanner readToken];

	STAssertEqualObjects( [scanner readToken] , @"da" , nil);
	
	STAssertEqualObjects( [scanner readToken] , @"\"ys; are +here a\"" , nil);
		
	STAssertEqualObjects( [scanner readToken] , @"gain" , nil);
	
	STAssertEqualObjects( [scanner readToken] , @"\"Really\"" , nil);
	
	[scanner release];
}

- (void) test_readToken_code_tokens_1
{
	FAFStringScanner* scanner = [[FAFStringScanner alloc] initWithString:@"bracketCount = bracketCount - 1 -2;"];
	
	STAssertEqualObjects( [scanner readToken] , @"bracketCount" , nil);
	
	STAssertEqualObjects( [scanner readToken] , @"=" , nil);
		
	STAssertEqualObjects( [scanner readToken] , @"bracketCount" , nil);
	
	STAssertEqualObjects( [scanner readToken] , @"-" , nil);
	
	STAssertEqualObjects( [scanner readToken] , @"1" , nil);
	
	STAssertEqualObjects( [scanner readToken] , @"-" , nil);
	
	STAssertEqualObjects( [scanner readToken] , @"2" , nil);
	
	STAssertEqualObjects( [scanner readToken] , @";" , nil);
	
	[scanner release];
}

- (void) test_readToken_code_tokens_2
{
	FAFStringScanner* scanner = [[FAFStringScanner alloc] initWithString:@"bracketCount++; --i;"];
	
	STAssertEqualObjects( [scanner readToken] , @"bracketCount" , nil);
	
	STAssertEqualObjects( [scanner readToken] , @"+" , nil);
	
	STAssertEqualObjects( [scanner readToken] , @"+" , nil);
	
	STAssertEqualObjects( [scanner readToken] , @";" , nil);
	
	STAssertEqualObjects( [scanner readToken] , @"-" , nil);
	
	STAssertEqualObjects( [scanner readToken] , @"-" , nil);
	
	STAssertEqualObjects( [scanner readToken] , @"i" , nil);
	
	STAssertEqualObjects( [scanner readToken] , @";" , nil);
	
	[scanner release];
}

- (void) test_readToken_code_tokens_3
{
	FAFCodeScanner* scanner = [[FAFCodeScanner alloc] initWithString:@"bracketCount++; --i; 0.9 + 9.23"];
	
	STAssertEqualObjects( [scanner readToken] , @"bracketCount" , nil);
	
	STAssertEqualObjects( [scanner readToken] , @"++" , nil);
		
	STAssertEqualObjects( [scanner readToken] , @";" , nil);
	
	STAssertEqualObjects( [scanner readToken] , @"--" , nil);
		
	STAssertEqualObjects( [scanner readToken] , @"i" , nil);
	
	STAssertEqualObjects( [scanner readToken] , @";" , nil);
	
	STAssertEqualObjects( [scanner readToken] , @"0.9" , nil);
	
	STAssertEqualObjects( [scanner readToken] , @"+" , nil);
	
	STAssertEqualObjects( [scanner readToken] , @"9.23" , nil);
	
	[scanner release];
}





@end
