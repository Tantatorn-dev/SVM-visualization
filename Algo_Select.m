function [func] = Algo_Select(mode, kernel)
%Algo_Select Select what function of algorithm will use
%   Detailed explanation goes here
switch mode
    case 'Spark'
        switch kernel
            case 'Linear'
                func = Ker_Spark_Linear;
            case 'Polynomial'
                func = Ker_Spark_Polynomia;
            case 'RBF'
                func = Ker_RBF;
            case 'Sigmoid'
                func = Ker_Spark_Sigmoid;
        end
    case 'Loop'
        switch kernel
            case 'Linear'
                func = Ker_Loop_Linear;
            case 'Polynomial'
                func = Ker_Loop_Polynomia;
            case 'RBF'
                func = Ker_RBF;
            case 'Sigmoid'
                func = Ker_Loop_Sigmoid;
        end
end
end

