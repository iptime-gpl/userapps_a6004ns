# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 2.8

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list

# Suppress display of executed commands.
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
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The program to use to edit the cache.
CMAKE_EDIT_COMMAND = /usr/bin/ccmake

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/bcmac/userapps/nasapp/source/mysql-5.5.28

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/bcmac/userapps/nasapp/source/mysql-5.5.28

# Include any dependencies generated for this target.
include extra/CMakeFiles/innochecksum.dir/depend.make

# Include the progress variables for this target.
include extra/CMakeFiles/innochecksum.dir/progress.make

# Include the compile flags for this target's objects.
include extra/CMakeFiles/innochecksum.dir/flags.make

extra/CMakeFiles/innochecksum.dir/innochecksum.c.o: extra/CMakeFiles/innochecksum.dir/flags.make
extra/CMakeFiles/innochecksum.dir/innochecksum.c.o: extra/innochecksum.c
	$(CMAKE_COMMAND) -E cmake_progress_report /home/bcmac/userapps/nasapp/source/mysql-5.5.28/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building C object extra/CMakeFiles/innochecksum.dir/innochecksum.c.o"
	cd /home/bcmac/userapps/nasapp/source/mysql-5.5.28/extra && /projects/hnd/tools/linux/hndtools-arm-linux-2.6.36-uclibc-4.5.3/bin/arm-brcm-linux-uclibcgnueabi-gcc  $(C_DEFINES) $(C_FLAGS) -o CMakeFiles/innochecksum.dir/innochecksum.c.o   -c /home/bcmac/userapps/nasapp/source/mysql-5.5.28/extra/innochecksum.c

extra/CMakeFiles/innochecksum.dir/innochecksum.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/innochecksum.dir/innochecksum.c.i"
	cd /home/bcmac/userapps/nasapp/source/mysql-5.5.28/extra && /projects/hnd/tools/linux/hndtools-arm-linux-2.6.36-uclibc-4.5.3/bin/arm-brcm-linux-uclibcgnueabi-gcc  $(C_DEFINES) $(C_FLAGS) -E /home/bcmac/userapps/nasapp/source/mysql-5.5.28/extra/innochecksum.c > CMakeFiles/innochecksum.dir/innochecksum.c.i

extra/CMakeFiles/innochecksum.dir/innochecksum.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/innochecksum.dir/innochecksum.c.s"
	cd /home/bcmac/userapps/nasapp/source/mysql-5.5.28/extra && /projects/hnd/tools/linux/hndtools-arm-linux-2.6.36-uclibc-4.5.3/bin/arm-brcm-linux-uclibcgnueabi-gcc  $(C_DEFINES) $(C_FLAGS) -S /home/bcmac/userapps/nasapp/source/mysql-5.5.28/extra/innochecksum.c -o CMakeFiles/innochecksum.dir/innochecksum.c.s

extra/CMakeFiles/innochecksum.dir/innochecksum.c.o.requires:
.PHONY : extra/CMakeFiles/innochecksum.dir/innochecksum.c.o.requires

extra/CMakeFiles/innochecksum.dir/innochecksum.c.o.provides: extra/CMakeFiles/innochecksum.dir/innochecksum.c.o.requires
	$(MAKE) -f extra/CMakeFiles/innochecksum.dir/build.make extra/CMakeFiles/innochecksum.dir/innochecksum.c.o.provides.build
.PHONY : extra/CMakeFiles/innochecksum.dir/innochecksum.c.o.provides

extra/CMakeFiles/innochecksum.dir/innochecksum.c.o.provides.build: extra/CMakeFiles/innochecksum.dir/innochecksum.c.o

# Object files for target innochecksum
innochecksum_OBJECTS = \
"CMakeFiles/innochecksum.dir/innochecksum.c.o"

# External object files for target innochecksum
innochecksum_EXTERNAL_OBJECTS =

extra/innochecksum: extra/CMakeFiles/innochecksum.dir/innochecksum.c.o
extra/innochecksum: extra/CMakeFiles/innochecksum.dir/build.make
extra/innochecksum: extra/CMakeFiles/innochecksum.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking C executable innochecksum"
	cd /home/bcmac/userapps/nasapp/source/mysql-5.5.28/extra && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/innochecksum.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
extra/CMakeFiles/innochecksum.dir/build: extra/innochecksum
.PHONY : extra/CMakeFiles/innochecksum.dir/build

extra/CMakeFiles/innochecksum.dir/requires: extra/CMakeFiles/innochecksum.dir/innochecksum.c.o.requires
.PHONY : extra/CMakeFiles/innochecksum.dir/requires

extra/CMakeFiles/innochecksum.dir/clean:
	cd /home/bcmac/userapps/nasapp/source/mysql-5.5.28/extra && $(CMAKE_COMMAND) -P CMakeFiles/innochecksum.dir/cmake_clean.cmake
.PHONY : extra/CMakeFiles/innochecksum.dir/clean

extra/CMakeFiles/innochecksum.dir/depend:
	cd /home/bcmac/userapps/nasapp/source/mysql-5.5.28 && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/bcmac/userapps/nasapp/source/mysql-5.5.28 /home/bcmac/userapps/nasapp/source/mysql-5.5.28/extra /home/bcmac/userapps/nasapp/source/mysql-5.5.28 /home/bcmac/userapps/nasapp/source/mysql-5.5.28/extra /home/bcmac/userapps/nasapp/source/mysql-5.5.28/extra/CMakeFiles/innochecksum.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : extra/CMakeFiles/innochecksum.dir/depend

