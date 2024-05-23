function [Reconstructed_Image,rec_time] = My_Reconstructor( Error_Image)
    tic;
    [Height, Width] = size(Error_Image);
    
    Error_Image = padarray(Error_Image, [2, 2], 0, 'pre');
    Error_Image = padarray(Error_Image,[0, 1], 0, 'post');
    
    Prediction = int16(zeros([Height+2, Width+3]));
    Reconstructed_Image = uint8(zeros([Height, Width]));
    %======================================================
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
            %=====================================% Sharp Horizontal Edge
            if (d_v - d_h) > 62
                x = W ; 
                cond_1 = 1 ; 
            %=====================================% Sharp Vertical Edge
            elseif (d_v - d_h) < -62
                x = N ;
                cond_1 = 1 ; 
            %==========================================
            else
                x = (W+N)/2 + (NE-NW)/5;
                cond_1 = 4 ; 
                %--------------------------- Horizontal Edge
                if (d_v - d_h) > 14
                    x = ( x + W )/2;
                    cond_1 = 2 ; 
                %--------------------------- Vertical Edge
                elseif (d_v - d_h) < -14
                    x = ( x + N )/2;
                    cond_1 = 2 ; 
                %--------------------------- Weak Horizontal Edge
                elseif (d_v - d_h) > 1
                    x = ( 4*x + W )/5;
                    cond_1 = 3 ; 
                %--------------------------- Weak Vertical Edge
                elseif (d_v - d_h) < -1
                    x = ( 4*x + N )/5;
                    cond_1 = 3 ; 
                end
            end
            %==========================================
            % to find neighbors error
            e_W  = Error_Image(i, j-1);
            e_N  = Error_Image(i-1, j);
            e_NW = Error_Image(i-1, j-1);
            %---------------------------------------
            if cond_1 ==1    % Strong Edge
                a = 0.24 ;
            elseif cond_1==2 % Edge
                a = 0.28 ;
            elseif cond_1==3 % Weak  Edge
                a = 0.16 ;
            elseif cond_1==4
                a = 0.12 ;
            end
            %---------------------------------------
            error_sum = (e_W + e_N + e_NW ) ;
            x = x + ( a * error_sum ) ;
            %==========================================
            if x >255
                x = 255;
            elseif x < 0
                x=0;
            end
            %==========================================
            % to update the prediction using the Error_Image
            Error = Error_Image(i, j);
            Prediction(i, j) = x + Error;
            %-----------------------------------
            % to store the reconstructed pixel in the output matrix
            Reconstructed_Image(i-2, j-2) = uint8(Prediction(i, j));
        end
    end
    rec_time = toc;
end
