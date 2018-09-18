run init

TLS_C1 = 1.07*10^(-5);
TLS_C2 = 3.21*10^(-8);

spring_stiff = [64000 64000; 
                48000 64000];
                     
Fxy_tyres = zeros(4, 70001);
Fxy_totPlot = zeros(3,70001);
PDensFunc = zeros(3,70001);

for i = 1:length(spring_stiff(1,:))

    fcm.Ks = [spring_stiff(1,i); spring_stiff(1,i); spring_stiff(2,i); spring_stiff(2,i)];
    
    simOut = sim('fcm', 'SaveOutput', 'on'); 
    
    Fz_tyres = [simOut.get('Fz_FL')'; simOut.get('Fz_FR')'; simOut.get('Fz_RL')'; simOut.get('Fz_RL')'];
    Fxy_tyres = zeros(4, length(simOut.get('Fz_FL')));
    
    for j = 1:4
        Fxy_tyres(j,:) = Fz_tyres(j,:).*fcm.mu0 - TLS_C1*Fz_tyres(j,:).^2 - TLS_C2*Fz_tyres(j,:).^3;
    end
    
    Fz_tot = sum(Fz_tyres, 1); 
    Fxy_tot = sum(Fxy_tyres, 1);
    
    if i == 1
        check1Force = Fxy_tot;
    elseif i == 2
        check2Force = Fxy_tot;
    end
          
    PDens = makedist('Normal',mean(Fxy_tot),std(Fxy_tot)); 
            
    Fxy_totPlot(i,:) = sort(Fxy_tot);
    PDensFunc(i,:) = pdf(PDens, sort(Fxy_tot));
end

figure(1)
plot(Fxy_totPlot(1,:),PDensFunc(1,:))
hold on 
plot(Fxy_totPlot(2,:),PDensFunc(2,:))
grid on 
xlabel('Fxy force [N]')
ylabel('Probability p(Fxy) [-]') 
title('Probability Density Function') 
legend('64 - 48 N/mm', ' 64 - 64 N/mm')
