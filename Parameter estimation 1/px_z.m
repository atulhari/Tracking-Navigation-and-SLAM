
%% Function to find the conditional probability of x when z is given 
function ret= px_z(x,z)

ret=pz_x(z,x).*px(x)./pz(z);%Bayes theorm
return
end
