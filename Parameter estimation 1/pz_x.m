
%% Function to find the conditional probability of z when x is given 

function ret = pz_x(z,x)
    P_0= 0.55;
    P_1=1-P_0;
    sigma=0.1; %[m] 
    ret = P_0*normpdf(z,x,sigma)+P_1*normpdf(z,2*x,sigma);
return
end    