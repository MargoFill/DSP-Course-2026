%% Lab 6: Mini Project – Your Image Pipeline
close all; clear; clc;

% 1) Load your own image (object, face, landscape, etc.)
I = im2double(rgb2gray(imread('my_image.jpeg')));

% 2) Pre-process: noise removal
I_filt = medfilt2(I,[3 3]);

% 3) Enhance contrast
I_enh = imadjust(I_filt,[0.2 0.8],[0 1]);
imshow(I_enh);

J1=imadjust(I);
J2=histeq(I);
J3=adapthisteq(I);

figure;
subplot(2,2,1), imshow(I), title("Original");
subplot(2,2,2), imshow(J1), title("imadjust");
subplot(2,2,3), imshow(J2), title("histeq");
subplot(2,2,4), imshow(J3), title("adapthisteq");

% 4) Extract features (edges or frequency)
edges = edge(I_enh,'Canny',[0.1 0.25]);

figure;
imshow(edges);
title('4. Extracted Edges (Canny [0.1 0.25])');

% 5) Optional frequency-domain mask
F = fftshift(fft2(I_enh));
[M,N]=size(F);
[u,v]=meshgrid(-N/2:N/2-1,-M/2:M/2-1);
H = double(sqrt(u.^2+v.^2)<60);
I_lp = real(ifft2(ifftshift(F.*H)));

% Intermediate visualization: 2D FFT Spectrum & Low-Pass Mask
figure;
subplot(1,2,1), imshow(log(1 + abs(F)), []), title('2D FFT Log-Magnitude Spectrum');
subplot(1,2,2), imshow(H, []),               title('Ideal Low-Pass Mask (D0 = 60)');

% Final Low-Pass filtered image on a separate figure
figure;
imshow(I_lp);
title('5. Low-Pass Filtered Result (Blurred / Smooth Structure)');

% 6) Visualization
figure; montage({I, I_filt, I_enh, edges, I_lp},'Size',[1 5]);
title('Original | Denoised | Enhanced | Edges | LP result');

%% 7) Report
% - Describe your processing pipeline.
% - Explain how each stage relates to DSP operations.
% - Discuss improvements or limitations.