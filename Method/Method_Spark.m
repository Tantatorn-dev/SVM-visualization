
% Copyright 2019 The University of Texas at Austin
%
% For licensing information see
%                http://www.cs.utexas.edu/users/flame/license.html 
%                                                                                 
% Programmed by: Phumpathai Chansriwong
%                ouoam2555@gmail.com

function [ C_out ] = Method_Spark( A, B, func )
%------------------------------------------------------------%
%
% B is transpose then use top to bottom 
%
  C = zeros(size(A, 1), size(B, 1)); %Gram Matrix
%------------------------------------------------------------%

  [ BT, ...
    BB ] = FLA_Part_2x1( B, ...
                         0, 'FLA_TOP' );

  [ CL, CR ] = FLA_Part_1x2( C, ...
                               0, 'FLA_LEFT' );

  while ( size( BT, 1 ) < size( B, 1 ) )

    [ B0, ...
      b1t, ...
      B2 ] = FLA_Repart_2x1_to_3x1( BT, ...
                                    BB, ...
                                    1, 'FLA_BOTTOM' );

    [ C0, c1, C2 ] = FLA_Repart_1x2_to_1x3( CL, CR, ...
                                         1, 'FLA_RIGHT' );

    %------------------------------------------------------------%

    c1 = func(A, b1t');

    %------------------------------------------------------------%

    [ BT, ...
      BB ] = FLA_Cont_with_3x1_to_2x1( B0, ...
                                       b1t, ...
                                       B2, ...
                                       'FLA_TOP' );

    [ CL, CR ] = FLA_Cont_with_1x3_to_1x2( C0, c1, C2, ...
                                           'FLA_LEFT' );

  end

  C_out = [ CL, CR ];

return
