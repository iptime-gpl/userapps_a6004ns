# Install script for directory: /home/bcmac/userapps/nasapp/source/mysql-5.5.28/include

# Set the install prefix
IF(NOT DEFINED CMAKE_INSTALL_PREFIX)
  SET(CMAKE_INSTALL_PREFIX "/usr/hddapp2/mysql")
ENDIF(NOT DEFINED CMAKE_INSTALL_PREFIX)
STRING(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
IF(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  IF(BUILD_TYPE)
    STRING(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  ELSE(BUILD_TYPE)
    SET(CMAKE_INSTALL_CONFIG_NAME "RelWithDebInfo")
  ENDIF(BUILD_TYPE)
  MESSAGE(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
ENDIF(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)

# Set the component getting installed.
IF(NOT CMAKE_INSTALL_COMPONENT)
  IF(COMPONENT)
    MESSAGE(STATUS "Install component: \"${COMPONENT}\"")
    SET(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  ELSE(COMPONENT)
    SET(CMAKE_INSTALL_COMPONENT)
  ENDIF(COMPONENT)
ENDIF(NOT CMAKE_INSTALL_COMPONENT)

# Install shared libraries without execute permission?
IF(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  SET(CMAKE_INSTALL_SO_NO_EXE "0")
ENDIF(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Development")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE FILE FILES
    "/home/bcmac/userapps/nasapp/source/mysql-5.5.28/include/mysql.h"
    "/home/bcmac/userapps/nasapp/source/mysql-5.5.28/include/mysql_com.h"
    "/home/bcmac/userapps/nasapp/source/mysql-5.5.28/include/mysql_time.h"
    "/home/bcmac/userapps/nasapp/source/mysql-5.5.28/include/my_list.h"
    "/home/bcmac/userapps/nasapp/source/mysql-5.5.28/include/my_alloc.h"
    "/home/bcmac/userapps/nasapp/source/mysql-5.5.28/include/typelib.h"
    "/home/bcmac/userapps/nasapp/source/mysql-5.5.28/include/mysql/plugin.h"
    "/home/bcmac/userapps/nasapp/source/mysql-5.5.28/include/mysql/plugin_audit.h"
    "/home/bcmac/userapps/nasapp/source/mysql-5.5.28/include/mysql/plugin_ftparser.h"
    "/home/bcmac/userapps/nasapp/source/mysql-5.5.28/include/my_dbug.h"
    "/home/bcmac/userapps/nasapp/source/mysql-5.5.28/include/m_string.h"
    "/home/bcmac/userapps/nasapp/source/mysql-5.5.28/include/my_sys.h"
    "/home/bcmac/userapps/nasapp/source/mysql-5.5.28/include/my_xml.h"
    "/home/bcmac/userapps/nasapp/source/mysql-5.5.28/include/mysql_embed.h"
    "/home/bcmac/userapps/nasapp/source/mysql-5.5.28/include/my_pthread.h"
    "/home/bcmac/userapps/nasapp/source/mysql-5.5.28/include/decimal.h"
    "/home/bcmac/userapps/nasapp/source/mysql-5.5.28/include/errmsg.h"
    "/home/bcmac/userapps/nasapp/source/mysql-5.5.28/include/my_global.h"
    "/home/bcmac/userapps/nasapp/source/mysql-5.5.28/include/my_net.h"
    "/home/bcmac/userapps/nasapp/source/mysql-5.5.28/include/my_getopt.h"
    "/home/bcmac/userapps/nasapp/source/mysql-5.5.28/include/sslopt-longopts.h"
    "/home/bcmac/userapps/nasapp/source/mysql-5.5.28/include/my_dir.h"
    "/home/bcmac/userapps/nasapp/source/mysql-5.5.28/include/sslopt-vars.h"
    "/home/bcmac/userapps/nasapp/source/mysql-5.5.28/include/sslopt-case.h"
    "/home/bcmac/userapps/nasapp/source/mysql-5.5.28/include/sql_common.h"
    "/home/bcmac/userapps/nasapp/source/mysql-5.5.28/include/keycache.h"
    "/home/bcmac/userapps/nasapp/source/mysql-5.5.28/include/m_ctype.h"
    "/home/bcmac/userapps/nasapp/source/mysql-5.5.28/include/my_attribute.h"
    "/home/bcmac/userapps/nasapp/source/mysql-5.5.28/include/my_compiler.h"
    "/home/bcmac/userapps/nasapp/source/mysql-5.5.28/include/mysql_version.h"
    "/home/bcmac/userapps/nasapp/source/mysql-5.5.28/include/my_config.h"
    "/home/bcmac/userapps/nasapp/source/mysql-5.5.28/include/mysqld_ername.h"
    "/home/bcmac/userapps/nasapp/source/mysql-5.5.28/include/mysqld_error.h"
    "/home/bcmac/userapps/nasapp/source/mysql-5.5.28/include/sql_state.h"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Development")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Development")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/mysql" TYPE DIRECTORY FILES "/home/bcmac/userapps/nasapp/source/mysql-5.5.28/include/mysql/" FILES_MATCHING REGEX "/[^/]*\\.h$")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Development")

