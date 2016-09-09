function [x,y]= lineintersects(rho1,rho2,theta1,theta2)
x=(rho2*sin(theta1)-rho1*sin(theta2))/(cos(theta1)*sin(theta2)-cos(theta2)*sin(theta1));

y=-x/tan(theta1)+rho1*sin(theta1);
disp(y)
if isnan(y)
    y=-x/tan(theta2)+rho2*sin(theta2);
end
end
