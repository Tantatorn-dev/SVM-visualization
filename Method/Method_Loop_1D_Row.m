function C = Method_Loop_1D_Row(X1, X2, func)
C = zeros(size(X1, 1), size(X2, 1));
x2 = X2';
for i = 1 : size(X1, 1)
    C(i, :) = func(X1(i, :), x2);
end
return