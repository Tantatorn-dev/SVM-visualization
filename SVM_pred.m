%Dec15,2018
%SVM prediction
function Y_new = SVM_pred(X_new, X, Y, kernel, alpha, beta0)
% X is N*p
% X_new is new data with M*p, alpha is vector with N*1, beta0 is scalar

M = size(X_new, 1);
Ker = kernel.func(X, X_new);
Y_new = sum(diag(alpha.*Y) * Ker, 1)' + beta0 * ones(M, 1);

return
