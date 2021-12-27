//
//  SignCallback.mm
//  SwiftCPP
//
//  Created by Rand Dow on 12/20/21.
//

#import <Foundation/Foundation.h>

#include "SignCallback.h"
#include "SignCallback.hpp"

// this is the include from the library (C2PA)
#include "signer.hpp"

// save the SignCallback Object "self" for the trampoline
id swiftCallbackSignObj;

// ObjC Object (or ObjC++)
@implementation SignCallback

-(void)setCallback:(SignCb)swiftSignCallback
{
    printf("SignCallBack.setCallback\n");
    self->swiftSignCallback = swiftSignCallback;        // save the callback to Swift
    swiftCallbackSignObj = self;                        // save the object id
}

// ObjC: C++ -> C++ callback -> C++ trampoline -> here -> indirect SwiftCallback
-(SigResult)signCallback:(NSData *)data;
{
    printf("SignCallback.signCallback\n");
    self->signature = self->swiftSignCallback(data);        // call Swift
    // marshal NSData * to C struct
    SigResult sig;
    sig.sigLen = self->signature.length;
    sig.sig = (uint8_t *)[self->signature bytes];
    return sig;
}

// Swift -> ObjC(here) -> C++ class method
-(void)sign
{
    printf("SignCallback.sign -- call the C++ libarary\n");
    // claim signer: marshal and convert parameters to pass down
    // TODO: probably need to marshal ObjC parameters to C/C++ paramters
    Signer signer;
    signer.sign(3, SignCallbackCpp::signCallback);
}
@end

// C/C++ trampoline, this uses both C and ObjC code
void SignCallbackCpp::signCallbackTrampoline(const uint8_t * data, NSUInteger dataLen,
                                                   uint8_t **sig,  NSUInteger *sigLen)
{
    printf("SignCallback.signCallbackTrampoline\n");
    SigResult sigResult = [swiftCallbackSignObj  signCallback:[NSData dataWithBytes:data length:dataLen]];
    *sig = sigResult.sig;
    *sigLen = sigResult.sigLen;
    printf("trampoline back: sigLen %lu\n", *sigLen);
    for (int i=0; i < *sigLen; i++ ) {
        printf("%d\n", (*sig)[i]);
    }
}

void SignCallbackCpp::signCallback(const std::vector<uint8_t>& data, std::vector<uint8_t>& sig)
{
    printf("SignCallbackCpp.signCallback\n");
    printf("data: %lu\n", data.size());
    for (int i=0; i<data.size(); i++) {
        printf("%d\n", data[i]);
    }
    printf("sig: %lu\n", sig.size());
   
    NSUInteger dataLen = data.size();
    const uint8_t* dataBytes = data.data();
    NSUInteger sigLen;
    uint8_t* sigBytes;
    signCallbackTrampoline(dataBytes, dataLen, &sigBytes, &sigLen);
    printf("return from trampoline: %lu\n", sigLen);
    for (int i=0; i < sigLen; i++) {
        printf("%d\n", sigBytes[i]);
    }
    // copy bytes into vector
    sig.resize(sigLen);
    memcpy(&sig[0], sigBytes, sigLen);
    
    printf("%lu, back to library:\n", sig.size());
}
