#include "unit_test.hpp"

#include <iostream>

struct MyUnitTest : UnitTest {
  bool Run() override {
    std::cout << "MyUnitTest passed" << std::endl;
    return true;
  }
} MyUnitTest;

