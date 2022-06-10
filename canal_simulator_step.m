function depth_error = canal_simulator_step(u, et, d_ind)    %et ==> depth_error in previous time step    
    %---------Canal Model parameters---------------------------------------------------
    load Linear_Model_ICSS_opt.mat    
        
    %d=[.200 .300 .200 .300 .200 .300 .200 .300];% turnout demnads
    %if d_ind < 6
       d=[0.1 0.1 0 0 0 0 0 0];
    %elseif d_ind >= 6 && d_ind < 12
    %   d=[0 0 0.1 0.1 0 0 0 0];
    %elseif d_ind >= 12 && d_ind < 18
    %   d=[0 0 0 0 0.1 0.1 0 0];
    %else
    %   d=[0 0 0 0 0 0 0.1 0.1];
    %end

    d=d';
    depth_error=A_icss*et+Bu_icss*u+Bd_icss*d;    
end