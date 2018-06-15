
%%Initialisation
clear
load log.mat

%% Initialization
F1=[0.97,0;0,0.97]; %% Given value of F1
Cw_1=[0.0016,0;0,0.0016];%% Given value of process noise
Cn=[49 0; 0 49];%% Given value of measrement noise

F = [eye(2) , eye(2) , zeros(2) ;
    zeros(2) , eye(2) , eye(2) ;
    zeros(2) , zeros(2) , F1] ; %% F matrix

Cw = [ zeros(4) , zeros(4,2) ;
    zeros(2,4) , Cw_1 ] ;
Cx=zeros(6,6,100); % Initializing covariance matrix into a 3d time variant form

Cx1=[100^2 0 0 0 0 0;
    0 100^2 0 0 0 0;
    0 0 4^2 0 0 0;
    0 0 0 4^2 0 0;
    0 0 0 0 0.2^2 0;
    0 0 0 0 0 0.2^2];% given
Cx(:,:,1)=Cx1; %Assigning the first timestep value as cx1
xPredicted=zeros(6,1,100); %Expectation of the initial pdf x_hat(0|-1) since mean of x(0)=0
xPredicted(:,:,1)=zeros(6,1,1); %Assigning the first timestep value as 0
xUpdate=zeros(6,1,100);  % Initialization
cUpdate=zeros(6,6,100);% Initialization
%%

load zradar.mat %load the data


H=[eye(2),zeros(2,4)]; %Measurement matrix
for i=1:100
    
    
    S=H*Cx(:,:,i)*H' + Cn; %Innovation matrix
    K=Cx(:,:,i)*H'*(S)^-1; %Kalman Gain matrix
    xUpdate(:,:,i)=xPredicted(:,:,i)+K*(z(:,i)-H*xPredicted(:,:,i));% update of x
    cUpdate(:,:,i)=Cx(:,:,i)-K*S*K';% covariance update
    xPredicted(:,:,i+1)=F*xUpdate(:,:,i);% prediction of x
    Cx(:,:,i+1)=F*cUpdate(:,:,i)*F'+Cw;% prediction of Cx
end

%%
figure;
scatter(z(1,:),z(2,:),'.','r');
hold on;
for i=1:100
    xU(:,i)=xUpdate(:,:,i); %Converting 3d matrix to 2d
    xP(:,i)= xPredicted(:,:,i);
    
end
scatter(xU(1,:),xU(2,:),'.','b'); %% scatter plot of update
scatter(xP(1,:),xP(2,:),'.','g')%% scatter plot of prediction
%
%
for i=1:4:length(z)
    mu_xp=xP(1:2,i);
    ellipse1=ellipse_plot(mu_xp,Cx(1:2,1:2,i)); % call function for plotting the uncertainty region
    plot(ellipse1(:,1),ellipse1(:,2));%plotting the uncertainty region
    
end
hold off;
title('Measurement, Update and prediction')
legend('measurement','Updated ','Predicted')

figure;
scatter(1:length(z),z(1,:),'.','r'); %% scater plot wrto. time step
hold on;
scatter(1:length(xU),xU(1,:),'.','b');
scatter(1:length(xP),xP(1,:),'.','g');
hold off;
title('Measurement, Update and prediction')
legend('measurement','Updated ','Predicted')


figure;
scatter(1:length(z),z(2,:),'.','r');%% scater plot wrto. time step
hold on;
scatter(1:length(xU),xU(2,:),'.','b');
scatter(1:length(xP),xP(2,:),'.','g');
hold off;
title('Measurement, Update and prediction')
legend('measurement','Updated ','Predicted')

%%

[K,Cpred,Cerr] = dlqe(F,eye(6),H,Cw,Cn);%% steady state values obtained using dlqe


for i=1:100 %% Using time invariant prediction
    xUpdate(:,:,i)=xPredicted(:,:,i)+K*(z(:,i)-H*xPredicted(:,:,i));
    xPredicted(:,:,i+1)=F*xUpdate(:,:,i);
    Cx(:,:,i+1)=Cpred;
end
figure(1)
scatter(z(1,:),z(2,:),'.','r');
hold on;
for i=1:100
    xU(:,i)=xUpdate(:,:,i);
    xP(:,i)= xPredicted(:,:,i);
    
end
scatter(xU(1,:),xU(2,:),'.','b');
scatter(xP(1,:),xP(2,:),'.','g')


for i=1:4:length(z)
    mu_xp=xP(1:2,i);
    ellipse1=ellipse_plot(mu_xp,Cx(1:2,1:2,i)); % call function for plotting the uncertainty region
    plot(ellipse1(:,1),ellipse1(:,2));%plotting the uncertainty region
    
end
hold off;
title('Measurement, Update and prediction')
legend('measurement','Updated ','Predicted')

figure;
scatter(1:length(z),z(1,:),'.','r'); %% scater plot wrto. time step
hold on;
scatter(1:length(xU),xU(1,:),'.','b');%% scater plot wrto. time step
scatter(1:length(xP),xP(1,:),'.','g');%% scater plot wrto. time step
hold off;
title('Measurement, Update and prediction')
legend('measurement','Updated ','Predicted')


figure;
scatter(1:length(z),z(2,:),'.','r');%% scater plot wrto. time step
hold on;
scatter(1:length(xU),xU(2,:),'.','b');%% scater plot wrto. time step
scatter(1:length(xP),xP(2,:),'.','g');%% scater plot wrto. time step
hold off;
title('Measurement, Update and prediction')
legend('measurement','Updated ','Predicted')