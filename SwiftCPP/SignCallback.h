//
//  SignCallback.h
//  SwiftCPP
//
//  Created by Rand Dow on 12/17/21.
//

#ifndef SignCallback_h
#define SignCallback_h

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef struct SignatureResult {
    uint8_t *sig;
    NSUInteger sigLen;
} SigResult;

// this is the signature of the Swift callback
typedef NSData * _Nonnull (^SignCb)(NSData *);

//id SwiftCallbackSignObj;        // storage for the ObjC object to call from C/C++

@interface SignCallback : NSObject
{
    SignCb swiftSignCallback;       // callback to Swift to get to the Secure Enclave
    NSData * signature;             // temp storage for the return result
}

-(void)setCallback:(SignCb)swiftSignCallback;    // called from Swift to set Swift callback
-(SigResult)signCallback:(NSData *)data; // C++ -> trampoline -> signCallback

-(void)sign;       // called from Swift to call down to the "claims generator"

@end

NS_ASSUME_NONNULL_END

#endif /* SignCallback_h */
