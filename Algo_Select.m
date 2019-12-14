function [out] = Algo_Select(mode, kernel)
%Algo_Select Select what function of algorithm will use
%   Detailed explanation goes here
addpath('./Method/');
addpath('./Kernel/');
addpath('./FLA/');

switch mode
    case 'Loop 1D'
        Mode = @Method_Loop_1D;
    case 'Loop 2D'
        Mode = @Method_Loop_2D;
    case 'Spark'
        Mode = @Method_Spark;
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

