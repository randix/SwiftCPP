
// simulate what Swift needs to do

#include <iostream>
#include "callback.hpp"


void Callback::callback(const std::vector<uint8_t>& jpeg, std::vector<uint8_t>& output) {

   for (int i = 0; i < 4; i++) {
      output[i] = jpeg[i];
   }
}
