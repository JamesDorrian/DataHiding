I = imread('briselames.png'); %read in the image
x = 0: 1/255 : 1 ; %normalise the RGB values for each pixel btw 0 and 1
center = [(size(I,1)/2),(size(I,2)/2)]; %find center point x & y co-ords
vignete = zeros(size(I,1), size(I,2)); %create array which will hold the transformation values of each pixel
combined_img = zeros(size(I,1), size(I,2), 3); %create array to hold pixel values of new image
center(1) %= 320
center(2) %=320 works
for i = 1:size(vignete,1) %create gradient image
    for j = 1:size(vignete,2)
         distance_center = sqrt(   (i - center(1))^2   + (j - center(2))^2)/center(1)/2;
         if (distance_center<1/3) 
             vignete(i,j) = 0.5; %close pixels get 0.5 val which is lightest grey available
         elseif (distance_center<=2/3)
             vignete(i,j) = (1+cos(3*pi*(distance_center-1/3)))*0.25; %scaling for intermediate pixels getting closer to black
         else
             vignete(i,j) = 0; %0 for outermost pixels (black)
         end
    end
end
% imshow(uint8(vignete(:,:) * 255)) %shows the gradient

 for i = 1:size(vignete,1)
     for j = 1:size(vignete,2)
         for color = 1:3 %used to multiply by all layers (RGB)
             if vignete(i,j) <= 0.5
                 combined_img(i,j,color) = 2 * vignete(i,j) * I(i,j,color); %gradient * briselames at RGB levels
             else 
                 combined_img(i,j,color) = 1 - 2 * (1-vignete(i,j)) * (1 - I(i,j,color)); %gradient * briselames at RBG levels
             end
         end
     end
 end
 
% combined_img
% imshow(combined_img) % gives us an image which has the gradient applied but not the histographic transformations
imshow(image_filter(combined_img))