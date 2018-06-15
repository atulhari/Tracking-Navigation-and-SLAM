
%%Initialisation
clear
load log.mat

%% Initialization
F1=[-0.0595,-0.1530;-0.0813,-0.1716];
Cw_1=[0.1177e-3,-0.0026e-3;-0.0026e-3,0.0782e-3];
for u=1:length(xsi)-1
    
    v(:,u)= xsi(:,u+1)- xsi(:,u);
    
end
for u=1:length(v)-1
    a(:,u)=v(:,u+1)-v(:,u);
end
x=[xsi(:,1:length(a));
    v(:,1:length(a));
    a(:,1:length(a))];
F = [eye(2) , eye(2) , zeros(2) ;
    zeros(2) , eye(2) , eye(2) ;
    zeros(2) , zeros(2) , F1] ;

Cw = [ zeros(4) , zeros(4,2) ;
    zeros(2,4) , Cw_1 ] ;
%%

i=10; %Current time^2
len=90; %Number of steps to predict
xPredicted(:,i+1)=x(:,i+1);
for j=(i+1)+1:(i+len)+1 %From state 11 till 100
    xPredicted(:,j)=F*xPredicted(:,j-1); %x(i+1)=Fx(i) Calcualtion of predicted state
    
end

%%

figure(1);
hold on
scatter(x(1,:),x(2,:)); %Scatter Plot of x

scatter(xPredicted(1,i+1:end),xPredicted(2,i+1:end),'.','r'); %Scatter Plot of x-predicted

title('Predicated path of the ship')
xlabel('x');
ylabel('y');
legend('x','x_{predicted}');


%%
cPredicted(:,:,i)=zeros(6); % Initial Covariance matrix for i=10;
for k=(i+1):(i+len)
    cPredicted(:,:,k)=F*cPredicted(:,:,k-1)*F'+Cw; %C_x(i+1)=F*C_X*F^T +Cw
    % end
    
    
    
    mu_x=xPredicted(1:2,k); %Prior knowledge for position
    
    ellipse_1= ellipse_plot(mu_x,cPredicted(1:2,1:2,k)); % call function for plotting the uncertainty region
    plot(ellipse_1(:,1),ellipse_1(:,2));%plotting the uncertainty region
end

hold off
legend('Position_{measurement}','position_{predicted}')

%% Considering various time and steps

time=[30,50,70,90]; % time vectors
step=[70,50,30,10]; %Steps for each time


for i=1:4
    cPredicted(:,:,time(i)+1)=zeros(6);
    xPredicted(:,time(i)+1)=x(:,time(i)+1);
    figure(i+1)
    scatter(x(1,:),x(2,:),'.','g');
    hold on
    scatter(xPredicted(1,time(i)+1:end),xPredicted(2,time(i)+1:end),'.','r');
    
    for j=(time(i)+1)+1:(time(i)+1)+step(i)
        xPredicted(:,j)=F*xPredicted(:,j-1);
        
        
        
        % Initial Covariance matrix for i=10;
        cPredicted(:,:,j)=F*cPredicted(:,:,j-1)*F'+Cw; %C_x(i+1)=F*C_X*F^T +Cw
        
        
        
        mu_x1=xPredicted(1:2,j); %Prior knowledge for position
        ellipse2=ellipse_plot(mu_x1,cPredicted(1:2,1:2,j)); % call function for plotting the uncertainty region
        plot(ellipse2(:,1),ellipse2(:,2));%plotting the uncertainty region
        A=['Prediction of step ',num2str(step(i)),' for time ',num2str(time(i))];
        title(A);
        
    end
    
    hold off
end

