function [critic_q_A, critic_q_B] = Update_Double_Q(flag_AB, reward, Q_s_output, next_state_fire, critic_LocalActionList, critic_q_A, critic_q_B, e, gama, learning_rate)   
    
    if flag_AB == 'A'         
        [actor_params, critic_params_B] = maxActSelectection(critic_LocalActionList,critic_q_A, critic_q_B);                  
        Q_max_next_value = sum(next_state_fire.*critic_params_B);             
        
        TD_error = reward + gama * Q_max_next_value - Q_s_output;    
        delta_critic = learning_rate * TD_error * e;                  
        critic_q_A = critic_q_A + delta_critic;
    else       
        [actor_params, critic_params_A] = maxActSelectection(critic_LocalActionList,critic_q_B, critic_q_A);                  
        Q_max_next_value = sum(next_state_fire.*critic_params_A); 
        
        TD_error = reward + gama * Q_max_next_value - Q_s_output;    
        delta_critic = learning_rate * TD_error * e;                  
        critic_q_B = critic_q_B + delta_critic;
    end
   
    