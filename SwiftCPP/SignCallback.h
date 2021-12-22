//
//  CbObjc.h
//  SwiftCPP
//
//  Created by Rand Dow on 12/17/21.
//

#ifndef SignCallback_h
#define SignCallback_h

#import <Foundation/Foundation.h>


// C++ -> this trampoline -> ObjC
void signCallbackTrampoline();


NS_ASSUME_NONNULL_BEGIN

// this is the parameter between ObjC and Swift (since ObjC doesn't allow "inout" paramters)
@interface LensSignParameter: NSObject
@property NSData * data;
@property NSData * sig;
@end

// this is the signature of the Swift callback
//typedef void (^signCb)(LensSignParameter *);
typedef void (^signCb)();


@interface SignCallback : NSObject
{
    signCb swiftSignCallback;       // callback to Swift to get to the Secure Enclave
}
-(void)setCallback:(signCb)swiftSignCallback;   // called from Swift
-(void)signCallback;                            // called ultimately from C++

-(void)sign:(LensSignParameter *)data;          // called from Swift to call down to the "claims generator"

@end

NS_ASSUME_NONNULL_END

#endif /* SignCallback_h */
