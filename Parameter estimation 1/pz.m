% probability of z
function ret=pz(z)
 global xrange; 
ret = sum(px(xrange).*pz_x(z,xrange))*(xrange(2)-xrange(1));
return

end

