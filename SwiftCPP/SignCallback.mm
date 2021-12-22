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

// resolve the linker object for the parameter "class"
@implementation LensSignParameter
@end


id signObj;
// ObjC Object
@implementation SignCallback

-(void)setCallback:(signCb)swiftSignCallback
{
    printf("SignCallBack.setCallback\n");
    self->swiftSignCallback = swiftSignCallback;
    signObj = self;
}

-(void)signCallback
{
    printf("SignCallback.signCallback\n");
    self->swiftSignCallback();
}

// Swift -> ObjC(here) -> C++ class method
-(void)sign:(LensSignParameter *)data
{
    printf("SignCallback.sign\n");
    
    Signer signer;
    signer.sign(3, SignCallbackCpp::signCallback);
}

void signCallbackTrampoline(id self)
{
    printf("SignCallback.signCallbackTrampoline\n");
    [self  signCallback];
}
@end

//-(void)
//void CbObjcpp::sign(const std::vector<uint8_t> & data, std::vector<uint8_t> & sig, void (*fn)(std::vector<uint8_t> const &, std::vector<uint8_t> &))
//{
//    signPtr = fn;
//    signCb(data, sig);
//}

void SignCallbackCpp::signCallback(const std::vector<uint8_t>& data, std::vector<uint8_t>& sig)
{
    printf("SignCallbackCpp.signCallback\n");
    // convert to LensSignParameter
    signCallbackTrampoline(signObj);
}
