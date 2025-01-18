# - Config file for the gz-waves1-rendering component
#
# This should only be invoked by gz-waves1-config.cmake.
#
# To load this component into your project, use:
# find_package(gz-waves1 COMPONENTS rendering)
#
# This creates the following targets:
#
#   Component library target                - gz-waves1::gz-waves1-rendering
#   Alternative target name                 - gz-waves1::rendering
#   Core library + all requested components - gz-waves1::requested
#
# Use target_link_libraries() to link your library or executable to one of the
# above targets.
#
# We also provide the following variable for backwards compatibility, but use of
# this is discouraged:
#
#   gz-waves1-rendering_LIBRARY  - Component library (actually contains gz-waves1::rendering)
#
# We will also set gz-waves1-rendering_FOUND to indicate that the component was found.
#
################################################################################

# We explicitly set the desired cmake version to ensure that the policy settings
# of users or of toolchains do not result in the wrong behavior for our modules.
# Note that the call to find_package(~) will PUSH a new policy stack before
# taking on these version settings, and then that stack will POP after the
# find_package(~) has exited, so this will not affect the cmake policy settings
# of a caller.
cmake_minimum_required(VERSION 3.10.2 FATAL_ERROR)

if(gz-waves1-rendering_CONFIG_INCLUDED)
  return()
endif()
set(gz-waves1-rendering_CONFIG_INCLUDED TRUE)

if(NOT gz-waves1-rendering_FIND_QUIETLY)
  message(STATUS "Looking for gz-waves1-rendering -- found version 1.0.0")
endif()


####### Expanded from @PACKAGE_INIT@ by configure_package_config_file() #######
####### Any changes to this file will be overwritten by the next CMake run ####
####### The input file was gz-component-config.cmake.in                            ########

get_filename_component(PACKAGE_PREFIX_DIR "${CMAKE_CURRENT_LIST_DIR}/../../../" ABSOLUTE)

macro(set_and_check _var _file)
  set(${_var} "${_file}")
  if(NOT EXISTS "${_file}")
    message(FATAL_ERROR "File or directory ${_file} referenced by variable ${_var} does not exist !")
  endif()
endmacro()

macro(check_required_components _NAME)
  foreach(comp ${${_NAME}_FIND_COMPONENTS})
    if(NOT ${_NAME}_${comp}_FOUND)
      if(${_NAME}_FIND_REQUIRED_${comp})
        set(${_NAME}_FOUND FALSE)
      endif()
    endif()
  endforeach()
endmacro()

####################################################################################

# Get access to the find_dependency utility
include(CMakeFindDependencyMacro)

# Find gz-cmake, because we need its modules in order to find the rest of
# our dependencies.
find_dependency(gz-cmake3)

# Set the REQUIRED flag for the find_package(~) calls on this component's
# dependencies.
if(gz-waves1-rendering_FIND_REQUIRED)
  set(gz_package_required REQUIRED)
else()
  set(gz_package_required "")
endif()

# Set the QUIET flag for the find_package(~) calls on this component's
# dependencies.
if(gz-waves1-rendering_FIND_QUIETLY)
  set(gz_package_quiet QUIET)
else()
  set(gz_package_quiet "")
endif()

# --------------------------------
# Find the dependencies that are specific to this component (if nothing is
# below, then the component has no additional dependencies). We use
# find_package(~) instead of find_dependency(~) here so that we can support
# COMPONENT arguments.
#
# TODO: When we migrate to cmake-3.9+, change these to find_dependency(~),
#       because at that point the find_dependency(~) function will support
#       the COMPONENT argument.
if(NOT gz-waves1-rendering_FIND_QUIETLY)
  message(STATUS "Searching for dependencies of gz-waves1-rendering")
endif()
if(NOT gz-waves1_CONFIG_INCLUDED)
  find_package(gz-waves1 1.0.0 EXACT ${gz_package_quiet} ${gz_package_required})
endif()
# --------------------------------

if(NOT TARGET gz-waves1::gz-waves1-rendering)
  include("${CMAKE_CURRENT_LIST_DIR}/gz-waves1-rendering-targets.cmake")

  # Create a simplified imported target name for the rendering library.
  # You can link to this target instead of the rendering library.
  add_library(gz-waves1::rendering INTERFACE IMPORTED)
  set_target_properties(gz-waves1::rendering PROPERTIES
    INTERFACE_LINK_LIBRARIES "gz-waves1::gz-waves1-rendering")
  # Note: In a future version of cmake, we can replace this with an ALIAS target

endif()

# Create the "requested" target if it does not already exist
if(NOT TARGET gz-waves1::requested)
  add_library(gz-waves1::requested INTERFACE IMPORTED)
endif()

# Link the rendering library to the "requested" target
get_target_property(gz_requested_components gz-waves1::requested INTERFACE_LINK_LIBRARIES)
if(NOT gz_requested_components)
  set_target_properties(gz-waves1::requested PROPERTIES
    INTERFACE_LINK_LIBRARIES "gz-waves1::gz-waves1-rendering")
else()
  set_target_properties(gz-waves1::requested PROPERTIES
    INTERFACE_LINK_LIBRARIES "${gz_requested_components};gz-waves1::gz-waves1-rendering")
endif()

set(gz-waves1-rendering_LIBRARY gz-waves1::gz-waves1-rendering)

# This macro is used by gz-cmake to automatically configure the pkgconfig
# files for Gazebo projects.
gz_pkg_config_entry(gz-waves1-rendering "gz-waves1-rendering")
