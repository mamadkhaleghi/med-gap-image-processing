clc
clear
parentFolder = 'Sequences';
folderNames = {'CT_head','MRI_1', 'MRI_2', 'MRI_3', 'mri_Brain'};

total_Entropy = 0 ;

for folderIndex = 1:length(folderNames)
    currentFolder = fullfile(parentFolder, folderNames{folderIndex});
    %====================================================================== for ".dcm" files
    if contains(folderNames{folderIndex}, 'MRI')  
        %-----------------------------------------------------------
        % Get a list of DICOM files in the folder
        dicomFiles = dir(fullfile(currentFolder, '*.dcm'));
        numFrames = numel(dicomFiles);
        %-----------------------------------------------------------% Prediction
        % to make a combination error image
        combined_Error = [];
        tic;
        for frameIndex = 1:numFrames
            frame_error = MED_Predictor(dicomread(fullfile(currentFolder, dicomFiles(frameIndex).name)));
            combined_Error = [combined_Error; frame_error];
        end
        pred_time = toc ; 
        %-----------------------------------------------------------% Error Entropy Calculation
        Entropy = My_Entropy(combined_Error);
        H = size(combined_Error);
        height = H/numFrames ; 
        %-----------------------------------------------------------% Reconstruction
        combined_Rec = [];
        tic;
        for frameIndex = 1:numFrames
            Reconstructed_frame = MED_Reconstructor(combined_Error( (frameIndex-1)*height+1 : frameIndex*height ));
            combined_Rec = [combined_Rec;Reconstructed_frame] ; 
        end
        Rec_time = toc;
    %======================================================================  for ".tif" images 
    else          
        % Get a list of DICOM files in the folder
        tifFiles = dir(fullfile(currentFolder, '*.tif'));
        numFrames = numel(tifFiles);
        %-----------------------------------------------------------% Prediction
        % to make a combination error image
        combined_Error = [];
        tic ; 
        for frameIndex = 1:numFrames
            frame_error = MED_Predictor(imread(fullfile(currentFolder, tifFiles(frameIndex).name)));
            combined_Error = [combined_Error; frame_error];
        end
        pred_time = toc ; 
        %-----------------------------------------------------------% Error Entropy Calculation
        Entropy = My_Entropy(combined_Error);
        H = size(combined_Error);
        height = H/numFrames ; 
        %-----------------------------------------------------------% Reconstruction
        combined_Rec = [];
        tic;
        for frameIndex = 1:numFrames
            Reconstructed_frame = MED_Reconstructor(combined_Error( (frameIndex-1)*height+1 : frameIndex*height ));
            combined_Rec = [combined_Rec;Reconstructed_frame] ;
        end
        Rec_time = toc;
    end
    
    total_Entropy = total_Entropy + Entropy ;
    
    disp(['Folder: ', folderNames{folderIndex}]);
    disp(['No. of frames: ', num2str(numFrames)]);
    disp(['Entropy: ', num2str(Entropy)]);
    disp(['Prediction time: ', num2str(pred_time)]);
    disp(['Reconstruction time: ', num2str(Rec_time)]);
    disp('-----------------------------------------------');
    
end

disp(['Average Entropy: ', num2str(total_Entropy/length(folderNames))]);

