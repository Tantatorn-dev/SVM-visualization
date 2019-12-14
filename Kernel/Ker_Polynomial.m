function Y = Ker_Polynomial( A, B )
global poly_con

Y = (1 + (A * B)).^poly_con;
return