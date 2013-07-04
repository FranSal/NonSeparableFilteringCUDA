clear all
clc
close all

mex Filtering2D.cpp -lcudart -lcufft -lFilteringCUDA -IC:/Program' Files'/NVIDIA' GPU Computing Toolkit'/CUDA/v5.0/include -LC:/Program' Files'/NVIDIA' GPU Computing Toolkit'/CUDA/v5.0/lib/x64 -LC:/users/wande/Documents/Visual' Studio 2010'/Projects/Filtering/x64/Release/ -IC:/users/wande/Documents/Visual' Studio 2010'/Projects/Filtering/

% Loop over filter sizes

% image = randn(2048,2048);
% 
% N = length(3:2:17);
% texture_times = zeros(N,1);
% texture_times_unrolled = zeros(N,1);
% shared_times = zeros(N,1);
% shared_times_unrolled = zeros(N,1);
% fft_times = zeros(N,1);
% megapixels = zeros(N,1);
% 
% sizes = 3:2:17;
% 
% % HALO 4
% i = 1;
% for size = 3:2:9
%     filter = randn(size,size);
%     filter = filter/sum(abs(filter(:)));    
%     [filter_response_gpu_texture, filter_response_gpu_texture_unrolled, filter_response_gpu_shared, filter_response_gpu_shared_unrolled, time_texture, time_texture_unrolled, time_shared, time_shared_unrolled, time_fft]  = Filtering2D(image,filter,1);
%     texture_times(i) = time_texture;
%     texture_times_unrolled(i) = time_texture_unrolled;
%     shared_times(i) = time_shared;
%     shared_times_unrolled(i) = time_shared_unrolled;    
%     fft_times(i) = time_fft;
%     megapixels(i) = 2048*2048/1000000;
%     i = i + 1;
% end
% 
% 
% % HALO 8
% for size = 11:2:17
%     filter = randn(size,size);
%     filter = filter/sum(abs(filter(:)));    
%     [filter_response_gpu_texture, filter_response_gpu_texture_unrolled, filter_response_gpu_shared, filter_response_gpu_shared_unrolled, time_texture, time_texture_unrolled, time_shared, time_shared_unrolled, time_fft]  = Filtering2D(image,filter,1);
%     texture_times(i) = time_texture;
%     texture_times_unrolled(i) = time_texture_unrolled;
%     shared_times(i) = time_shared;
%     shared_times_unrolled(i) = time_shared_unrolled;  
%     fft_times(i) = time_fft;
%     megapixels(i) = 2048*2048/1000000;
%     i = i + 1;
% end
% 
% 
% figure
% plot(sizes,megapixels ./ texture_times * 1000, 'b','LineWidth',2)
% hold on
% plot(sizes,megapixels ./ texture_times_unrolled * 1000, 'r','LineWidth',2)
% hold on
% plot(sizes,megapixels ./ shared_times * 1000, 'g','LineWidth',2)
% hold on
% plot(sizes,megapixels ./ shared_times_unrolled * 1000, 'k','LineWidth',2)
% hold on
% plot(sizes,megapixels ./ fft_times * 1000, 'c','LineWidth',2)
% hold off
% set(gca,'FontSize',15)
% xlabel('Filter size','FontSize',15)
% ylabel('Megapixels / second','FontSize',15)
% legend('Texture','Texture unrolled','Shared','Shared unrolled','FFT')
% 
% print -dpng benchmark_2D_filtering_filter_sizes_image_size_2048x2048.png

%%
% Loop over image sizes for filter size 9 x 9 
% HALO 4
% filter = randn(9,9);
% filter = filter/sum(abs(filter(:)));
% 
% N = length(128:128:4096);
% texture_times = zeros(N,1);
% texture_times_unrolled = zeros(N,1);
% shared_times = zeros(N,1);
% shared_times_unrolled = zeros(N,1);
% fft_times = zeros(N,1);
% megapixels = zeros(N,1);
% 
% sizes = 128:128:4096;
% 
% i = 1;
% for size = sizes
%     image = randn(size,size);
%     [filter_response_gpu_texture, filter_response_gpu_texture_unrolled, filter_response_gpu_shared, filter_response_gpu_shared_unrolled, time_texture, time_texture_unrolled, time_shared, time_shared_unrolled, time_fft]  = Filtering2D(image,filter,1);
%     texture_times(i) = time_texture;
%     texture_times_unrolled(i) = time_texture_unrolled;
%     shared_times(i) = time_shared;
%     shared_times_unrolled(i) = time_shared_unrolled;    
%     fft_times(i) = time_fft;
%     megapixels(i) = size*size/1000000;
%     i = i + 1;
% end
% 
% close all
% figure
% plot(sizes, megapixels ./ texture_times * 1000, 'b','LineWidth',2)
% hold on
% plot(sizes, megapixels ./ texture_times_unrolled * 1000, 'r','LineWidth',2)
% hold on
% plot(sizes, megapixels ./ shared_times * 1000, 'g','LineWidth',2)
% hold on
% plot(sizes, megapixels ./ shared_times_unrolled * 1000, 'k','LineWidth',2)
% hold on
% plot(sizes, megapixels ./ fft_times * 1000, 'c','LineWidth',2)
% hold off
% set(gca,'FontSize',15)
% xlabel('Image size','FontSize',15)
% ylabel('Megapixels / second','FontSize',15)
% legend('Texture','Texture unrolled','Shared','Shared unrolled','FFT')
% 
% print -dpng benchmark_2D_filtering_image_sizes_9x9.png

%%

% Loop over image sizes for filter size 17 x 17
% HALO 8
filter = randn(17,17);
filter = filter/sum(abs(filter(:)));

N = length(128:128:4096);
texture_times = zeros(N,1);
texture_times_unrolled = zeros(N,1);
shared_times = zeros(N,1);
shared_times_unrolled = zeros(N,1);
fft_times = zeros(N,1);
megapixels = zeros(N,1);

sizes = 128:128:4096;

i = 1;
for size = sizes
    image = randn(size,size);
    [filter_response_gpu_texture, filter_response_gpu_texture_unrolled, filter_response_gpu_shared, filter_response_gpu_shared_unrolled, time_texture, time_texture_unrolled, time_shared, time_shared_unrolled time_fft]  = Filtering2D(image,filter,1);
    texture_times(i) = time_texture;
    texture_times_unrolled(i) = time_texture_unrolled;
    shared_times(i) = time_shared;
    shared_times_unrolled(i) = time_shared_unrolled;    
    fft_times(i) = time_fft;
    megapixels(i) = size*size/1000000;
    i = i + 1;
end

figure
plot(sizes,megapixels ./ texture_times * 1000, 'b','LineWidth',2)
hold on
plot(sizes,megapixels ./ texture_times_unrolled * 1000, 'r','LineWidth',2)
hold on
plot(sizes,megapixels ./ shared_times * 1000, 'g','LineWidth',2)
hold on
plot(sizes,megapixels ./ shared_times_unrolled * 1000, 'k','LineWidth',2)
hold on
plot(sizes,megapixels ./ fft_times * 1000, 'c','LineWidth',2)
hold off
set(gca,'FontSize',15)
xlabel('Image size','FontSize',15)
ylabel('Megapixels / second','FontSize',15)
legend('Texture','Texture unrolled','Shared','Shared unrolled','FFT')

print -dpng benchmark_2D_filtering_image_sizes_17x17.png

