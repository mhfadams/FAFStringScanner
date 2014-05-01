#import <Foundation/Foundation.h>
#import "FAFStringScanner.h"

int main (int argc, const char * argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

    // insert code here...
    NSLog(@"Hello, World!");
	
	FAFStringScanner* scanner = [[FAFStringScanner alloc] initWithString:@"HEllo"];
	
	
	
    NSLog([scanner readRemainder]);
	
	
	[scanner release];
	
	
    [pool drain];
    return 0;
}
