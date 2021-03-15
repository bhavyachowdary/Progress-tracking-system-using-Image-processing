i1  = imread('1a.png');   
original = rgb2gray(i1);   
i2 = imread('1.png');   
distorted = rgb2gray(i2);
ptsOriginal  = detectSURFFeatures(original); 
ptsDistorted = detectSURFFeatures(distorted); 
[featuresIn   validPtsIn]  = extractFeatures(original, ptsOriginal); 
[featuresOut   validPtsOut]  = extractFeatures(distorted, ptsDistorted);
index_pairs = matchFeatures(featuresIn, featuresOut); 
matchedOriginal  = validPtsIn(index_pairs(:,1)).Location;
matchedDistorted = validPtsOut(index_pairs(:,2)).Location;
gte = vision.GeometricTransformEstimator;
gte.Transform = 'Affine';
gte.NumRandomSamplingsMethod = 'Desired confidence';
gte.MaximumRandomSamples =50000;
gte.DesiredConfidence = 99.8;

[tform_matrix inlierIdx] = step(gte, matchedDistorted,matchedOriginal);
h1 = cvexShowMatches(original,distorted,matchedOriginal(inlierIdx,:),matchedDistorted(inlierIdx,:),'ptsOriginal','ptsDistorted');

agt = vision.GeometricTransformer;
agt.OutputImagePositionSource = 'Auto';

recovered = step(agt, im2single(distorted), tform_matrix);
figure;
subplot(1,2,1); imshow(original); title('original')
subplot(1,2,2); imshow(recovered); title('recovered')