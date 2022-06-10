function [local_a  local_q] = maxActSelectection(a, Q_1, Q_2)    
    local_a = zeros(3,size(a,2));
    local_q = zeros(1,size(a,2));
    TempQ = Q_1 + rand(size(Q_1,1),size(Q_1,2)).*0.00001; 
    for j = 1:size(TempQ,2)
        [ValueStar ActionStar] = max(TempQ(:,j));          
        local_a(:,j) = a{ActionStar,j};
        local_q(j) = Q_2(ActionStar,j);      
    end
   
end
    