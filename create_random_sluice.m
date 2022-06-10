function sluice = create_random_sluice(Range, episodeNO, episode)
% example [lower_bound, upper_bound]
% Range = [[0, 12];    % n1
%          [0, 10.2];  % n2
%          [0, 7.5]];  % n3
    NO = floor(episodeNO/27);
    L1 = Range(1,1);   U1 = Range(1,2);   M1 = (L1+U1)/2;  K1 = M1/2;  T1 = 3*(M1/2); 
    L2 = Range(2,1);   U2 = Range(2,2);   M2 = (L2+U2)/2;  K2 = M2/2;  T2 = 3*(M2/2);
    L3 = Range(3,1);   U3 = Range(3,2);   M3 = (L3+U3)/2;  K3 = M3/2;  T3 = 3*(M3/2);
% L K T U
%     [L1, K1, T1, U1]
%     [L2, K2, T2, U2]
%     [L3, K3, T3, U3]
    if episode < NO       
        sluice = [ (K1-L1)*rand+L1 , (K2-L2)*rand+L2 , (K3-L3)*rand+L3 ];1
    else if NO <= episode  && episode < 2*NO   
            sluice = [ (K1-L1)*rand+L1 , (K2-L2)*rand+L2 , (T3-K3)*rand+K3 ];2
        else if 2*NO <= episode && episode < 3*NO   
                sluice = [ (K1-L1)*rand+L1 , (K2-L2)*rand+L2 , (U3-T3)*rand+T3 ];3
            else if 3*NO <= episode && episode < 4*NO   
                    sluice = [ (K1-L1)*rand+L1 , (T2-K2)*rand+K2 , (K3-L3)*rand+L3 ];4
                else if 4*NO <= episode && episode < 5*NO   
                        sluice = [ (K1-L1)*rand+L1 , (T2-K2)*rand+K2 , (T3-K3)*rand+K3 ];5
                    else if 5*NO <= episode && episode < 6*NO   
                            sluice = [ (K1-L1)*rand+L1 , (T2-K2)*rand+K2 , (U3-T3)*rand+T3 ];6   
                        else if 6*NO <= episode && episode < 7*NO   
                                sluice = [ (K1-L1)*rand+L1 , (U2-T2)*rand+T2 , (K3-L3)*rand+L3 ];7
                            else if 7*NO <= episode && episode < 8*NO   
                                    sluice = [ (K1-L1)*rand+L1 , (U2-T2)*rand+T2 , (T3-K3)*rand+K3 ];8
                                else if 8*NO <= episode && episode < 9*NO   
                                        sluice = [ (K1-L1)*rand+L1 , (U2-T2)*rand+T2 , (U3-T3)*rand+T3 ];9
        
                                    else if 9*NO <= episode && episode < 10*NO        
                                            sluice = [ (T1-K1)*rand+K1 , (K2-L2)*rand+L2 , (K3-L3)*rand+L3 ];10
                                        else if 10*NO <= episode && episode < 11*NO   
                                                sluice = [ (T1-K1)*rand+K1 , (K2-L2)*rand+L2 , (T3-K3)*rand+K3 ];11
                                            else if 11*NO <= episode && episode < 12*NO   
                                                    sluice = [ (T1-K1)*rand+K1 , (K2-L2)*rand+L2 , (U3-T3)*rand+T3 ];12
                                                else if 12*NO <= episode && episode < 13*NO   
                                                        sluice = [ (T1-K1)*rand+K1 , (T2-K2)*rand+K2 , (K3-L3)*rand+L3 ];13
                                                    else if 13*NO <= episode && episode < 14*NO   
                                                            sluice = [ (T1-K1)*rand+K1 , (T2-K2)*rand+K2 , (T3-K3)*rand+K3 ];14
                                                        else if 14*NO <= episode && episode < 15*NO   
                                                                sluice = [ (T1-K1)*rand+K1 , (T2-K2)*rand+K2 , (U3-T3)*rand+T3 ]; 15  
                                                            else if 15*NO <= episode && episode < 16*NO   
                                                                    sluice = [ (T1-K1)*rand+K1 , (U2-T2)*rand+T2 , (K3-L3)*rand+L3 ];16
                                                                else if 16*NO <= episode && episode < 17*NO   
                                                                        sluice = [ (T1-K1)*rand+K1 , (U2-T2)*rand+T2 , (T3-K3)*rand+K3 ];17
                                                                    else if 17*NO <= episode && episode < 18*NO   
                                                                            sluice = [ (T1-K1)*rand+K1 , (U2-T2)*rand+T2 , (U3-T3)*rand+T3 ]; 18    
        
                                                                        else if 9*NO <= episode && episode < 10*NO        
                                                                                sluice = [ (U1-T1)*rand+T1 , (K2-L2)*rand+L2 , (K3-L3)*rand+L3 ];19
                                                                            else if 10*NO <= episode && episode < 11*NO   
                                                                                    sluice = [ (U1-T1)*rand+T1 , (K2-L2)*rand+L2 , (T3-K3)*rand+K3 ];20
                                                                                else if 11*NO <= episode && episode < 12*NO   
                                                                                        sluice = [ (U1-T1)*rand+T1 , (K2-L2)*rand+L2 , (U3-T3)*rand+T3 ];21
                                                                                    else if 12*NO <= episode && episode < 13*NO   
                                                                                            sluice = [ (U1-T1)*rand+T1 , (T2-K2)*rand+K2 , (K3-L3)*rand+L3 ];22
                                                                                        else if 13*NO <= episode && episode < 14*NO   
                                                                                                sluice = [ (U1-T1)*rand+T1 , (T2-K2)*rand+K2 , (T3-K3)*rand+K3 ];23
                                                                                            else if 14*NO <= episode && episode < 15*NO   
                                                                                                    sluice = [ (U1-T1)*rand+T1 , (T2-K2)*rand+K2 , (U3-T3)*rand+T3 ];24   
                                                                                                else if 15*NO <= episode && episode < 16*NO   
                                                                                                        sluice = [ (U1-T1)*rand+T1 , (U2-T2)*rand+T2 , (K3-L3)*rand+L3 ];25
                                                                                                    else if 16*NO <= episode && episode < 17*NO   
                                                                                                            sluice = [ (U1-T1)*rand+T1 , (U2-T2)*rand+T2 , (T3-K3)*rand+K3 ];26
                                                                                                        else 
                                                                                                            sluice = [ (U1-T1)*rand+T1 , (U2-T2)*rand+T2 , (U3-T3)*rand+T3 ];27    
                                                                                                        end
                                                                                                    end
                                                                                                end
                                                                                            end
                                                                                        end
                                                                                    end
                                                                                end
                                                                            end
                                                                        end
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end


    