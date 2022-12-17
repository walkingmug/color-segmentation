# Color-Based Segmentation

## Description

Performs automatic segmentation on videos based on color. Works by categorizing the RGB colors of a video into 8 bins of a 3-dimensional RGB color histogram, resulting in a grayscale segmented video. Requires the subject to be selected by the user.

![segmentation](https://user-images.githubusercontent.com/29484054/208251289-0fc5fd49-9f12-40c7-bec9-bdfec43a7304.gif)


[View source](https://flic.kr/p/nPx5W4)

## Getting Started

### Dependencies

* Developed with MATLAB R2022b.

### Executing program

1. Put the video source in the same directory as the main file. To test with the original file, [download it from here](https://flic.kr/p/nPx5W4) .
2. Run the file 'segmentation.m'
3. Mark 4 rectangular points of the object to be segmented using sequence: top left -> top right -> bottom right -> bottom left.
E.g.:
![markings](https://user-images.githubusercontent.com/29484054/208250790-2fd1c20e-007d-47f7-b0ba-b0a8e34c5fd2.png)

4. The video result is saved in the same directory.

### Changing the data
* A video other than the default one can be segmented by changing the source file:
```
% read the video
video = VideoReader('360p.mp4');
```

## Version History
* 0.1
    * Initial Release
