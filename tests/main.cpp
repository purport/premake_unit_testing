#include <vector>
#include <iostream>

#include "unit_test.hpp"

static std::vector<UnitTest *> tests;

UnitTest::UnitTest() {
  tests.push_back(this);
}

int RunAllTests() {
  std::cout << "Running " << tests.size() << " tests..." << std::endl;
  for (auto it=tests.begin(); it != tests.end(); ++it) {
    if (!(*it)->Run()) return 1;
  }
  return 0;
}

int main() {
  return RunAllTests();
}
