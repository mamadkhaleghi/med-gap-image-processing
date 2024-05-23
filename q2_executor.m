clc
clear
%====================================================
image_path = 'Images\Bridge.tif' ; 

Input_Image = imread(image_path);
%====================================================
Error_Image = GAP_Predictor(Input_Image);

Reconstructed_Image = GAP_Reconstructor(Error_Image);

imwrite(Reconstructed_Image , 'Images\rec_Bridge.tif');
%====================================================
PSNR = My_PSNR(Input_Image, Reconstructed_Image);

Image_Entropy = My_Entropy(Input_Image);
Error_Entropy = My_Entropy(Error_Image);