function [A, B, C] = create_ABC(Range,P)
%      n1  n2   n3  
% A=[[   1.2  ,  1.1 ,  0.8 ]; % a in fuzzy label 1
%    [   1.2  ,  1.1 ,  0.8 ]; % a in fuzzy label 2
%    [   1.35 ,  1.2 ,  0.85 ]  % a in fuzzy label 3
%   ];
% B=[[  1.2  ,  1.1 ,  0.8 ];  % b in fuzzy label 1
%    [  1.35 ,  1.2 ,  0.85 ];  % b in fuzzy label 2
%    [  1.5  ,  1.3 ,  0.9 ]   % b in fuzzy label 3
%   ];
% C=[[   1.35 ,  1.2 ,  0.85 ]; % c in fuzzy label 1
%    [   1.5  ,  1.3 ,  0.9 ]; % c in fuzzy label 2
%    [   1.5  ,  1.3 ,  0.9 ]  % c in fuzzy label 3
%   ];

%     Range   Matrix(n*2) ==>   n-> input number,  2-->[lower_bound, upper_bound]
%     P       scaler      ==>   number of partitions in each input
    n = size(Range,1);
    A = zeros(P,n);
    B = A;
    C = A;
    
    for i= 1:n
        L = Range(i,1);
        U = Range(i,2);
        M = (L+U)/2;
        A(1:P,i)=[L;L;M];
        B(1:P,i)=[L;M;U];
        C(1:P,i)=[M;U;U];
    end