function A_James_Dorrian_13369451(Index)
% Index = menu('Which part would you like to run?', '1', '2', '3', '4', '5')
switch(Index)
    case 1 % Question A1.1: Image Filters
        vignette(); % has call to image_filter inside
    case 2 % Question A1.2: Block Transforms
        DCT();
    case 3 % Question A1.3: Quantization
        A = double(imread('lena.png'));
        T_DCT = dctmtx(8);
        dct_trans = @(block) (T_DCT*block.data*T_DCT');
        I_DCT = blockproc(A,[8 8],dct_trans);
          %counter = 0;
        for i = 1:8:size(I_DCT,1)
            for j = 1:8:size(I_DCT,1)
                 %counter = counter + 1;
                block = I_DCT(i:i+7, j:j+7);
                Quan = quantisation(block,60); %returns quantised blocks
                %remove zeros
                
                
                
                % MARK: I used this to print out the histograms
                %                 if (count == 2)
                %                     histogram(Quan);
                %                     title('block number 1')
                %                     xlabel('range')
                %                     ylabel('# occurances')
                %                 end
            end
        end
    case 4 % Question A1.4: Zigzag Reordering
        A = double(imread('lena.png'));
        T_DCT = dctmtx(8);
        dct_trans = @(block) (T_DCT*block.data*T_DCT');
        I_DCT = blockproc(A,[8 8],dct_trans);
        for i = 1:8:size(I_DCT,1)
            for j = 1:8:size(I_DCT,1)
                block = I_DCT(i:i+7, j:j+7);
                Quan = quantisation(block,60); %returns quantised block
                Z = zigzag(Quan)
            end
        end
    case 5 % Question A1.5: DPCM on DC component
        A = double(imread('lena.png'));
        T_DCT = dctmtx(8);
        dct_trans = @(block) (T_DCT*block.data*T_DCT');
        I_DCT = blockproc(A,[8 8],dct_trans);
        dc_array= zeros(1, 1024);
        dc_difference= zeros(1, 1023);
        dc_counter = 1;
        for i = 1:8:size(I_DCT,1)
            for j = 1:8:size(I_DCT,1)
                block = I_DCT(i:i+7, j:j+7);
                dc_array(dc_counter) = block(1,1);
                if dc_counter < 1024 && dc_counter > 1
                    dc_difference(dc_counter) = dc_array(dc_counter) - dc_array(dc_counter-1);
                end
                dc_counter = dc_counter + 1
            end
        end
        histogram(dc_array) %displays the histogram of all DC values from
        histogram(dc_difference)
        
end