
// simulate what Swift needs to do

#include <string>
#include <iostream>
#include <vector>


class Callback {
public:
	static void callback(const std::vector<uint8_t> &, std::vector<uint8_t> &);
};
