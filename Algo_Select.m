function [out] = Algo_Select(mode, kernel)
%Algo_Select Select what function of algorithm will use
%   Detailed explanation goes here
addpath('./Method/');
addpath('./Kernel/');
addpath('./FLA/');

switch mode
    case 'Normal'
        Mode = @Method_Normal;
    case 'Loop 1D Col'
        Mode = @Method_Loop_1D_Col;
    case 'Loop 1D Row'
        Mode = @Method_Loop_1D_Row;
    case 'Loop 2D'
        Mode = @Method_Loop_2D;
    case 'Spark Col'
        Mode = @Method_Spark_Col;
    case 'Spark Row'
        Mode = @Method_Spark_Row;
    otherwise
        error('Do not have select mode')
end

switch kernel
    case 'Linear'
        Kernel = @Ker_Linear;
    case 'Polynomial'
        Kernel = @Ker_Polynomial;
    case 'RBF'
        Kernel = @Ker_RBF;
    case 'Sigmoid'
        Kernel = @Ker_Sigmoid;
    otherwise
        error('Do not have select kernal in this select mode')
end

func = @(A, B) Mode(A, B, Kernel);

out = struct('func', func, 'mode', mode, 'name', kernel);
end

