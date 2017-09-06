# $Id: commit.awk,v 1.1.1.1 2012/04/24 01:43:04 thki81 Exp $
#
# Output tid of committed transactions.

/txn_regop/ {
	print $5
}
