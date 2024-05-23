clc
clear
parentFolder = 'Sequences';
folderNames = {'CT_head','MRI_1', 'MRI_2', 'MRI_3', 'mri_Brain'};

% Loop through each folder
for folderIndex = 1:length(folderNames)
    currentFolder = fullfile(parentFolder, folderNames{folderIndex});
    %====================================================================== for ".dcm" files
    if contains(folderNames{folderIndex}, 'MRI')  
        %-----------------------------------------------------------
        % Get a list of DICOM files in the folder
        dicomFiles = dir(fullfile(currentFolder, '*.dcm'));
        numFrames = numel(dicomFiles);
        %-----------------------------------------------------------
        % to check the width and height of the first file in current folder 
        % (Assuming that all images have the same resolution)
        dicomInfo = dicominfo(fullfile(currentFolder, dicomFiles(1).name));
        height = dicomInfo.Height;
        width  = dicomInfo.Width;
        %-----------------------------------------------------------
        % to make a combination image with sequence images in currentFolder
        combined_image = dicomread(fullfile(currentFolder, dicomFiles(1).name));
        for frameIndex = 2:numFrames
            dicomData = dicomread(fullfile(currentFolder, dicomFiles(frameIndex).name));
            combined_image = [combined_image; dicomData];
        end
        %-----------------------------------------------------------
        maxValue = max(combined_image(:));
        Entropy = My_Entropy(combined_image);
    %======================================================================  for ".tif" images 
    else          
        % Get a list of DICOM files in the folder
        tifFiles = dir(fullfile(currentFolder, '*.tif'));
        numFrames = numel(tifFiles);
        %-----------------------------------------------------------
        % to check the width and height of the first file in current folder 
        % (Assuming that all images have the same resolution)
        tifInfo = imfinfo(fullfile(currentFolder, tifFiles(1).name));
        height = tifInfo.Height;
        width  = tifInfo.Width;
        %-----------------------------------------------------------
        % to make a combination image with sequence images in currentFolder
        combined_image = imread(fullfile(currentFolder, tifFiles(1).name));
        for frameIndex = 2:numFrames
            tifData = imread(fullfile(currentFolder, tifFiles(frameIndex).name));
            combined_image = [combined_image; tifData];
        end
        %-----------------------------------------------------------
        maxValue = max(combined_image(:));
        Entropy = My_Entropy(combined_image);
    end
     %=========================================================== Display or store the results as needed
    disp(['Folder: ', folderNames{folderIndex}]);
    disp(['Resolution: ', num2str(height),'x',num2str(width)]);
    disp(['No. of frames: ', num2str(numFrames)]);
    disp(['Max. Value: ', num2str(maxValue)]);
    disp(['Entropy: ', num2str(Entropy)]);
    disp('-----------------------------------------------');
    
end
