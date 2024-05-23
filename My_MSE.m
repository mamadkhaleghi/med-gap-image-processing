function MSE = My_MSE(Original_Image, Reconstructed_Image)
    % Ensure both images are of the same size
    assert(isequal(size(Original_Image), size(Reconstructed_Image)), 'Both images must have the same size.');
   
    Original_Image = int16(Original_Image);
    Reconstructed_Image = int16(Reconstructed_Image);
    
    % Compute the squared difference between the images
    squared_diff = (Original_Image - Reconstructed_Image).^2 ; 
    
    % Calculate the MSE
    MSE = sum(squared_diff(:)) / numel(Original_Image);
end