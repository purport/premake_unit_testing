
local msc = premake.tools.msc
local oldgetlinks_msc = msc.getlinks
function msc.getlinks (cfg, systemonly, nogroups)
  local flags = oldgetlinks_msc(cfg, systemonly, nogroups)

  local cpy = {}
  for _, flag in ipairs(flags) do
    local endswith = function(s, ptrn)
      return ptrn == string.sub(s, -string.len(ptrn))
    end
    if endswith(flag, ":whole.lib") then
      flag = string.sub(flag, 0, -11)
      table.insert(cpy, "-WHOLEARCHIVE:" ..flag..".lib")
    else
      table.insert(cpy, flag)
    end
  end

  return cpy
end


local gcc = premake.tools.gcc
local oldgetlinks_gcc = gcc.getlinks
function gcc.getlinks (cfg, systemonly, nogroups)
  local flags = oldgetlinks_gcc(cfg, systemonly, nogroups)

  local cpy = {}
  for _, flag in ipairs(flags) do
    local endswith = function(s, ptrn)
      return ptrn == string.sub(s, -string.len(ptrn))
    end
    if endswith(flag, ":whole") then
      flag = string.sub(flag, 0, -7)
      table.insert(cpy, "-Wl,--whole-archive " ..flag.. " -Wl,--no-whole-archive")
    else
      table.insert(cpy, flag)
    end
  end

  return cpy
end


workspace "AProjectWithUnitTests"
   configurations { "Debug", "Release" }

linkgroups 'on'

project "Lib"
   kind "StaticLib"
   language "C++"
   targetdir "bin/%{cfg.buildcfg}"

   files { "lib/lib.cpp" }

   filter "configurations:Debug"
      defines { "DEBUG" }
      symbols "On"

   filter "configurations:Release"
      defines { "NDEBUG" }
      optimize "On"

project "HelloWorldUnitTests1"
   kind "StaticLib"
   language "C++"
   targetdir "bin/%{cfg.buildcfg}"

   includedirs { "src" }
   includedirs { "lib" }
   files { "tests-category-1/*.cpp" }
   links { "Lib" }

   filter "configurations:Debug"
      defines { "DEBUG" }
      symbols "On"

   filter "configurations:Release"
      defines { "NDEBUG" }
      optimize "On"

project "HelloWorldUnitTests2"
   kind "StaticLib"
   language "C++"
   targetdir "bin/%{cfg.buildcfg}"

   includedirs { "src" }
   files { "tests-category-2/*.cpp" }
   links { "Lib" }

   filter "configurations:Debug"
      defines { "DEBUG" }
      symbols "On"

   filter "configurations:Release"
      defines { "NDEBUG" }
      optimize "On"

project "HelloWorld"
   kind "ConsoleApp"
   language "C++"
   targetdir "bin/%{cfg.buildcfg}"

   files { "src/hello-world.cpp" }
   includedirs { "lib" }
   libdirs { "bin/%{cfg.buildcfg}" }
   links { "HelloWorldUnitTests1", "HelloWorldUnitTests2" }
   links { "Lib", "HelloWorldUnitTests1:whole", "HelloWorldUnitTests2:whole" }

   filter "configurations:Debug"
      defines { "DEBUG" }
      symbols "On"

   filter "configurations:Release"
      defines { "NDEBUG" }
      optimize "On"
