#include "unit_test.hpp"

#include <iostream>

struct AnotherUnitTest : UnitTest {
  bool Run() override {
    std::cout << "AnotherUnitTest passed" << std::endl;
    return true;
  }
} AnotherUnitTest;

