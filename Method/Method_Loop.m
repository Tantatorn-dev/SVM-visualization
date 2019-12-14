function Y = Method_Loop(X1, X2, func)
Y = zeros(size(X1, 1), size(X2, 1));
for i = 1 : size(X1, 1)
    for j = 1 : size(X2, 1)
        Y(i, j) = func(X1(i, :), X2(j, :)');
    end
end
return