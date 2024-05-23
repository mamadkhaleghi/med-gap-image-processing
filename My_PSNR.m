function PSNR = My_PSNR(Original_Image, Reconstructed_Image)
    MSE = My_MSE(Original_Image, Reconstructed_Image);
    max_pixel_value = 255;
    if MSE ==0
        PSNR = inf;
    else
        PSNR = 10 * log10((max_pixel_value^2) / MSE);
    end
end