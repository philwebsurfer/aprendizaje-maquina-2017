#include <stdio.h>
int main()
{
    int n, i;
    unsigned long long factorial = 1;


    n = 10;
    // show error if the user enters a negative integer
    if (n < 0)
        printf("Error! Factorial of a negative number doesn't exist.");

    else
    {
        for(i=1; i<=n; ++i)
        {
            factorial *= i;              // factorial = factorial*i;
        }
        printf("Factorial of %d = %llu \n", n, factorial);
    }

    return 0;
}