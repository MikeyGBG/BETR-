I=imread('domino.jpg');
lab=uint8(rgb2lab(I));
L=lab(:,:,1);

%blur the image
blur=imgaussfilt(L);

edges=edge(blur,'canny');%find the edges
[H,Thetas,Rhos]=hough(edges); %returns H-matrix, and theta/rho values defining
nlines=size(Thetas);
nlines=nlines(2);
intersects=zeros([nlines,2]);% number of intersects:=nlines!
for i=1:nlines;
    theta1=Thetas(i);
    rho1=Rhos(i);
    for j=(i+1):nlines
        theta2=Thetas(j);
        rho2=Thetas(j);
        [x,y]=lineintersects(rho1,rho2,theta1,theta2);
        intersects(i+j-3,:)=[x,y];
        plot(x,y);
    end
end
    
%rho = x*cos(theta) + y*sin(theta)->y=x*cot(theta)+ rho*csc(theta)
%lines=houghlines(edges);
imshow(edges);
imshow(lines);