# See the file LICENSE for redistribution information.
#
# Copyright (c) 1996, 2011 Oracle and/or its affiliates.  All rights reserved.
#
# $Id: test007.tcl,v 1.1.1.1 2012/04/24 02:56:55 thki81 Exp $
#
# TEST	test007
# TEST	Small keys/medium data
# TEST		Put/get per key
# TEST		Close, reopen
# TEST		Keyed delete
# TEST
# TEST	Check that delete operations work.  Create a database; close
# TEST	database and reopen it.  Then issues delete by key for each
# TEST	entry.  (Test006 plus reopen)
proc test007 { method {nentries 10000} {tnum "007"} {ndups 5} args} {
	eval {test006 $method $nentries 1 $tnum $ndups} $args
}
