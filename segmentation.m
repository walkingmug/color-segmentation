close all;
clear;
clc;

% read video
video_input = VideoReader('360p.mp4');

% read first frame
first_frame = read(video_input,1);

% mark the object to be segmented
figure('Name',['Mark 4 rectangular points of the object to be segmented ' ...
    'using sequence: top left -> top right -> bottom right -> bottom left.']);
imshow(first_frame);
hold on;
% mark sequence: top left -> top right -> bottom right -> bottom left
[x,y] = ginput(4);
plot(x,y,'*r');

% extract the marked area
draw_mark = [x(1) y(1)  x(3)-x(1) y(3)-y(1)];  %[x y W H] 
marked_area = imcrop(first_frame,draw_mark); 

% create a 3D RGB color histogram of the marked area
size_marked_area = size(marked_area);
hist = zeros(8,8,8);   % divide each histogram axis into 8 bins
binR = 0;
binG = 0;
binB = 0;
% iterate over marked area
for row = 1:size_marked_area(1)
    for col = 1:size_marked_area(2)
        % see in which bins a pixel's RGB values belong in
        [binR,binG,binB] = scaling(marked_area,row,col);
        % increase the values of 8-bin histogram by 1
        hist(binR,binG,binB) = hist(binR,binG,binB) + 1;
    end
end


% Normalize historgram

% find the index of the maximum value
[maxv,index] = max(hist(:));
[r,c,p] = ind2sub(size(hist),index);

% scale values such that the largest bin has a value of 255
scale = maxv / 255;
size_hist = size(hist);
for row = 1:size_hist(1)
    for col = 1:size_hist(2)
        for pos = 1:size_hist(3)
            hist(row,col,pos) = round(hist(row,col,pos) / scale);
        end
    end
end


% Convert video to grayscale
size_first_frame = size(first_frame);
gray_video = zeros(size_first_frame(1),size_first_frame(2),1, ...
    video_input.NumFrames); % row,col,pos,frame
for frame = 1:video_input.NumFrames
    current_frame = read(video_input,frame);
    size_current_frame = size(current_frame);
    for row = 1:size_current_frame(1)
        for col = 1:size_current_frame(2)
            % map the position to our histogram
            [binR,binG,binB] = scaling(current_frame,row,col);
            gray_video(row,col,1,frame) = hist(binR,binG,binB);
        end
    end
end

% save video to file and play
video_output = VideoWriter('output.avi'); 
open(video_output);
brighten = 1000/255;
for i=1:video_input.NumFrames
    writeVideo(video_output,gray_video(:,:,:,i)/1000 * brighten);
end
close(video_output);
implay('output.avi');