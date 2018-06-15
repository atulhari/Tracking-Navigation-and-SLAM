%% Function to estimate X estimate and Error covariance matrix 
function [x_e,C_e]= estimator(theta,sd,C_x)

global mu_x;

global x_0;

H=[sin(theta) -cos(theta)]; % H matrix 
C_v=sd^2; %Covariance matrix
K=C_x*H'/(H*C_x*H'+C_v);% Kalman gain
z=H*x_0; %measurement
x_e=mu_x+K*(z-H*mu_x);%unbiased linear mmse
C_e=inv(inv(C_x)+H'*(1/(C_v))*H);%error covariance 
 
end