//
//  CbObjcpp.m
//  SwiftCPP
//
//  Created by Rand Dow on 12/20/21.
//

#import <Foundation/Foundation.h>

#include "SignCallback.h"
#include "SignCallback.hpp"

// this is the include from the library (C2PA)
#include "signer.hpp"

//// resolve the linker object for the parameter class
//@implementation LensSignParameter
//@end


// save the SignCallback Object "self" for the trampoline
id signObj;


// ObjC Object
@implementation SignCallback

-(void)setCallback:(SignCb)swiftSignCallback
{
    printf("SignCallBack.setCallback\n");
    self->swiftSignCallback = swiftSignCallback;
    signObj = self;
}

-(SigResult)signCallback:(NSData *)data;
{
    printf("SignCallback.signCallback\n");
    self->signature = self->swiftSignCallback(data);        // call to Swift
    SigResult sig;
    sig.sigLen = self->signature.length;
    sig.sig = (uint8_t *)[self->signature bytes];
    return sig;
}

void signCallbackTrampoline(id self, const uint8_t * data, NSUInteger dataLen,
                                           uint8_t **sig, NSUInteger *sigLen)
{
    printf("SignCallback.signCallbackTrampoline\n");
    SigResult sigResult = [self  signCallback:[NSData dataWithBytes:data length:dataLen]];
    *sig = sigResult.sig;
    *sigLen = sigResult.sigLen;
    printf("trampoline back: sigLen %lu\n", *sigLen);
    for (int i=0; i < *sigLen; i++ ) {
        printf("%d\n", (*sig)[i]);
    }
}

// Swift -> ObjC(here) -> C++ class method
-(void)sign
{
    printf("SignCallback.sign -- call the C++ libarary\n");
    
    // claim signer: marshal and convert parameters to pass down
    Signer signer;
    signer.sign(3, SignCallbackCpp::signCallback);
}
@end

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
    signCallbackTrampoline(signObj, dataBytes, dataLen, &sigBytes, &sigLen);
    printf("return from trampoline: %lu\n", sigLen);
    for (int i=0; i < sigLen; i++) {
        printf("%d\n", sigBytes[i]);
    }
    // convert sig to vector
    sig.resize(sigLen);
    for (int i = 0; i < sigLen; i++) {
        sig[i] = sigBytes[i];
    }
    
    printf("%lu, back to library:\n", sig.size());
}
