function Error_Image = MED_Predictor(Input_Image)

    [H, W] = size(Input_Image);
    Error_Image = int16(zeros([H, W]));
    padded_Image = int16(padarray(Input_Image, [1, 1], 0, 'pre'));

    for i = 2:H+1
        for j = 2:W+1
            %-----------------------------------    
            % to find neighbors of current pixel
            a = padded_Image(i, j-1);
            b = padded_Image(i-1, j);
            c = padded_Image(i-1, j-1);
            %-----------------------------------
            if c >= max(a, b)
                x = min(a, b);
            %-----------------------------------
            elseif c <= min(a,b)
                x = max(a, b);
            %-----------------------------------
            else
                x = a + b - c;
            %-----------------------------------
            end
            Error_Image(i-1, j-1) = int16(Input_Image(i-1, j-1)) - x;
        end
    end
end
