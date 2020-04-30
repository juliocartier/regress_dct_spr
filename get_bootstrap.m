function [ blo, bli] = get_bootstrap( lambda, error)

ci = bootci(1000, {@var, lambda}, 'alpha', error, 'type','student');

blo = ci(1);
bli = ci(2);

% Aplicação do Bootstrap

% n = length(lambda);
%alpha = 0.1;
% B = 1000;
% thetahat = var(lambda);
%  
% [bootreps, bootsam] = bootstrp(B,'var', lambda);
% %bvals = bootstrp(B,'var',lambda);
%  
% for i = 1:B
% 
% xstar = lambda(bootsam(:,i));
% bvals(i) = var(xstar);
% 
% sehats(i) = std(bootstrp(5,'var',xstar));
% end
% 
% zvals = (bootreps - thetahat)./sehats';
% 
% SE = std(bootreps);
% 
% k = B*error/2;
% szval = sort(zvals);
% tlo = szval(k);
% thi = szval(B-k);
% % Get the endpoints of the interval.
% blo = thetahat - thi*SE;
% bhi = thetahat - tlo*SE;

% k = B*error/2;
% 
% sbval = sort(bvals);
% blo = sbval(k);
% bhi = sbval(B-k);


end

