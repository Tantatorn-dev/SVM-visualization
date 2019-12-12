function [out] = Algo_Select(mode, kernel)
%Algo_Select Select what function of algorithm will use
%   Detailed explanation goes here
addpath('./loop/');
addpath('./spark/');
addpath('./FLA/');
switch mode
    case {'Spark', 'SPARK'}
        switch kernel
            case 'Linear'
                func = @Ker_Spark_Linear;
            case 'Polynomial'
                func = @Ker_Spark_Polynomial;
            case 'RBF'
                func = @Ker_Spark_RBF;
            case 'Sigmoid'
                func = @Ker_Spark_Sigmoid;
            otherwise
                error('Do not have select kernal in this select mode')
        end
    case {'Loop', 'Normal'}
        switch kernel
            case 'Linear'
                func = @Ker_Loop_Linear;
            case 'Polynomial'
                func = @Ker_Loop_Polynomial;
            case 'RBF'
                func = @Ker_Loop_RBF;
            case 'Sigmoid'
                func = @Ker_Loop_Sigmoid;
            otherwise
                error('Do not have select kernal in this select mode')
        end
    otherwise
        error('Do not have select mode')
end

out = struct('func', func, 'mode', mode, 'name', kernel);
end

