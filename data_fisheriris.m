%Fisher Iris data
%load fisheriris
inputs=[1 2; 3 4; 5 6;];
outputs=[1;1;-1];

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

