%% SOM 1-D
close all
clc
samples = 200;
neurons = 70;
eta_i = 0.3;
sigma_i = 2;    %initial sigma
tau1 = 3000;
tau2 = 30;
h = 0;          %neighbourhood function

%% Generation of data for input space
input_space = rand(2,samples);

%% Initialization of SOM
weights = 0.8*rand(2,neurons)-1;

%% SOM Algo

for m = 1:100
    eta = eta_i*exp(-(m/tau2));
    display(m)
    display(eta)
    for i = 1:samples
        
        % Finding out winning neuron
        dist = zeros(1,neurons);
        for j = 1:neurons
            dist(j) = norm(weights(:,j)-input_space(:,i));
        end
        [min_val,index_min] = min(dist);
        
        
        %weight updation
        sigma = sigma_i*exp(-(i/tau1));
        for j = 1:neurons
            h = exp(-((abs(j-index_min))^2/(2*sigma^2)));
            weights(:,j) = weights(:,j) + eta*h*(input_space(:,i)-weights(:,j));
        end
        
    end
    plot(input_space(1,:),input_space(2,:),'.');
    hold on
    plot(weights(1,:),weights(2,:),'bo');
    hold off
    pause(0.05)
end

save('SOM_eg_2_8');



