/*
	Non-separable 2D, 3D and 4D Filtering with CUDA
	Copyright (C) <2013>  Anders Eklund, andek034@gmail.com

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#ifndef FILTERING_KERNEL_CU_
#define FILTERING_KERNEL_CU_

#include "filtering.h"
#include "help_functions.cu"



__device__ __constant__ float c_Filter[7][7];

__device__ float Conv_2D(float Image[64][96], int y, int x, int FILTER_W, int FILTER_H)
{
   float sum = 0.0f;

   int y_off = -(FILTER_H - 1)/2;
   for (int f_y = FILTER_H - 1; f_y >= 0; f_y--)
   {
      int x_off = -(FILTER_W - 1)/2;			
      for (int f_x = FILTER_W - 1; f_x >= 0; f_x--)
      {
         sum += Image[y + y_off][x + x_off] * c_Filter[f_y][f_x];
         x_off++;
      }
      y_off++;
   }
	
   return sum;
}

__device__ float Conv_2D_Unrolled_7x7(float image[64][96], int y, int x)
{
	float pixel; float sum = 0.0f;
	
    pixel = image[y - 3][x - 3]; 
    sum += pixel * c_Filter[6][6];
 
    pixel = image[y - 2][x - 3]; 
    sum += pixel * c_Filter[5][6];

    pixel = image[y - 1][x - 3]; 
    sum += pixel * c_Filter[4][6];

    pixel = image[y + 0][x - 3]; 
    sum += pixel * c_Filter[3][6];

    pixel = image[y + 1][x - 3]; 
    sum += pixel * c_Filter[2][6];

    pixel = image[y + 2][x - 3]; 
    sum += pixel * c_Filter[1][6];

    pixel = image[y + 3][x - 3]; 
    sum += pixel * c_Filter[0][6];



    pixel = image[y - 3][x - 2]; 
    sum += pixel * c_Filter[6][5];

    pixel = image[y - 2][x - 2]; 
    sum += pixel * c_Filter[5][5];

    pixel = image[y - 1][x - 2]; 
    sum += pixel * c_Filter[4][5];

    pixel = image[y + 0][x - 2]; 
    sum += pixel * c_Filter[3][5];

    pixel = image[y + 1][x - 2]; 
    sum += pixel * c_Filter[2][5];

    pixel = image[y + 2][x - 2]; 
    sum += pixel * c_Filter[1][5];

    pixel = image[y + 3][x - 2]; 
    sum += pixel * c_Filter[0][5];


    pixel = image[y - 3][x - 1]; 
    sum += pixel * c_Filter[6][4];

    pixel = image[y - 2][x - 1]; 
    sum += pixel * c_Filter[5][4];

    pixel = image[y - 1][x - 1]; 
    sum += pixel * c_Filter[4][4];

    pixel = image[y + 0][x - 1]; 
    sum += pixel * c_Filter[3][4];

    pixel = image[y + 1][x - 1]; 
    sum += pixel * c_Filter[2][4];

    pixel = image[y + 2][x - 1]; 
    sum += pixel * c_Filter[1][4];

    pixel = image[y + 3][x - 1]; 
    sum += pixel * c_Filter[0][4];


    pixel = image[y - 3][x + 0]; 
    sum += pixel * c_Filter[6][3];

    pixel = image[y - 2][x + 0]; 
    sum += pixel * c_Filter[5][3];

    pixel = image[y - 1][x + 0]; 
    sum += pixel * c_Filter[4][3];

    pixel = image[y + 0][x + 0]; 
    sum += pixel * c_Filter[3][3];

    pixel = image[y + 1][x + 0]; 
    sum += pixel * c_Filter[2][3];

    pixel = image[y + 2][x + 0]; 
    sum += pixel * c_Filter[1][3];

    pixel = image[y + 3][x + 0]; 
    sum += pixel * c_Filter[0][3];

    pixel = image[y - 3][x + 1]; 
    sum += pixel * c_Filter[6][2];
  
    pixel = image[y - 2][x + 1]; 
    sum += pixel * c_Filter[5][2];
  
    pixel = image[y - 1][x + 1]; 
    sum += pixel * c_Filter[4][2];

    pixel = image[y + 0][x + 1]; 
    sum += pixel * c_Filter[3][2];

    pixel = image[y + 1][x + 1]; 
    sum += pixel * c_Filter[2][2];
 
    pixel = image[y + 2][x + 1]; 
    sum += pixel * c_Filter[1][2];

    pixel = image[y + 3][x + 1]; 
    sum += pixel * c_Filter[0][2];
 


    pixel = image[y - 3][x + 2]; 
    sum += pixel * c_Filter[6][1];

    pixel = image[y - 2][x + 2]; 
    sum += pixel * c_Filter[5][1];

    pixel = image[y - 1][x + 2]; 
    sum += pixel * c_Filter[4][1];
 
    pixel = image[y + 0][x + 2]; 
    sum += pixel * c_Filter[3][1];

    pixel = image[y + 1][x + 2]; 
    sum += pixel * c_Filter[2][1];
    
    pixel = image[y + 2][x + 2]; 
    sum += pixel * c_Filter[1][1];

    pixel = image[y + 3][x + 2]; 
    sum += pixel * c_Filter[0][1];


    pixel = image[y - 3][x + 3]; 
    sum += pixel * c_Filter[6][0];

    pixel = image[y - 2][x + 3]; 
    sum += pixel * c_Filter[5][0];

    pixel = image[y - 1][x + 3]; 
    sum += pixel * c_Filter[4][0];

    pixel = image[y + 0][x + 3]; 
    sum += pixel * c_Filter[3][0];

    pixel = image[y + 1][x + 3]; 
    sum += pixel * c_Filter[2][0];

    pixel = image[y + 2][x + 3]; 
    sum += pixel * c_Filter[1][0];
 
    pixel = image[y + 3][x + 3]; 
    sum += pixel * c_Filter[0][0];

	return sum;
}

/*
 This function performs non-separable 2D convolution by using texture memory.
*/

__global__ void Convolution_2D_Texture(float* Filter_Response, int DATA_W, int DATA_H, int FILTER_W, int FILTER_H)
{
   int x = blockIdx.x * blockDim.x + threadIdx.x;
   int y = blockIdx.y * blockDim.y + threadIdx.y;

   if (x >= DATA_W || y >= DATA_H)
        return;

   float sum = 0.0f;

   float y_off = -(FILTER_H - 1)/2 + 0.5f;
   for (int f_y = FILTER_H - 1; f_y >= 0; f_y--)
   {
        float x_off = -(FILTER_W - 1)/2 + 0.5f;			
        for (int f_x = FILTER_W - 1; f_x >= 0; f_x--)
        {
             sum += tex2D(my_2D_texture,x + x_off,y + y_off) * c_Filter[f_y][f_x];
             x_off += 1.0f;
        }
        y_off += 1.0f;
    }

    Filter_Response[Get_2D_Index(x,y,DATA_W)] = sum;
}

/*
 This function performs non-separable 3D convolution by using texture memory.
*/

__global__ void Convolution_3D_Texture(float* Filter_Response, int DATA_W, int DATA_H, int DATA_D, int FILTER_W, int FILTER_H, int FILTER_D)
{
   int x = blockIdx.x * blockDim.x + threadIdx.x;
   int y = blockIdx.y * blockDim.y + threadIdx.y;
   int z = blockIdx.z * blockDim.z + threadIdx.z;

   if (x >= DATA_W || y >= DATA_H || z >= DATA_D)
        return;

   float sum = 0.0f;

   float z_off = -(FILTER_D - 1)/2 + 0.5f;
   for (int f_z = FILTER_D - 1; f_z >= 0; f_z--)
   {
      float y_off = -(FILTER_H - 1)/2 + 0.5f;
      for (int f_y = FILTER_H - 1; f_y >= 0; f_y--)
      {
         float x_off = -(FILTER_W - 1)/2 + 0.5f;			
         for (int f_x = FILTER_W - 1; f_x >= 0; f_x--)
         {
            sum += tex3D(my_3D_texture,x + x_off,y + y_off,z + z_off) * c_3D_Filter[f_y][f_x][f_z];
            x_off += 1.0f;
         }
         y_off += 1.0f;
     }
	 z_off += 1.0f;
   }

   Filter_Response[Get_3D_Index(x,y,z,DATA_W,DATA_H)] = sum;
}


__global__ void Convolution_2D_Shared(float* Filter_Response, float* Image, int DATA_W, int DATA_H, int FILTER_W, int FILTER_H, int xBlockDifference, int yBlockDifference)
{
   int x = blockIdx.x * VALID_RESPONSES_X + threadIdx.x;
   int y = blockIdx.y * VALID_RESPONSES_Y + threadIdx.y;

   if ( (x >= (DATA_W + xBlockDifference)) || (y >= (DATA_H + yBlockDifference)) )
        return;

   __shared__ float s_Image[64][96]; // y, x

   // Reset shared memory
   s_Image[threadIdx.y][threadIdx.x]           = 0.0f;
   s_Image[threadIdx.y][threadIdx.x + 32]      = 0.0f;
   s_Image[threadIdx.y][threadIdx.x + 64]      = 0.0f;
   s_Image[threadIdx.y + 32][threadIdx.x]      = 0.0f;
   s_Image[threadIdx.y + 32][threadIdx.x + 32] = 0.0f;
   s_Image[threadIdx.y + 32][threadIdx.x + 64] = 0.0f;

   // Read data into shared memory

   if ( ((x-HALO) >= 0) && ((x-HALO) < DATA_W) && ((y-HALO) >= 0) && ((y-HALO) < DATA_H) )   
      s_Image[threadIdx.y][threadIdx.x] = Image[Get_2D_Index(x-HALO,y-HALO,DATA_W)];

   if ( ((x+32-HALO) < DATA_W) && ((y-HALO) >= 0) && ((y-HALO) < DATA_H) )
      s_Image[threadIdx.y][threadIdx.x + 32] = Image[Get_2D_Index(x+32-HALO,y-HALO,DATA_W)];

   if ( ((x+64-HALO) < DATA_W) && ((y-HALO) >= 0) && ((y-HALO) < DATA_H) ) 
      s_Image[threadIdx.y][threadIdx.x + 64] = Image[Get_2D_Index(x+64-HALO,y-HALO,DATA_W)];

   if ( ((x-HALO) >= 0) && ((x-HALO) < DATA_W) && ((y+32-HALO) < DATA_H) )
      s_Image[threadIdx.y + 32][threadIdx.x] = Image[Get_2D_Index(x-HALO,y+32-HALO,DATA_W)];

   if ( ((x+32-HALO) < DATA_W) && ((y+32-HALO) < DATA_H) )
      s_Image[threadIdx.y + 32][threadIdx.x + 32] = Image[Get_2D_Index(x+32-HALO,y+32-HALO, DATA_W)];

   if ( ((x+64-HALO) < DATA_W) && ((y+32-HALO) < DATA_H) )
      s_Image[threadIdx.y + 32][threadIdx.x + 64] = Image[Get_2D_Index(x+64-HALO,y+32-HALO,DATA_W)];
	
   __syncthreads();   

   // Only threads inside the image do the convolution

   if ( (x < DATA_W) && (y < DATA_H) )
      Filter_Response[Get_2D_Index(x,y,DATA_W)] = Conv_2D(s_Image,threadIdx.y+HALO,threadIdx.x+HALO,FILTER_H,FILTER_W);

   if ( ((x + 32) < DATA_W) && (y < DATA_H) )
      Filter_Response[Get_2D_Index(x+32,y,DATA_W)] = Conv_2D(s_Image,threadIdx.y+HALO,threadIdx.x+32+HALO,FILTER_H,FILTER_W);

   if (threadIdx.x < (32 - HALO*2))
   {
      if ( ((x + 64) < DATA_W) && (y < DATA_H) )
         Filter_Response[Get_2D_Index(x+64,y,DATA_W)] = Conv_2D(s_Image,threadIdx.y+HALO,threadIdx.x+64+HALO,FILTER_H,FILTER_W);
   }

   if (threadIdx.y < (32 - HALO*2))
   {
      if ( (x < DATA_W) && ((y + 32) < DATA_H) )
         Filter_Response[Get_2D_Index(x,y+32,DATA_W)] = Conv_2D(s_Image,threadIdx.y+32+HALO,threadIdx.x+HALO,FILTER_H,FILTER_W);
   }

   if (threadIdx.y < (32 - HALO*2))
   {
      if ( ((x + 32) < DATA_W) && ((y + 32) < DATA_H) )
         Filter_Response[Get_2D_Index(x+32,y+32,DATA_W)] = Conv_2D(s_Image,threadIdx.y+32+HALO,threadIdx.x+32+HALO,FILTER_H,FILTER_W);		
   } 

   if ( (threadIdx.x < (32 - HALO*2)) && (threadIdx.y < (32 - HALO*2)) )
   {
      if ( ((x + 64) < DATA_W) && ((y + 32) < DATA_H) )
         Filter_Response[Get_2D_Index(x+64,y+32,DATA_W)] = Conv_2D(s_Image,threadIdx.y+32+HALO,threadIdx.x+64+HALO,FILTER_H,FILTER_W);
   }

}


#endif

