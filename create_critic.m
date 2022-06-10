function [critic_LocalActionList  critic_q] = create_critic(critic_ActionSeeds,a_cnt_half,learn_length)
    %---  critic_ActionSeeds =>   [p_seed, i_seed, d_seed] * rules
    a_cnt = a_cnt_half*2+1;
    
    critic_q = zeros(a_cnt^size(critic_ActionSeeds,1),size(critic_ActionSeeds,2));
   
    critic_Local_p = zeros(a_cnt,size(critic_ActionSeeds,2));
    critic_Local_i = zeros(a_cnt,size(critic_ActionSeeds,2));
    critic_Local_d = zeros(a_cnt,size(critic_ActionSeeds,2));
    
    critic_Local_p((a_cnt_half+1),:) = critic_ActionSeeds(1,:);
    critic_Local_i((a_cnt_half+1),:) = critic_ActionSeeds(2,:);
    critic_Local_d((a_cnt_half+1),:) = critic_ActionSeeds(3,:);
    
    i_end = a_cnt_half;
    percent = i_end*0.25;  
    
    for i=1:i_end        
        critic_Local_p(i,:) = critic_ActionSeeds(1,:) + learn_length*percent*(-1);
        critic_Local_p(2*i_end+2-i,:) = critic_ActionSeeds(1,:) + learn_length*percent;
        
        critic_Local_i(i,:) = critic_ActionSeeds(2,:) + learn_length*percent*(-1);
        critic_Local_i(2*i_end+2-i,:) = critic_ActionSeeds(2,:) + learn_length*percent;
        
        critic_Local_d(i,:) = critic_ActionSeeds(3,:) + learn_length*percent*(-1);
        critic_Local_d(2*i_end+2-i,:) = critic_ActionSeeds(3,:) + learn_length*percent;
        
        percent = percent - 0.25;
    end
    
    for i=1:size(critic_ActionSeeds,2)
        temp = allcomb(critic_Local_p(:,i)', critic_Local_i(:,i)', critic_Local_d(:,i)');
        critic_LocalActionList(:, i) = num2cell(temp, 2);
    end
    
end