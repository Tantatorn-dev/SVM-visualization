function Y=Ker_Spark_RBF(X1,X2)
Y = Multiplication_by_Column_unb(X1,X2, @RPB);
return

function out = RPB(A, B)
    global gamma
    C = A-(B');
    out = exp(-gamma * (C(:,1).^2 + C(:,2).^2));
return