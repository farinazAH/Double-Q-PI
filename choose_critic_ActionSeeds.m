function [critic_ActionSeeds critic_q] = choose_critic_ActionSeeds(critic_LocalActionList,critic_q)

    TempQ = critic_q+rand(size(critic_q,1),size(critic_q,2)).*0.00001;     
    for j = 1:size(TempQ,2)
        [ValueStar ActionStar] = max(TempQ(:,j));          
        critic_ActionSeeds(j) = critic_LocalActionList(ActionStar,j);
        critic_q(:,j) = critic_q(ActionStar,j);      
    end
   
end