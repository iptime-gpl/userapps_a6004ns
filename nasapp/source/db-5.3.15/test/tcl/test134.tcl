# See the file LICENSE for redistribution information.
#
# Copyright (c) 2011 Oracle and/or its affiliates.  All rights reserved.
#
# $Id: test134.tcl,v 1.1.1.1 2012/04/24 02:56:55 thki81 Exp $
#
# TEST	test134
# TEST  Test cursor cleanup for sub databases.

proc test134 {method {nentries 1000} args} {
	source ./include.tcl

	eval {test133 $method $nentries "134" 1} $args

}
