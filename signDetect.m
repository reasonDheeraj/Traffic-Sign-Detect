

close all;
I=imread('data.png');
II=rgb2gray(I);


level=graythresh(II);
originalBW=im2bw(II,level);
figure;
imshow(originalBW);
BW2 = bwareafilt(originalBW,20);
imshow(BW2);
[labeledImage numberOfObjects] = bwlabel(BW2);
blobMeasurements = regionprops(labeledImage,...
	'Perimeter', 'Area', 'FilledArea', 'Solidity', 'Centroid');
perimeters = [blobMeasurements.Perimeter];
areas = [blobMeasurements.Area];
filledAreas = [blobMeasurements.FilledArea];
solidities = [blobMeasurements.Solidity];
% Calculate circularities:
circularities = perimeters .^2 ./ (4 * pi * filledAreas);


boundaries = bwboundaries(BW2);

for blobNumber = 1 : numberOfObjects
    
	hold on;
	thisBoundary = boundaries{blobNumber};
	
	
	% Determine the shape.
	if circularities(blobNumber) < 1.2
		shape = 'circle';
        plot(thisBoundary(:,2), thisBoundary(:,1), 'r', 'LineWidth', 3);
    elseif circularities(blobNumber) < 1.6
		shape = 'square';
        plot(thisBoundary(:,2), thisBoundary(:,1), 'g', 'LineWidth', 3);
	elseif circularities(blobNumber) > 1.6 && circularities(blobNumber) < 1.8
		shape = 'triangle';
        plot(thisBoundary(:,2), thisBoundary(:,1), 'b', 'LineWidth', 3);
	else
		shape = 'something else';
    end
end



