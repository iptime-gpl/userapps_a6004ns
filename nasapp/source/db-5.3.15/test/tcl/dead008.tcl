# See the file LICENSE for redistribution information.
#
# Copyright (c) 1996, 2011 Oracle and/or its affiliates.  All rights reserved.
#
# $Id: dead008.tcl,v 1.1.1.1 2012/04/24 02:56:53 thki81 Exp $
#
# TEST	dead008
# TEST	Run dead001 deadlock test using priorities
proc dead008 { {tnum "008"} } {
	source ./include.tcl
	dead001 "2 4 10" "ring clump" "0" $tnum 1

}
