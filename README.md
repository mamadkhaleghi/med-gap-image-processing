# Image Prediction and Reconstruction Techniques

## Overview
This repository contains implementations of various image prediction and reconstruction techniques in MATLAB. The project covers exercises on the MED (Median Edge Detector) and GAP (Gradient Adjusted Predictor) methods, as well as custom prediction methods for 3D image sequences.

## Features
- **Q1: MED Prediction and Reconstruction**
  - Implements the MED prediction method to predict pixel values and calculate prediction errors.
  - Reconstructs the image from the prediction error using the MED method.
  - Implemented in `MED_Predictor.m` and `MED_Reconstructor.m`.

- **Q2: GAP Prediction and Reconstruction**
  - Implements the GAP prediction method to predict pixel values and calculate prediction errors.
  - Reconstructs the image from the prediction error using the GAP method.
  - Implemented in `GAP_Predictor.m` and `GAP_Reconstructor.m`.

- **Q3: Custom Prediction and Reconstruction for 3D Sequences**
  - Proposes and implements a custom prediction method for 3D image sequences.
  - Evaluates the prediction error and reconstructs the image sequence.
  - Implemented in `My_Predictor.m` and `My_Reconstructor.m`.

- **Q4: Entropy Calculation for Image Sequences**
  - Reads DICOM and TIFF image sequences.
  - Combines the sequences into a single image and calculates entropy.
  - Implemented in `q4.m`.

- **Q5: MED Prediction and Reconstruction for Image Sequences**
  - Applies the MED method to predict and reconstruct image sequences frame by frame.
  - Calculates the prediction error entropy and evaluates the performance.
  - Implemented in `q5_MED.m`.

## Files
- **Q1 Files**
  - `MED_Predictor.m`: MATLAB script for MED prediction.
  - `MED_Reconstructor.m`: MATLAB script for MED reconstruction.
  - `q1_executor.m`: Script to execute MED prediction and reconstruction.

- **Q2 Files**
  - `GAP_Predictor.m`: MATLAB script for GAP prediction.
  - `GAP_Reconstructor.m`: MATLAB script for GAP reconstruction.
  - `q2_executor.m`: Script to execute GAP prediction and reconstruction.

- **Q3 Files**
  - `My_Predictor.m`: MATLAB script for custom prediction.
  - `My_Reconstructor.m`: MATLAB script for custom reconstruction.
  - `q3_executor.m`: Script to execute custom prediction and reconstruction.

- **Q4 Files**
  - `q4.m`: Script to read image sequences, combine them, and calculate entropy.

- **Q5 Files**
  - `q5_MED.m`: Script to apply MED prediction and reconstruction to image sequences.

## Dataset
- **`Images` Directory**: Contains various images used for testing the prediction and reconstruction algorithms.

## Prerequisites
Before you begin, ensure you have MATLAB installed on your machine.

## Installation
Clone this repository to your local machine using:
```bash
git clone https://github.com/mamadkhaleghi/med-gap-image-processing.git
