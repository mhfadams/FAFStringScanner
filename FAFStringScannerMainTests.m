//
//  FAFStringScannerMainTests.m
//  FAFStringScannerTester
//
//  Created by Manoah F Adams on 2014-05-01.
//  Copyright 2014 Manoah F. Adams. All rights reserved.
//

#import "FAFStringScannerMainTests.h"
#import "FAFStringScanner.h"


@implementation FAFStringScannerMainTests

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



- (void) test_readRemainder
{
	FAFStringScanner* scanner = [[FAFStringScanner alloc] initWithString:@"BEGIN: A sample string :END"];
	
	NSString* result = [scanner readRemainder];
	STAssertEqualObjects(result, @"BEGIN: A sample string :END", @"readRemainder returned wrong value");
	
	[scanner release];
}

- (void) test_readBalanced_parenthesis
{
	FAFStringScanner* scanner = [[FAFStringScanner alloc] initWithString:@"(Happy days are here again)"];
	
	NSString* result = [scanner readBalanced];
	STAssertEqualObjects(result, @"(Happy days are here again)", @"readBalanced returned wrong value");
	
	[scanner release];
}

- (void) test_readBalanced_bracket
{
	FAFStringScanner* scanner = [[FAFStringScanner alloc] initWithString:@"[Happy days are here again]"];
	
	NSString* result = [scanner readBalanced];
	STAssertEqualObjects(result, @"[Happy days are here again]", @"readBalanced returned wrong value");
	
	[scanner release];
}

- (void) test_readBalanced_brace
{
	FAFStringScanner* scanner = [[FAFStringScanner alloc] initWithString:@"{Happy days are here again}"];
	
	NSString* result = [scanner readBalanced];
	STAssertEqualObjects(result, @"{Happy days are here again}", @"readBalanced returned wrong value");
	
	[scanner release];
}

- (void) test_readBalanced_quote
{
	FAFStringScanner* scanner = [[FAFStringScanner alloc] initWithString:@"\"Happy days are here again\""];
	
	NSString* result = [scanner readBalanced];
	STAssertEqualObjects(result, @"\"Happy days are here again\"", @"readBalanced returned wrong value");
	
	[scanner release];
}

- (void) test_readBalanced_all
{
	FAFStringScanner* scanner = [[FAFStringScanner alloc] initWithString:@"{([\"Happy {days are here again\"[)}"];
	
	NSString* result = [scanner readBalanced];
	STAssertEqualObjects(result, @"{([\"Happy {days are here again\"[)}", @"readBalanced returned wrong value");
	
	[scanner release];
}

- (void) test_isAtEnd
{
	FAFStringScanner* scanner = [[FAFStringScanner alloc] initWithString:@"Happy days are here again"];
	
	[scanner readToken];
	[scanner readToken];
	[scanner readToken];
	[scanner readToken];
	STAssertFalse([scanner isAtEnd], nil);
	[scanner readToken];
	STAssertTrue([scanner isAtEnd], nil);
	
	[scanner release];
}

- (void) test_advance
{
	FAFStringScanner* scanner = [[FAFStringScanner alloc] initWithString:@"Happy days are here again."];
	
	int loc = [scanner scanLocation];
	[scanner advance:1];
	STAssertTrue( ([scanner scanLocation] == loc + 1) , @"Scanner did not advance by 1");
	
	loc = [scanner scanLocation];
	[scanner advance:24];
	STAssertTrue( ([scanner scanLocation] == loc + 24) , @"Scanner did not advance by 24");
	
	loc = [scanner scanLocation];
	[scanner advance:20];
	STAssertTrue( ([scanner scanLocation] == loc) , @"Scanner errored on advance overflow.");
	
	[scanner advance: -26];
	STAssertTrue( ([scanner scanLocation] == 0) , @"Scanner errored on advance underflow.");
	
	[scanner release];
}



@end
