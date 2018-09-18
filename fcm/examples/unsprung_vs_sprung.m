run init

unsprung_mass = 8:0.5:16; 
average_mu = zeros(1,length(unsprung_mass)); 

TLS_C1 = 1.07*10^(-5);
TLS_C2 = 3.21*10^(-8);

for i = 1:length(unsprung_mass) 
    fcm.Muf = unsprung_mass(i); % [kg] 
    fcm.Mur = unsprung_mass(i); % [kg]
    fcm.Muloc = [fcm.Muf*[1; 1]; fcm.Mur*[1; 1]];
 
    fcm.Ms = (167 + fcm.Mdriver) - 2*(fcm.Muf + fcm.Mur); % [kg]
    
    simOut = sim('fcm', 'SaveOutput', 'on'); 
    
    Fz_tyres = [simOut.get('Fz_FL')'; simOut.get('Fz_FR')'; simOut.get('Fz_RL')'; simOut.get('Fz_RL')'];
    Fxy_tyres = zeros(4, length(simOut.get('Fz_FL')));
    
    for j = 1:4
        Fxy_tyres(j,:) = Fz_tyres(j,:).*fcm.mu0 - TLS_C1*Fz_tyres(j,:).^2 - TLS_C2*Fz_tyres(j,:).^3;
    end
    
    Fz_tot = sum(Fz_tyres, 1); 
    Fxy_tot = sum(Fxy_tyres, 1);
    
    average_mu(1,i) = mean(Fxy_tot./Fz_tot);
end 

plot(unsprung_mass, average_mu)
xlabel('Unsprung mass [kg]') 
ylabel('Average grip [mu]')
title('Average grip vs increase in unsprung mass')
grid on 




