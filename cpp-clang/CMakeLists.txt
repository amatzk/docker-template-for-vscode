cmake_minimum_required(VERSION 3.20)
project(myproject VERSION 1.0.0)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)

set(CMAKE_BUILD_TYPE Debug)

file(GLOB SOURCES "src/*.cpp")
file(GLOB HEADERS "include/*.h")

include_directories(include)

add_executable(${PROJECT_NAME} ${SOURCES} ${HEADERS})
