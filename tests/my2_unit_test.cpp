#include "unit_test.hpp"

#include <iostream>

struct My2UnitTest : UnitTest {
  bool Run() override {
    std::cout << "My2UnitTest failed" << std::endl;
    return false;
  }
} My2UnitTest;

