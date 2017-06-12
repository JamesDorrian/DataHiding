grayImage = imread('lena.png');
A = double(grayImage);
A1 = A - 128;
T_DCT = dctmtx(8);
dct_trans = @(block) (T_DCT*block.data*T_DCT');
I_DCT = blockproc(A,[8 8],dct_trans);
I2_DCT = blockproc(A1,[8 8],dct_trans);
range_1 = 0;
range_2 = 0;
for i = 1:8:size(I_DCT,1)
    for j = 1:8:size(I_DCT,2)
        block_1 = I_DCT(i:i+7, j:j+7);
        block_2 = I2_DCT(i:i+7, j:j+7);
        block_1 = block_1(:);
        block_2 = block_2(:);
        range_1 = range_1 + max(max(block_1)) - min(min(block_1));
        range_2 = range_2 + max(max(block_2)) - min(min(block_2));
    end
end
% return final ranges
range_1
range_2
% compare ranges and return percentage
(range_2/range_1)*100