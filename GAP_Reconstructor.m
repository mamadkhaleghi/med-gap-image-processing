function Reconstructed_Image = GAP_Reconstructor(Error_Image)

    [Height, Width] = size(Error_Image);
    Prediction = int16(zeros([Height+2, Width+3]));
    Reconstructed_Image = uint8(zeros([Height, Width]));

    for i = 3:Height+2
        for j = 3:Width+2
            %-----------------------------------    
            % to find neighbors of current pixel
            W  = Prediction(i, j-1);
            N  = Prediction(i-1, j);
            WW = Prediction(i, j-2);
            NW = Prediction(i-1, j-1);
            NN = Prediction(i-2, j);
            NE = Prediction(i-1, j+1);
            NNE= Prediction(i-2, j+1);
            %==========================================
            d_h = abs(W-WW) + abs(N-NW) + abs(N-NE);
            d_v = abs(W-NW) + abs(N-NN) + abs(NE-NNE);
            %==========================================
            if (d_v - d_h) > 80
                x = W ;
            %==========================================
            elseif (d_v - d_h) < -80
                x = N ;
            %==========================================
            else
                x = (W+N)/2 + (NE-NW)/4;
                %-------------------------------
                if (d_v - d_h) > 32
                    x = ( x + W )/2;
                %-------------------------------
                elseif (d_v - d_h) < -32
                    x = ( x + N )/2;
                %-------------------------------
                elseif (d_v - d_h) > 8
                    x = ( 3*x + W )/4;
                %-------------------------------
                elseif (d_v - d_h) < -8
                    x = ( 3*x + N )/4;
                end
            end
            %==========================================
            % to update the prediction using the Error_Image
            x = x + Error_Image(i-2, j-2);
            %-----------------------------------
            Prediction(i, j) = x;
            %-----------------------------------
            % to store the reconstructed pixel in the output matrix
            Reconstructed_Image(i-2, j-2) = uint8(x);
        end
    end
end
