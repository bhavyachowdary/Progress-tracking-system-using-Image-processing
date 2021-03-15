
oq=imread('1.png');
odprz=imresize(oq,[300 300]);
imwrite(odprz,'1.png');

sw=imread('1a.png');
stprz=imresize(sw,[300 300]);
imwrite(stprz,'1a.png');

pic1 = imread('1.png');    
pic2 = imread('1a.png');

[x,y,z] = size(pic1);
if(z==1)
     ;
else
    pic1 = rgb2gray(pic1);
end
[x,y,z] = size(pic2);
if(z==1)
    ;
else
    pic2 = rgb2gray(pic2);
end

%applying edge detection on first picture
%so that we obtain white and black points and edges of the objects present
%in the picture.

edge_det_pic1 = edge(pic1,'canny');
figure;
imshow(edge_det_pic1);
%%applying edge detection on second picture
%so that we obtain white and black points and edges of the objects present
%in the picture.

edge_det_pic2 = edge(pic2,'canny');
figure;
imshow(edge_det_pic2);
%definition of different variables to be used in the code below


%initialization of different variables used
matched_data = 0;
matched_data1 = 0;
white_points = 0;
black_points = 0;
x=0;
y=0;
l=0;
m=0;

%for loop used for detecting black and white points in the picture.
for a = 1:1:256
    for b = 1:1:256
        if(edge_det_pic1(a,b)==1)
            white_points = white_points+1;
        else
            black_points = black_points+1;
        end
    end
end

%for loop comparing the white (edge points) in the two pictures
figure;
imshow(oq);
hold on;
for i = 1:1:256
    for j = 1:1:256
        if(edge_det_pic1(i,j)==1)&(edge_det_pic2(i,j)==1)
            plot(i,j,'g.');
            else
          matched_data1 = matched_data1+1;
        end
    end
end
%calculating percentage matching.
total_data = white_points;
total_matched_percentage = (matched_data/total_data)*100;

om=min(odprz);
sm=min(stprz);

if om==255
    total_matched_percentage=0;
elseif sm==255
    total_matched_percentage=0;
end

disp(total_matched_percentage)

disp('process completed')