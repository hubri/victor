/* See LICENSE file for license details. */
#include <ctype.h>
#include <errno.h>
#include <fcntl.h>
#include <limits.h>
#include <pwd.h>
#include <signal.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>
#include <errno.h>

extern int errno;

static char *argv0;


#include "arg.h"

static void      usage(void);

static void
usage(void)
{
	fprintf(stderr, "usage: %s [-b <branch>] commit [commit2]\n",
            argv0);
	exit(1);
}

int
main(int argc, char *argv[])
{
	const char *commit = NULL, *branch = NULL;

    ARGBEGIN {
	case 'b':
		branch = EARGF(usage());
		break;
	default:
		usage();
		break;
	} ARGEND;
    /* eat all remaining arguments */
    /* if there are more than two commits, display usage */
    if (argc > 0 && argc < 2)
        commit = argv[0];
    else if(argc > 0 && argc < 3){
        commit = argv[0];
        const char * commit2 = argv[1];
    }
    else{
        errno = 7;
        fprintf(stderr, "victor: %s", strerror( errno ));
        exit(7);
    }

	if (!commit)
		usage();

	return 0;
}
