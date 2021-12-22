
// simulate what Swift needs to do

#include <iostream>
#include <string>
#include <vector>


class Signer {
public:
    void sign(int x, void (*fn)(const std::vector<uint8_t> &, std::vector<uint8_t> &));
};
