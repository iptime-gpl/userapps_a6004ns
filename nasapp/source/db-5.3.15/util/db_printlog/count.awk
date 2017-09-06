# $Id: count.awk,v 1.1.1.1 2012/04/24 01:43:04 thki81 Exp $
#
# Print out the number of log records for transactions that we
# encountered.

/^\[/{
	if ($5 != 0)
		print $5
}
