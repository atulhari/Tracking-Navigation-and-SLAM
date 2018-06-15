%% Function to find points on ellipse 
function y= ellipse_plot(mu_x,C_x)
%global mu_x;
[v,lamda]=eig(C_x); % Calculating eigen values and eigen vector 
 a_m=sqrt(lamda); % square root of eigen values 
 a=linspace(0,2*pi,1000); % generating equidistant points
 x1=[a_m(1,1).*cos(a)',a_m(2,2).*sin(a)']; % Calculating points on ellipse using  
 % Aligning to the direction of eigen vectors,making mean_x as center 
 x=(v*x1')';

%plot(ellip_rot(:,1),ellip_rot(:,2))
 y=x+[mu_x(1)*ones(length(a),1),mu_x(2)*ones(length(a),1)]; %Scaling the ellipse in the direction of eigen vector
 
end