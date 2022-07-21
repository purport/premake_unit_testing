#include "unit_test.hpp"

#include "lib.hpp"

#include <iostream>

struct My2UnitTest : UnitTest {
  bool Run() override {
    if (2 == add_one(1)){
      std::cout << "My2UnitTest passed" << std::endl;
      return true;
    }
    return false;
  }
} My2UnitTest;

