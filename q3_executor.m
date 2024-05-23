clc
clear

files = dir(fullfile('Images'));
numFiles = numel(files);
total_entropy = 0;

for fileIndex=3:numFiles
    %--------------------------------------
    Input_Image = imread(fullfile('Images', files(fileIndex).name)) ; 
    %--------------------------------------
    [Error_Image,pred_time] = My_Predictor(Input_Image );
    [Reconstructed_Image,rec_time] = My_Reconstructor(Error_Image);
    %--------------------------------------
    exec_time = pred_time + rec_time ;
    PSNR = My_PSNR(Input_Image, Reconstructed_Image);
    Error_Entropy = My_Entropy(Error_Image);
    %--------------------------------------
    total_entropy = total_entropy + Error_Entropy ; 
    %--------------------------------------
    disp(['image: ', files(fileIndex).name]);
    disp(['Execution Time: ', num2str(exec_time)]);
    disp(['PSNR: ', num2str(PSNR)]);
    disp(['Error Entropy: ', num2str(Error_Entropy)]);
    disp('-----------------------------------------------');
end
average_entropy = total_entropy / 10 ; 
disp(['average_entropy: ', num2str(average_entropy)]);

