function [flag_AB, local_a,  local_q, local_ind_aq, e] = EpsGreedyLocalActSelection(ruleAlphas, a, Q_A, Q_B, e, Eps, gama)   
    lambda = 0.9;      
    local_a = zeros(3,size(a,2));
    local_q = zeros(1,size(a,2));
    local_ind_aq = zeros(1,size(a,2));
    e = e * lambda * gama;
    Q = (Q_A + Q_B) ./ 2;
    TempQ = Q + rand(size(Q,1),size(Q,2)).*0.00001;   
    for j = 1:size(TempQ,2)
        [ValueStar, ActionStar] = max(TempQ(:,j));    
        if rand < Eps
            i = randi([1,size(a,1)]);
            local_a(:,j) = a{i,j};
            local_q(j) = Q(i,j);
            local_ind_aq(j) = i;
            e(i,j) = e(i,j) + ruleAlphas(j);
        else
            local_a(:,j) = a{ActionStar,j};
            local_q(j) = Q(ActionStar,j);
            local_ind_aq(j) = ActionStar;
            e(ActionStar,j) = e(ActionStar,j) + ruleAlphas(j);
        end
    end
    if rand > 0.5
    	flag_AB = 'A';
    else 
        flag_AB = 'B';
    end
    
end
    