# See the file LICENSE for redistribution information.
#
# Copyright (c) 2011 Oracle and/or its affiliates.  All rights reserved.
#
# $Id: fop009.tcl,v 1.1.1.1 2012/04/24 02:56:53 thki81 Exp $
#
# TEST	fop009
# TEST	Test file system operations in child transactions. 
# TEST	Combine two ops in one child transaction.
proc fop009 { method args } {

	# Run for btree only to cut down on redundant testing. 
	if { [is_btree $method] == 0 } {
		puts "Skipping fop009 for method $method"
		return
	}

	eval {fop001 $method 0 1} $args
}



