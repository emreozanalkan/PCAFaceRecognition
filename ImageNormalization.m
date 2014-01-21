function [normImg] = ImageNormalization(OriginalImg, Fimg, Fbar)

img = rgb2gray(OriginalImg);
img = histeq(img);

[A,b] = GetAB(Fimg, Fbar);

normImg = uint8(zeros(64, 64));

 for i=1:64
      for j=1:64       
          % solve the equation xy64 = A*xy + b to obtain the pixel 
          %positions in the bigger image
          xy = (pinv(A)*( [ i; j ] - b ));
          
          % extract the x and y coordinate 
          x240 = int32(xy(1,:));
          y320 = int32(xy(2,:));
          
          % Although very rare, these values can fall down to negative values. So if it
          % happens, just make it zero. One pixel won't make a huge difference.
          if(x240 <= 0)
              x240 = 1;
          end
          
          if(y320 <= 0)
              y320 = 1;
          end
          
          if(x240 > 240)
              x240 = 240;
          end
          
          if(y320 >320)
              y320 = 320;
          end
          % copy the value of the pixel in the bigger image to the
          % normalized image
          normImg(i,j) = uint8(img(y320, x240));
      end
      
 end
 
 normImg = normImg';
 
end