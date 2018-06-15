%% Function to find points on ellipse 
function x= ellipse_plot(mu_x,C_x)
%global mu_x;
[v,lamda]=eig(C_x); % Calculating eigen values and eigen vector 
 a_m=sqrt(lamda); % square root of eigen values 
 a=linspace(0,2*pi,100); % generating equidistant points
 x1=[a_m(1,1).*cos(a)',a_m(2,2).*sin(a)']; % Calculating points on ellipse using  
 % Aligning to the direction of eigen vectors,making mean_x as center 
 x=mu_x'+(v*x1')';
 
end