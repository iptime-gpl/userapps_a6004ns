/* Shared library add-on to iptables to add MARK target support. */
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <getopt.h>

//#include <iptables.h>
//#include <linux/netfilter_ipv4/ip_tables.h>
//#include <linux/netfilter_ipv4/ipt_MARK.h>

#include <xtables.h>
#include <linux/netfilter/xt_MARK.h>

struct xt_mark_target_info {
	unsigned long mark;
};

enum {
        O_SET_MARK = 0,
        O_AND_MARK,
        O_OR_MARK,
        O_XOR_MARK,
        O_SET_XMARK,
        F_SET_MARK  = 1 << O_SET_MARK,
        F_AND_MARK  = 1 << O_AND_MARK,
        F_OR_MARK   = 1 << O_OR_MARK,
        F_XOR_MARK  = 1 << O_XOR_MARK,
        F_SET_XMARK = 1 << O_SET_XMARK,
        F_ANY       = F_SET_MARK | F_AND_MARK | F_OR_MARK |
                      F_XOR_MARK | F_SET_XMARK,
};


/* Function which prints out usage message. */
static void help(void)
{
	printf(
"RTMARK target options:\n"
"  --set-mark value                   Set nfmark value\n"
"\n");
}

static const struct xt_option_entry opts[] = {
	{.name = "set-mark", .id = O_SET_MARK, .type = XTTYPE_UINT32,
	 .excl = F_ANY},
	XTOPT_TABLEEND,
};

/* Initialize the target. */

/* Function which parses command options; returns true if it
   ate an option */
static void parse(struct xt_option_call *cb)
{
	struct xt_mark_target_info *markinfo = cb->data;

	xtables_option_parse(cb);
	switch (cb->entry->id) {
	case O_SET_MARK:
		markinfo->mark = cb->val.mark;
		break;
	default:
		xtables_error(PARAMETER_PROBLEM, "RTMARK target: kernel too old for --%s", cb->entry->name);
	}

}

static void final_check(struct xt_fcheck_call *cb)
{
	if (cb->xflags == 0)
		xtables_error(PARAMETER_PROBLEM, "RTMARK target: Parameter --set-mark" " is required");

}

static void print_mark(unsigned long mark)
{
	printf("0x%lx ", mark);
}

/* Prints out the targinfo. */
static void print(const void *ip,
      const struct xt_entry_target *target, int numeric)
{
	const struct xt_mark_target_info *markinfo =
		(const struct xt_mark_target_info *)target->data;
	printf(" RTMARK set ");
	print_mark(markinfo->mark);
}

/* Saves the union ipt_targinfo in parsable form to stdout. */
static void save(const void *ip, const struct xt_entry_target *target)
{
	const struct xt_mark_target_info *markinfo =
		(const struct xt_mark_target_info *)target->data;

	printf("--set-mark");
	print_mark(markinfo->mark);
}

static struct xtables_target mark_reg[] = { 
	{
	.family        	= NFPROTO_UNSPEC,
	.name   	= "RTMARK",
	.version  	= XTABLES_VERSION,
	.size   	= XT_ALIGN(sizeof(struct xt_mark_target_info)),
	.userspacesize 	= XT_ALIGN(sizeof(struct xt_mark_target_info)),
	.help   	= help,
	.print  	= print,
	.save   	= save,
	.x6_parse  	= parse,
	.x6_fcheck	= final_check,
	.x6_options  	= opts,
	},
};

void _init(void)
{
	xtables_register_targets(mark_reg, ARRAY_SIZE(mark_reg));
}
