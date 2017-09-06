# See the file LICENSE for redistribution information.
#
# Copyright (c) 2011 Oracle and/or its affiliates.  All rights reserved.
#
# $Id: test136.tcl,v 1.1.1.1 2012/04/24 02:56:53 thki81 Exp $
#
# TEST	test136
# TEST  Test operations on similar overflow records. [#20329]
# TEST  Here, we use subdatabases.

proc test136 {method {keycnt 10} {datacnt 10} args} {
	source ./include.tcl

	eval {test135 $method $keycnt $datacnt 1 "136"} $args
}

