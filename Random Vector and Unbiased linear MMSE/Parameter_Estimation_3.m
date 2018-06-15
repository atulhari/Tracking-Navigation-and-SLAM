
%%Initialisation 
clear

global mu_x;

global x_0;

mu_x=[10;20]; %mean of measurements 
C_x=[61.5  -18; % Covariance matrix of measurement 
     -18   51];

%%
% calcultaing eigen values 

%% funtion 
figure (1);
x1=ellipse_plot(mu_x,C_x); % Function to calculate points on the ellipse 
plot(x1(:,1),x1(:,2));% plottimg Uncertainity ellipse for initial conditions 
hold on; 

%% unbiased linear MMSE estimation 

x_0=[190; 185];%Given initial position 
theta= degtorad(37); %Compass  measurement  
sd=2; % standard deviation of measurement noise
mean_n=0; %mean of measurement noise

%%% Unbiased Linear estimation based on theta,std. dev and C_x
[x_ulmmse,C_e]=estimator(theta,sd,C_x); % estimator function 

%% Plotting estimation error uncertainity ellipse

x=ellipse_plot(x_ulmmse,C_e);%calculating points on ellipse for error estimates 
plot(x(:,1),x(:,2));% plotting the estimation error ellipse 
hold off;
xlabel('x');
ylabel('y');
legend('Uncertainity of Prior ','Uncertainity of estimation')
title('Uncertainity Ellipse for prior and estimtion');

%%  Uncertainity ellipse for varying std. dev of measurement noise
figure(4);

for i=1:5 % Different values of uncertainity
   
    [x_ulmmse1,C_e1]=estimator(theta,i,C_x); %estimator function 
    h=ellipse_plot(x_ulmmse1,C_e1); 
    k(i)=plot(h(:,1),h(:,2)); %plotting uncertainity ellipse 
    hold on;
    A{i}=['\sigma_v= ',num2str(i)]; %For the legend 
   
end
    legend(k,A); %legend 
    xlabel('x');
    ylabel('y');
    title('Uncertainity Ellipse for varying standard deviation');
   
    hold off;
 
 %% Uncertainity ellipse for varying C_x
 
 figure(6);

for i=1:5
    
    [x_ulmmse2,C_e2]=estimator(theta,sd,i*C_x); %estimator function 
    h1=ellipse_plot(x_ulmmse1,C_e2);
    p(i)=plot(h1(:,1),h1(:,2)); % plotting uncertainity ellipse 
    hold on;
    B{i}=['C_x= ',num2str(i),'C_x']; %for the legend 
   
end
    legend(p,B); %legend 
    xlabel('x');
    ylabel('y');
    title('Uncertainity Ellipse for varying \alpha, for \alpha C_x');
    hold off;
 