inputFile = 'ex_output.mat';

%% Load and process
% Quick and easy processing of Koni rig data
load(inputFile)

figure
for i = 1:length(matrix(1,:))
     subplot(length(matrix(1,:)), 1, i);
     
     plot(matrix(:,i))
     if (units(i,:) ~= 'units     ')
         title(strcat(names(i,:), " [", units(i,:), "]"));
     else
         title(names(i,:));
     end
end

