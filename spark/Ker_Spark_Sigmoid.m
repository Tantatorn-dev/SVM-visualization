function Y=Ker_Spark_Sigmoid(X1,X2)
global kappa1 kappa2
Sigmoid = @(A, B) (kappa1*(A*B) + kappa2);
Y = Multiplication_by_Column_unb(X1,X2, Sigmoid);
return