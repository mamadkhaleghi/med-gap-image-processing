function E = My_Entropy(Input_Image)

    Input_Image = reshape(Input_Image, 1, []);
    if min(Input_Image) ~= 1
        Input_Image = Input_Image - min(Input_Image) + 1;
    end
    p = zeros(1,max(Input_Image));
    for i = 1:length(Input_Image)
        p(Input_Image(i)) = p(Input_Image(i)) + 1;
    end
    p = p/sum(p);
    p(p==0) = [];
    E = sum(-p.*log2(p));
end