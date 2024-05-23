clc
clear
%====================================================
image_path = 'Images\barbara.tif' ; 

Input_Image = imread(image_path);
%====================================================
Error_Image = MED_Predictor(Input_Image);

Reconstructed_Image = MED_Reconstructor(Error_Image);
imwrite(Reconstructed_Image , 'Images\rec_barbara.tif');

%====================================================1

PSNR = My_PSNR(Input_Image, Reconstructed_Image);

Image_Entropy = My_Entropy(Input_Image);
Error_Entropy = My_Entropy(Error_Image);