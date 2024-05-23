    function Reconstructed_Image = MED_Reconstructor(Error_Image)

        [H, W] = size(Error_Image);
        Prediction = int16(zeros([H+1, W+1]));
        Reconstructed_Image = uint8(zeros([H, W]));

        for i = 2:H+1
            for j = 2:W+1
                %-----------------------------------
                % to find neighbors of current pixel
                a = Prediction(i, j-1);
                b = Prediction(i-1, j);
                c = Prediction(i-1, j-1);
                %-----------------------------------
                if c >= max(a, b)
                    x = min(a, b);
                elseif c <= min(a,b)
                    x = max(a, b);
                else
                    x = a + b - c;
                end
                %-----------------------------------
                % to update the prediction using the Error_Image
                Prediction(i, j) = x + Error_Image(i-1, j-1);
                %-----------------------------------
                % to store the reconstructed pixel in the output matrix
                Reconstructed_Image(i-1, j-1) = uint8(Prediction(i, j));
            end
        end
    end
