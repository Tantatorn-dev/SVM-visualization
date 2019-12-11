function Y=Ker_Spark_Linear(X1,X2)

Linear = @(A, B) A*B;
Y = Multiplication_by_Column_unb(X1,X2, Linear);
return