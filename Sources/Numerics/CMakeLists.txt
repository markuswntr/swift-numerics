#[[
This source file is part of the Swift Numerics open source project

Copyright (c) 2019 Apple Inc. and the Swift Numerics project authors
Licensed under Apache License v2.0 with Runtime Library Exception

See https://swift.org/LICENSE.txt for license information
#]]

add_library(Numerics
  Numerics.swift)
set_target_properties(Numerics PROPERTIES
  INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_Swift_MODULE_DIRECTORY})
target_link_libraries(Numerics PUBLIC
  ComplexModule
  RealModule)


_install_target(Numerics)
set_property(GLOBAL APPEND PROPERTY SWIFT_NUMERICS_EXPORTS Numerics)