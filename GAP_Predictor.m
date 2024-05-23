function Error_Image = GAP_Predictor(Input_Image)

    [Height, Width] = size(Input_Image);
    Error_Image = int16(zeros([Height, Width]));
    
    padded_Image = padarray(Input_Image, [2, 2], 0, 'pre');
    padded_Image = padarray(padded_Image,[0, 1], 0, 'post');
    padded_Image = int16(padded_Image);
    
    for i = 3:Height+2
        for j = 3:Width+2
            %-----------------------------------    
            % to find neighbors of current pixel (i,j)
            W  = padded_Image(i, j-1);
            N  = padded_Image(i-1, j);
            WW = padded_Image(i, j-2);
            NW = padded_Image(i-1, j-1);
            NN = padded_Image(i-2, j);
            NE = padded_Image(i-1, j+1);
            NNE= padded_Image(i-2, j+1);
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
            Error_Image(i-2, j-2) = int16(Input_Image(i-2, j-2)) - x;
        end
    end
    %==========================================
end


