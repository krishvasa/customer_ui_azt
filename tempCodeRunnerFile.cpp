#include <stdio.h>

int main()
{
	//taking input

	int n;
	scanf("%d", &n);

	int matrix[n][n];
	
	for (int i = 0; i  < n; i++)
	{
		for (int j = 0; j < n; j++)
		{
			scanf("%d", &(matrix[i][j]));
		}
	}

	int min = 21; //setting minimum as 21 since max n is 20

	for (int mask = 0; mask < (1 << n); mask++) //as mask goes from 0 to 2^n - 1, its binary representation goes through all possibilities of including each bit or not
	{
		int loc = 0, towers = 0; //locations covered by 0 towers is 0
		for (int i = 0; i < n; i++)
		{
			if (mask & (1 << i)) //if there is a 1 in ith position in binary representation of mask, then include that tower
			{
				towers++;
				for (int j = 0; j < n; j++) //locations surveilled by tower i
				{
					if (matrix[i][j] == 1) loc |= (1 << j); //union of all locations covered so far
				}
			}
		}
		if (loc == (1 << n) - 1) //if all locations covered
		{
			if (towers < min) min = towers;
		}
	}

	printf("%d", min);

return 0;
}