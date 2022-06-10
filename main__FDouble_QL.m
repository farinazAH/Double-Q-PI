clear all
clc
hold on
%%
%---------Canal Model parameters---------------------------------------------------
load Linear_Model_ICSS_opt.mat
%---------PID parameters---------------------------------------------------
Time = 2;
dt = 0.2;
out_Low = -0.2; 
out_upp = 0.2;
%---------Canal Info-------------------------------------------------------
initial_state = [0, 0, 0, 0, 0, 0, 0, 0];
set_points = [0, 0, 0, 0, 0, 0, 0, 0];
disp('set_points for PID controller = '); disp(set_points);
% disp('initial_state = '); disp(initial_state);
%%
%---------RL Parameters----------------------------------------------------
gama=0.9;
epsilon =0.1;
Eps=epsilon;
learning_rate=0.001;

a_cnt_half=2;
learn_length=0.5;
%%
% one PID control to control all gates
%---------Fuzzy Parameters-------------------------------------------------
%    lower_bound, upper_bound
Range = [[0, 12];     % n1   -> fake for block 1
         [0, 12];     % n2
         [0, 12];     % n3
         [0, 12];     % n4
         [0, 12];     % n5
         [0, 12];     % n6
         [0, 12];     % n7
         [0, 12];     % n8
        ]; 
P = 3; % number of partitions in each input
[A, B, C] = create_ABC(Range,P);
% Plot_ABC(A, B, C);
ruleTable = Create_FIS_Rule_Table(A, B, C);
rule_NO = size(ruleTable,1);
localAction_NO = 3;
critic_ActionSeeds = 0.5*ones(localAction_NO, rule_NO);
%%
%----------Run Parameters--------------------------------------------------
trainNOs=[];
%--------------------------------------------------------------------------
outputs=[];
episodeNO=400;
episodeSteps = round((24/dt)/(Time/dt));
Runs =1;
%%
%---------------------------START------------------------------------------
AvgepisodeRewards=zeros(1, episodeSteps);
actor_parameters_run=zeros(size(critic_ActionSeeds,1),size(critic_ActionSeeds,2));
%__________________________________________________________________________
for RunNo=1:Runs
    episodeRewards=zeros(episodeNO, episodeSteps);      
      
    [critic_LocalActionList,  critic_q_A] = create_critic(critic_ActionSeeds,a_cnt_half,learn_length);
    critic_q_B = critic_q_A;
    
    simulate_NOs = [];
    %______________________________________________________________________
    for episode=1:episodeNO
        
        episodeReward=zeros(1, episodeSteps);
        trainNO=1;
        
        e = zeros((a_cnt_half*2+1)^localAction_NO,size(critic_ActionSeeds,2));         
      
%         sluice = create_random_sluice(Range, episodeNO, episode);
%         disp('sluice = '); disp(sluice(1,2:3));  
                   
        %------------------------------Main Process------------------------
        %---read first state   
        state = initial_state';                         
        %__________________________________________________________________
        for step = 1:episodeSteps        
            disp('state = '); disp(state');
            %%--------RL---------------------------------------------------
            state_fire = Compute_Rule_Fires(state, A, B, C, ruleTable);
            [flag_AB, actor_params, critic_params, local_ind_aq, e] = EpsGreedyLocalActSelection(state_fire, critic_LocalActionList, critic_q_A, critic_q_B, e, Eps, gama);

            Q_s_output = sum(state_fire.*critic_params);   
            pid_K_vector = sum(repmat(state_fire,localAction_NO,1)'.*actor_params');
            
            %---use p i d to generate output and receive next_state and reward
            [next_state, reward]= PID_Controller (state, set_points',pid_K_vector,Time,dt,out_Low,out_upp);
    
            %**************************************************************
            episodeReward(trainNO) = reward;          
                        
            %---update Q tables
            next_state_fire = Compute_Rule_Fires(next_state, A, B, C, ruleTable);
            [critic_q_A, critic_q_B] = Update_Double_Q(flag_AB, reward, Q_s_output, next_state_fire, critic_LocalActionList, critic_q_A, critic_q_B, e, gama, learning_rate); 
            
            state = next_state;
            trainNO = trainNO+1;   
        end 
        %__________________________________________________________________
        episodeRewards(episode,1:episodeSteps) = episodeReward;
        trainNOs = [trainNOs trainNO];
        if  rem(episode,episodeNO/4) == 0
            Eps=Eps/2;  
        end
        %__________________________________________________________________
    end        
    Eps=epsilon;
    AvgepisodeRewards = AvgepisodeRewards+sum(episodeRewards,1);   
    %______________________________________________________________________ 
end
%%
AvgepisodeRewards = AvgepisodeRewards./RunNo;
figure;
t=1:1:episode;
plot(t,AvgepisodeRewards,'r');
%%
disp('train number = ');
disp(trainNOs);
            
            