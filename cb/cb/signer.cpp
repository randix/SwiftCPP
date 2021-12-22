

#include "signer.hpp"


// this is like signing
void Signer::sign(int x, void (*fn)(const std::vector<uint8_t> &, std::vector<uint8_t> &))
{
   std::cout << "test_callback " << std:: endl;

    std::vector<uint8_t> input{ 1, 2, 3, 4};
    std::vector<uint8_t> output(1024);

    (*fn)(input, output);

    std::cout << 'a' + 0 << std::endl;
    std::cout << 'a' + output[1] << std::endl;
}


