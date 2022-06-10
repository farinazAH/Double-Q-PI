function ruleTable = Create_FIS_Rule_Table(A, B, C)
%%
% suppose we have the same partitions for each input
% example for A, B, C
% % a paremeter for each trimf MF in each rule
% A=[[  -4 , -3  ];
%    [  -2 , -2  ];
%    [  -1 , -1  ];
%    [   0 ,  0  ];
%    [   1 ,  1  ]
%   ];
%%

%%
p = size(A,1); %numper of partitions
n = size(A,2); % number of inputs
%%
for i=1:p       
        Ps(i)=i;              
end
%creating rule Table use grid partitioning 
%we should repeate Ps parameter for the number of number of inputs(n)
if n == 2
    ruleTable = allcomb(Ps, Ps);
else if n == 3
        ruleTable = allcomb(Ps, Ps, Ps);
    else if n == 4
            ruleTable = allcomb(Ps, Ps, Ps, Ps);
        else if n == 5
                ruleTable = allcomb(Ps, Ps, Ps, Ps, Ps);
            else if n == 6
                    ruleTable = allcomb(Ps, Ps, Ps, Ps, Ps, Ps);
                else if n == 7
                        ruleTable = allcomb(Ps, Ps, Ps, Ps, Ps, Ps, Ps);
                    else
                        ruleTable = allcomb(Ps, Ps, Ps, Ps, Ps, Ps, Ps, Ps);
                    end
                end
            end
        end
    end
end

%%





