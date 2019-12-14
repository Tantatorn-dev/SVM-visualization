function Y = Ker_RBF( A, B )
global gamma

C = A-(B');
Y = exp(-gamma * (C(:, 1).^2 + C(:, 2).^2));
return