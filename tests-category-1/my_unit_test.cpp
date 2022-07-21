#include "unit_test.hpp"

#include <iostream>

namespace {
  struct MyUnitTest : UnitTest {
    bool Run() override {
      std::cout << "MyUnitTest passed" << std::endl;
      return true;
    }
  } _;
}
