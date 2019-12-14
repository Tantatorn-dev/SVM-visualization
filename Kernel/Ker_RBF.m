function Y = Ker_RBF( A, B )
global gamma

C = A-(B');
Y = exp(-gamma * (C(:, 1).^2 + C(:, 2).^2));
if (size(B, 2) > size(A, 2))
    Y = Y';
end
return