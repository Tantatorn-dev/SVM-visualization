function C = Method_Loop_1D_Col(X1, X2, func)
C = zeros(size(X1, 1), size(X2, 1));
for i = 1 : size(X2, 1)
    C(:, i) = func(X1, X2(i, :)');
end
return