function Plot_ABC(A, B, C)
p = size(A,1); %numper of partitions
n = size(A,2); % number of inputs

x = 0:0.01:12;
for i = 1:n
    figure; 
    for j = 1:p        
        y = trimf(x,[A(j,i),B(j,i),C(j,i)]);  
        plot(x,y);
        hold on
    end        
end
