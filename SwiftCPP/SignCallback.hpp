//
//  SignCallback.hpp
//  SwiftCPP
//
//  Created by Rand Dow on 12/21/21.
//

#ifndef SignCallback_hpp
#define SignCallback_hpp

#include <iostream>

class SignCallbackCpp {
public:
    static void signCallback(const std::vector<uint8_t>& data, std::vector<uint8_t>& sig);
};

#endif /* SignCallback_hpp */
