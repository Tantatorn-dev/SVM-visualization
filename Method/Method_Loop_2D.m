function C = Method_Loop_2D(X1, X2, func)
C = zeros(size(X1, 1), size(X2, 1));
for i = 1 : size(X1, 1)
    X = X1(i, :);
    for j = 1 : size(X2, 1)
        C(i, j) = func(X, X2(j, :)');
    end
end
return