

void pack_double2float_volumes(float* output_float, double* input_double, int DATA_W, int DATA_H, int DATA_D, int DATA_T)
{
	int i = 0;
	for (int t = 0; t < DATA_T; t++)
	{
		for (int z = 0; z < DATA_D ; z++)
		{
			for (int x = 0; x < DATA_W ; x++)
			{
				for (int y = 0; y < DATA_H ; y++)
				{
					output_float[x + y * DATA_W + z * DATA_W * DATA_H + t * DATA_W * DATA_H * DATA_D] = (float)input_double[i];
					i++;
	   		   	}
			}
		}
	}
}



void unpack_float2double_volumes(double* output_double, float* input_float, int DATA_W, int DATA_H, int DATA_D, int DATA_T)
{
	int i = 0;
	for (int t = 0; t < DATA_T; t++)
	{
		for (int z = 0; z < DATA_D ; z++)
		{
			for (int x = 0; x < DATA_W ; x++)
			{
				for (int y = 0; y < DATA_H ; y++)
				{
					output_double[i] = (double)input_float[x + y * DATA_W + z * DATA_W * DATA_H + t * DATA_W * DATA_H * DATA_D];
					i++;
	      		}
			}
		}
	}
}

void pack_double2float_image(float* output_float, double* input_double, int DATA_W, int DATA_H)
{
	int i = 0;
	for (int x = 0; x < DATA_W ; x++)
	{
		for (int y = 0; y < DATA_H ; y++)
		{
			output_float[x + y * DATA_W] = (float)input_double[i];
			i++;
	   	}
	}
}


void unpack_float2double_image(double* output_double, float* input_float, int DATA_W, int DATA_H)
{
	int i = 0;
	for (int x = 0; x < DATA_W ; x++)
	{
		for (int y = 0; y < DATA_H ; y++)
		{
			output_double[i] = (double)input_float[x + y * DATA_W];
			i++;
	   	}
	}
}