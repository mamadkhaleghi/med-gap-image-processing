function [Error_Image,pred_time] = My_Predictor(Input_Image)
    tic;
    [Height, Width] = size(Input_Image);    
    Error_Image = int16(zeros([Height+2, Width+3]));
    
    padded_Image = padarray(Input_Image, [2, 2], 0, 'pre');
    padded_Image = padarray(padded_Image,[0, 1], 0, 'post');
    padded_Image = int16(padded_Image);
    %======================================================
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
            %===================================== Calculating the error
            Error = int16(Input_Image(i-2, j-2)) - x;
            Error_Image(i, j) = Error ;

        end
    end
    Error_Image = Error_Image(3:Height+2 ,3:Width+2);
    pred_time = toc;
    
end