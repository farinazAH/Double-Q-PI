function [next_state, reward] = PID_Controller (state, set_points, K_vector, Time, dt, out_Low, out_upp)
%     dt   ---> sampling time
%     Time ---> total simulation time in seconds
    K_vector
    Kp = K_vector(1);             % proportional term Kp
    Ki = K_vector(2);             % Integral term Ki
    Kd = K_vector(3);             % derivative term Kd
   
    n = round(Time/dt); % number of samples    
    
    set_points_NO = size(set_points,1);
    
    depth_error = state;
    depth_FeedBack =  zeros(set_points_NO,n+1);
    
    % pre-assign all the arrays to optimize simulation time  
    Prop = zeros(set_points_NO,n+1);
    Der =  zeros(set_points_NO,n+1);
    Int =  zeros(set_points_NO,n+1);
    I = zeros(set_points_NO,n+1);
    PID =  zeros(set_points_NO,n+1);
    FeedBack =  zeros(set_points_NO,n+1);  
    Error = zeros(set_points_NO,n+1);
    
    for i = 1:n        
        Error(:,i+1) = set_points - FeedBack(:,i); % error entering the PID controller        
        Prop(:,i+1) = Error(:,i+1);% error of proportional term
        Der(:,i+1)  = (Error(:,i+1) - Error(:,i))/dt; % derivative of the error
        Int(:,i+1)  = (Error(:,i+1) + Error(:,i))*dt/2; % integration of the error
        I(:,i+1)    = sum(Int,2); % the sum of the integration of the error

        PID(:,i+1)  = Kp*Prop(:,i) + Ki*I(:,i+1)+ Kd*Der(:,i); % the three PID terms
          
        %---Normalize the output of the PID
        output = mapminmax([PID(:,i+1) repmat(out_Low,size(PID,1),1) repmat(out_upp,size(PID,1),1)], out_Low, out_upp); 
               
        PID(:,i+1) = output(:,1);
        
        %% The system/hardware/model feedback        
        depth_error = canal_simulator_step(PID(:,i+1), depth_error, n);            
    
        depth_FeedBack(:,i) = depth_error;
        FeedBack(:,i+1) = depth_error; 
 
    end
    next_state = FeedBack(:,i);
    %---compute reward    
    depth_Error_square = sum((set_points - depth_FeedBack(:,i)).^2);
    reward = -1. + 2*exp(-0.5*(depth_Error_square/0.25));
    
    %---plot results
    %   T = 0:dt:Time;
    T = 0:dt:(i-1)*dt;
    Reference = repmat(set_points,1,i);    
    plot(T,Reference(2,1:i),'r',T,FeedBack(2,1:i),'b');
    xlabel('Time (0.2 hour)');
    legend('Set_points','Simulated');
%     pause;
   
    

    
