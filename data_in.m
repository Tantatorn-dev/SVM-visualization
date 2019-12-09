%Fisher Iris data
%load fisheriris
inputs=[1 0; 2 0; 0.4 0.2; 0 2;1 0.5; 2 1; 0.5 1; 1 1];
outputs=[1;1;-1;-1;1;1;-1;-1];

%N=max(size(species));
%{
for i=1:N
    if strcmp(species(i),'setosa')
        inputs=[inputs;meas(i,1:2)];
        outputs=[outputs;1];
    elseif strcmp(species(i),'versicolor')
        inputs=[inputs;meas(i,1:2)];
        outputs=[outputs;-1];
    end
end
%}

