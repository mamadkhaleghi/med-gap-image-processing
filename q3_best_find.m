clc
clear

threshold_vals = [1,2,3,4,5,6,7,8,9,10,15,20,25,30,50  ] ; 
ROC_vals = [ 1/8, 1/16, 1/32, 1/64, 1/128, 1/256, 1/512 ] ;

files = dir(fullfile('Images'));
numFiles = numel(files);

best_entropy = inf;
%--------------------------------------------------------------
for threshold=threshold_vals
    for ROC=ROC_vals
        total_entropy = 0;
        for fileIndex=3:numFiles

            Input_Image = imread(fullfile('Images', files(fileIndex).name)) ; 
            [Error_Image,pred_time] = My_Predictor(Input_Image , threshold , ROC);
            [Reconstructed_Image,rec_time] = My_Reconstructor(Error_Image, threshold , ROC);
            exec_time = pred_time + rec_time ;
            PSNR = My_PSNR(Input_Image, Reconstructed_Image);
            Error_Entropy = My_Entropy(Error_Image);
            %--------------------------------------
            total_entropy = total_entropy + Error_Entropy ; 
        end
        average_entropy = total_entropy / 10 ; 
        %---------------------------------------------------------------
        if average_entropy < best_entropy
            best_entropy = average_entropy ; 
            best_exec_time = exec_time;
            best_threshold = threshold ;
            best_ROC =ROC ;
        end
        %---------------------------------------------------------------
    end
end

disp(['best_threshold: ', num2str(best_threshold)]);
disp(['best_ROC: ', num2str(best_ROC)]);
disp(['best_entropy: ', num2str(best_entropy)]);
disp(['best_exec_time: ', num2str(best_exec_time)]);

