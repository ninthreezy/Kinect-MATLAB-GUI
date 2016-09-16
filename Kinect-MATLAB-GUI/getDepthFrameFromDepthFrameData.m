function [ depthFrame] = getDepthFrameFromDepthFrameData( depthFrameData, framenumber )
% This function takes in the depthFrameData that is generated with the
% MATLAB function:
% [depthFrameData,depthTimeData,depthMetaData] = getdata(depthVid);
% Where depthVid is in reference to a Microsoft Kinect, equal to:
% videoinput('kinect',2);

depthFrame = depthFrameData(:,:,framenumber);

end

