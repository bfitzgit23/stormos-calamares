# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.21

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/ben/stormos-calamares/src/calamares-3.2.44.3

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/ben/stormos-calamares/src/calamares-3.2.44.3/build

# Utility rule file for initcpiotest_autogen.

# Include any custom commands dependencies for this target.
include src/modules/initcpio/CMakeFiles/initcpiotest_autogen.dir/compiler_depend.make

# Include the progress variables for this target.
include src/modules/initcpio/CMakeFiles/initcpiotest_autogen.dir/progress.make

src/modules/initcpio/CMakeFiles/initcpiotest_autogen:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/ben/stormos-calamares/src/calamares-3.2.44.3/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Automatic MOC for target initcpiotest"
	cd /home/ben/stormos-calamares/src/calamares-3.2.44.3/build/src/modules/initcpio && /usr/bin/cmake -E cmake_autogen /home/ben/stormos-calamares/src/calamares-3.2.44.3/build/src/modules/initcpio/CMakeFiles/initcpiotest_autogen.dir/AutogenInfo.json Release

initcpiotest_autogen: src/modules/initcpio/CMakeFiles/initcpiotest_autogen
initcpiotest_autogen: src/modules/initcpio/CMakeFiles/initcpiotest_autogen.dir/build.make
.PHONY : initcpiotest_autogen

# Rule to build all files generated by this target.
src/modules/initcpio/CMakeFiles/initcpiotest_autogen.dir/build: initcpiotest_autogen
.PHONY : src/modules/initcpio/CMakeFiles/initcpiotest_autogen.dir/build

src/modules/initcpio/CMakeFiles/initcpiotest_autogen.dir/clean:
	cd /home/ben/stormos-calamares/src/calamares-3.2.44.3/build/src/modules/initcpio && $(CMAKE_COMMAND) -P CMakeFiles/initcpiotest_autogen.dir/cmake_clean.cmake
.PHONY : src/modules/initcpio/CMakeFiles/initcpiotest_autogen.dir/clean

src/modules/initcpio/CMakeFiles/initcpiotest_autogen.dir/depend:
	cd /home/ben/stormos-calamares/src/calamares-3.2.44.3/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/ben/stormos-calamares/src/calamares-3.2.44.3 /home/ben/stormos-calamares/src/calamares-3.2.44.3/src/modules/initcpio /home/ben/stormos-calamares/src/calamares-3.2.44.3/build /home/ben/stormos-calamares/src/calamares-3.2.44.3/build/src/modules/initcpio /home/ben/stormos-calamares/src/calamares-3.2.44.3/build/src/modules/initcpio/CMakeFiles/initcpiotest_autogen.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : src/modules/initcpio/CMakeFiles/initcpiotest_autogen.dir/depend

