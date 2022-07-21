#include <vector>
#include <iostream>

#include "lib.hpp"
#include "unit_test.hpp"

std::vector<UnitTest *> UnitTests;

UnitTest::UnitTest() { UnitTests.push_back(this); }

int RunAllTests() {
  std::cout << "Running " << UnitTests.size() << " tests..." << std::endl;
  for (auto it=UnitTests.begin(); it != UnitTests.end(); ++it) {
    (*it)->Run();
  }
  return 0;
}

int main() {
  RunAllTests();

  std::cout << "The tests should have run before this." << std::endl;
  std::cout << "Hello World" << std::endl;
  std::cout << add_one(3) << std::endl;
}
