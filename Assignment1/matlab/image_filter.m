function [ I1 ] = filter_brislames(I)    
    R_F = [-0.1659, 0.3726, 0.5864, 0.0927];
    G_F = [9.1383, -25.1677,  21.1906, -4.5517, 0.3888, -0.0087]; %histogram transformations
    B_F = G_F;
    x = 0:1/255:1; %scale between 1 and 0
    prx = polyval(R_F, x) *255;
    pgx = polyval(G_F, x) *255;
    pbx = polyval(B_F, x) *255; %turns array into polynomial co-efficients
    TR = uint8(prx(I(:,:,1) + 1)); %(:,:) loops through array
    TG = uint8(pgx(I(:,:,2) + 1)); %1,2,3 for each layer
    TB = uint8(pbx(I(:,:,3) + 1)); 
    I1 = cat(3, TR, TG, TB); %combine 3 
    imshow(I1)
end