function Fire = Compute_Rule_Fires(state, A, B, C, ruleTable)
% example for A, B, C
% % a paremeter for each trimf MF in each rule
% A=[[  -4 , -3  ];
%    [  -2 , -2  ];
%    [  -1 , -1  ];
%    [   0 ,  0  ];
%    [   1 ,  1  ]
%   ];
% % b paremeter for each trimf MF in each rule
% B=[[ -2 , -2 ];
%    [ -1 , -1 ];
%    [  0 ,  0 ];
%    [  1 ,  1 ];
%    [  2 ,  2 ]
%   ];
% % c paremeter for each trimf MF in each rule
% C=[[  -1 , -1  ];
%    [   0 ,  0  ];
%    [   1 ,  1  ];
%    [   2 ,  2  ];
%    [   4 ,  3  ]
%   ];
%%
p = size(A,1); %numper of partitions
n = size(A,2); % number of inputs
m = p^n;
%%
alpha = ones(m,n);
Fire = zeros(0);
for i = 1:m
    for j = 1:n        
        alpha(i,j) = trimf(state(j),[A(ruleTable(i,j),j),B(ruleTable(i,j),j),C(ruleTable(i,j),j)]);   
    end    
    Fire(i) = min(alpha(i,:));
    % Fire(i)=alpha(i,1)*alpha(i,2);
end
%%
if  sum(Fire) ~= 0
    Fire = Fire / sum(Fire);
else
    Fire = zeros(size(Fire,1),size(Fire,2));
end 
