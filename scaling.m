function [binR,binG,binB] = scaling(marked_area,row,col)
% scale down the RGB values of pixels to see
% in which of the 8 bins they belong to
binR = floor(double(marked_area(row,col,1))/32.0)+1;
binG = floor(double(marked_area(row,col,2))/32.0)+1;
binB = floor(double(marked_area(row,col,3))/32.0)+1;
end



