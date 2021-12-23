//
//  SignCallback.hpp
//  SwiftCPP
//
//  Created by Rand Dow on 12/21/21.
//

#ifndef SignCallback_hpp
#define SignCallback_hpp

#include <iostream>

// this must match what the callback from the library (C2PA) expects
class SignCallbackCpp {
public:
    // Called from C++ to marshall the parameters to C for the trampoline
    static void signCallback(const std::vector<uint8_t>& data, std::vector<uint8_t>& sig);
};

#endif /* SignCallback_hpp */
