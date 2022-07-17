#pragma once
#include <vector>

struct UnitTest {
  UnitTest();
  virtual ~UnitTest() {}

  virtual bool Run() = 0;
};

