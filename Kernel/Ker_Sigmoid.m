function Y = Ker_Sigmoid( A, B )
global kappa1 kappa2

Y = kappa1 * (A * B) + kappa2;
return