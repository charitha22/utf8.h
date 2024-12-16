#include "utf8.h"


int
main(int argc, char **argv)
{

        char haystack[20];
        klee_make_symbolic(haystack, 20, "arr");
        klee_assume(haystack[19] == '\0');

        char needle[5];
        klee_make_symbolic(needle, 5, "arr1");
        klee_assume(needle[4] =='\0');

        // int r = utf8ncmp(arr, arr1, 9);
        void * r = utf8str(haystack, needle);

        if ( r == NULL ) {
                printf(" not found!\n");
        }
        else {
                printf("found\n");
        }

        return 0;
}
