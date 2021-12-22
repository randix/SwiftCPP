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
    signCb swiftSignCallback;
    //id signObj;
}
-(void)setCallback:(signCb)swiftSignCallback;
-(void)signCallback;
-(void)sign:(LensSignParameter *)data;

//-(void)signCallb:(LensSignParameter *)data;

@end

//void setSignCallbackC(id cb);
//
//void signC(id cb, unsigned char * dataPtr, unsigned long dataLen, unsigned char *sigPtr, unsigned long sigLen);
//void signCCallback(const unsigned char * dataPtr, unsigned long dataLen, unsigned char *sigPtr, unsigned long sigLen);
// 

NS_ASSUME_NONNULL_END

#endif /* SignCallback_h */
