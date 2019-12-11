function Y=Ker_Spark_Polynomial(X1,X2)
global poly_con
Polynomial = @(A, B) (1+(A*B).^poly_con);
Y = Multiplication_by_Column_unb(X1,X2, Polynomial);
return