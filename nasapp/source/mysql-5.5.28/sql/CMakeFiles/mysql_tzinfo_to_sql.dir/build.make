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
include sql/CMakeFiles/mysql_tzinfo_to_sql.dir/depend.make

# Include the progress variables for this target.
include sql/CMakeFiles/mysql_tzinfo_to_sql.dir/progress.make

# Include the compile flags for this target's objects.
include sql/CMakeFiles/mysql_tzinfo_to_sql.dir/flags.make

sql/CMakeFiles/mysql_tzinfo_to_sql.dir/tztime.cc.o: sql/CMakeFiles/mysql_tzinfo_to_sql.dir/flags.make
sql/CMakeFiles/mysql_tzinfo_to_sql.dir/tztime.cc.o: sql/tztime.cc
	$(CMAKE_COMMAND) -E cmake_progress_report /home/bcmac/userapps/nasapp/source/mysql-5.5.28/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object sql/CMakeFiles/mysql_tzinfo_to_sql.dir/tztime.cc.o"
	cd /home/bcmac/userapps/nasapp/source/mysql-5.5.28/sql && /projects/hnd/tools/linux/hndtools-arm-linux-2.6.36-uclibc-4.5.3/bin/arm-brcm-linux-uclibcgnueabi-g++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/mysql_tzinfo_to_sql.dir/tztime.cc.o -c /home/bcmac/userapps/nasapp/source/mysql-5.5.28/sql/tztime.cc

sql/CMakeFiles/mysql_tzinfo_to_sql.dir/tztime.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/mysql_tzinfo_to_sql.dir/tztime.cc.i"
	cd /home/bcmac/userapps/nasapp/source/mysql-5.5.28/sql && /projects/hnd/tools/linux/hndtools-arm-linux-2.6.36-uclibc-4.5.3/bin/arm-brcm-linux-uclibcgnueabi-g++  $(CXX_DEFINES) $(CXX_FLAGS) -E /home/bcmac/userapps/nasapp/source/mysql-5.5.28/sql/tztime.cc > CMakeFiles/mysql_tzinfo_to_sql.dir/tztime.cc.i

sql/CMakeFiles/mysql_tzinfo_to_sql.dir/tztime.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/mysql_tzinfo_to_sql.dir/tztime.cc.s"
	cd /home/bcmac/userapps/nasapp/source/mysql-5.5.28/sql && /projects/hnd/tools/linux/hndtools-arm-linux-2.6.36-uclibc-4.5.3/bin/arm-brcm-linux-uclibcgnueabi-g++  $(CXX_DEFINES) $(CXX_FLAGS) -S /home/bcmac/userapps/nasapp/source/mysql-5.5.28/sql/tztime.cc -o CMakeFiles/mysql_tzinfo_to_sql.dir/tztime.cc.s

sql/CMakeFiles/mysql_tzinfo_to_sql.dir/tztime.cc.o.requires:
.PHONY : sql/CMakeFiles/mysql_tzinfo_to_sql.dir/tztime.cc.o.requires

sql/CMakeFiles/mysql_tzinfo_to_sql.dir/tztime.cc.o.provides: sql/CMakeFiles/mysql_tzinfo_to_sql.dir/tztime.cc.o.requires
	$(MAKE) -f sql/CMakeFiles/mysql_tzinfo_to_sql.dir/build.make sql/CMakeFiles/mysql_tzinfo_to_sql.dir/tztime.cc.o.provides.build
.PHONY : sql/CMakeFiles/mysql_tzinfo_to_sql.dir/tztime.cc.o.provides

sql/CMakeFiles/mysql_tzinfo_to_sql.dir/tztime.cc.o.provides.build: sql/CMakeFiles/mysql_tzinfo_to_sql.dir/tztime.cc.o

# Object files for target mysql_tzinfo_to_sql
mysql_tzinfo_to_sql_OBJECTS = \
"CMakeFiles/mysql_tzinfo_to_sql.dir/tztime.cc.o"

# External object files for target mysql_tzinfo_to_sql
mysql_tzinfo_to_sql_EXTERNAL_OBJECTS =

sql/mysql_tzinfo_to_sql: sql/CMakeFiles/mysql_tzinfo_to_sql.dir/tztime.cc.o
sql/mysql_tzinfo_to_sql: sql/CMakeFiles/mysql_tzinfo_to_sql.dir/build.make
sql/mysql_tzinfo_to_sql: mysys/libmysys.a
sql/mysql_tzinfo_to_sql: dbug/libdbug.a
sql/mysql_tzinfo_to_sql: mysys/libmysys.a
sql/mysql_tzinfo_to_sql: dbug/libdbug.a
sql/mysql_tzinfo_to_sql: strings/libstrings.a
sql/mysql_tzinfo_to_sql: probes_mysql.o
sql/mysql_tzinfo_to_sql: sql/CMakeFiles/mysql_tzinfo_to_sql.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking CXX executable mysql_tzinfo_to_sql"
	cd /home/bcmac/userapps/nasapp/source/mysql-5.5.28/sql && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/mysql_tzinfo_to_sql.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
sql/CMakeFiles/mysql_tzinfo_to_sql.dir/build: sql/mysql_tzinfo_to_sql
.PHONY : sql/CMakeFiles/mysql_tzinfo_to_sql.dir/build

sql/CMakeFiles/mysql_tzinfo_to_sql.dir/requires: sql/CMakeFiles/mysql_tzinfo_to_sql.dir/tztime.cc.o.requires
.PHONY : sql/CMakeFiles/mysql_tzinfo_to_sql.dir/requires

sql/CMakeFiles/mysql_tzinfo_to_sql.dir/clean:
	cd /home/bcmac/userapps/nasapp/source/mysql-5.5.28/sql && $(CMAKE_COMMAND) -P CMakeFiles/mysql_tzinfo_to_sql.dir/cmake_clean.cmake
.PHONY : sql/CMakeFiles/mysql_tzinfo_to_sql.dir/clean

sql/CMakeFiles/mysql_tzinfo_to_sql.dir/depend:
	cd /home/bcmac/userapps/nasapp/source/mysql-5.5.28 && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/bcmac/userapps/nasapp/source/mysql-5.5.28 /home/bcmac/userapps/nasapp/source/mysql-5.5.28/sql /home/bcmac/userapps/nasapp/source/mysql-5.5.28 /home/bcmac/userapps/nasapp/source/mysql-5.5.28/sql /home/bcmac/userapps/nasapp/source/mysql-5.5.28/sql/CMakeFiles/mysql_tzinfo_to_sql.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : sql/CMakeFiles/mysql_tzinfo_to_sql.dir/depend

