%% Exercise 1 | Atul Hari | S2005921

 x=linspace(0,5,1000);% defining the scales of x 
 z=linspace(0,5,1000);% defining the scales of z

 global xrange;
 xrange = x;
 
figure (1);


c=1500; % [m/s]  speed of sound in water 
ToF1=2*x/c;

for i=1:length(z)
    a(i)=pz_x(z(i),1) ;% probability of z given x for x=1
    b(i)=pz_x(z(i),2);% probability of z given x for x=2
    
end
plot (z,a);
hold on;
plot(z,b);
hold off;
legend('x=1m','x=2m') 
xlabel('z');
ylabel('p(z|x)');

title('Conditional probability of z');
%%

figure (2);

 % function pz(z) gives the probability of z
 for i=1:length(z)
      y(i)=pz(z(i));

 end      
      plot(z,y);
title('probability of z'); 
xlabel('x');
ylabel('p(z)');
figure (3);
for i=1:length(x)  
  c(i)=px_z(x(i),2.9);% probability of x given z for z=2.9
  d(i)=px_z(x(i),4);  % probability of x given z for z=4 
end  
  plot(x,c);
     hold on;
     plot(x,d);   
  
title('conditional  probability of x given z (Bayes Theorem)');
legend('z=2.9m','z=4m') 
xlabel('x');
ylabel('p(x|z)');

hold off;
%%

   

    [mse1,map1,mae1,ml1]=estimate(x,2.9);
    % calculating estimates map,mse,mae for z=2.9
    [mse2,map2,mae2,ml2]=estimate(x,4);  
    % calculating estimates map,mse,mae for z=4
 x_a=[mse1,map1,mae1,ml1];%Estimates with z=2.9
 x_b=[mse2,map2,mae2,ml2];%Estimates with z=4
%% Question 4
[mse,map,mae,ml]=estimate(x,z);

   x=linspace(1,3,1000);
   for i=1:4
        R1(i)=sum((x_a(i)-x).^2.* px_z(x,z))*(xrange(2)-xrange(1));
        %conditional risk for z=2.9,[Rmse,Rmap,Rmae,Rml] 
        R2(i)=sum((x_b(i)-x).^2.* px_z(x,z))*(xrange(2)-xrange(1));
        %conditional risk for z=4,[Rmse,Rmap,Rmae,Rml]

   end


