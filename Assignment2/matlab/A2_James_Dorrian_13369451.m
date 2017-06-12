%James Dorrian - 13369451 - Assignment 2 - Neyman Pearson - Laplacian
A2(1)
%A2(2)   %run question 1

function A2(index)

    switch(index)
        case 1 
            neymanpearson(1);      %(1/1)  => K=1 
            neymanpearson(2);      %(1/2)  => K=0.5 value divinding watermark by -> watermark = 0.5
            neymanpearson(10);     %(1/10) => K=0.1
            plot([0,1], [0,1], '-g')     %plot the chance line
        case 2
            laplacian(1);
            laplacian(2);
            laplacian(10);
            plot([0,1], [0,1], '-c')
    end
    
end

%=====> PART 1 <=====
function [] = neymanpearson(K)
    num_vectors = 1000; 
    num_values = 100;
    mean = 0;
    standard_deviation = 10;
    z  = randn(num_values,1) * standard_deviation + mean;   %create a vector Z with 100 norm dist. values in it
    x = ones(num_values,1)/K;                               %create a watermark array
    threshold = zeros(num_values,1);                        %create a threshold array
    step=0.01;

    for i=1:100
        threshold(i) = qfuncinv(step) * norm(x) * standard_deviation; 
        step = step + 0.01;
    end

%null hypothesis over 1k vectors to calc empirical FA rate
    temp=z;
    for i=[1:num_vectors]
        z=randn(num_values,1) * standard_deviation + mean;
        temp=z;
        rate_h0(i)=temp'*x; 
    end

%alt hypothesis over 1k vectors to calc empirical DET rate
    for i=[1:num_vectors]
        z=randn(num_values,1) * standard_deviation + mean;
        temp=z+x; %notice x being added
        rate_h1(i)=temp'*x; 
    end

%Theoretical probability of false alarm 
    for i = 1:100 %this is 99 because
        prob_failure(i) = qfunc(threshold(i) / (norm(x) * standard_deviation)); 
    end

%Theoretical probability of detection
    for i = 1:100
        prob_detection(i) = qfunc((threshold(i) - (norm(x)^2)) / (norm(x) * standard_deviation));
    end

%Plot theoretical failure vs. detection
    if (K == 1)
        plot(prob_failure, prob_detection, 'red');
    elseif(K == 2)
        plot(prob_failure, prob_detection, 'magenta');
    else
        plot(prob_failure, prob_detection, 'blue');
    end
    
    bins=[min(rate_h0): (max(rate_h1)-min(rate_h0))/50: max(rate_h1)]; 
    
%Plot rate of false alarm of empirical values (50 bins)
    [pdf_r_h0, bins] = hist(rate_h0, 50); 

%Plot rate of detection of empirical values
    [pdf_r_h1, bins] = hist(rate_h1, 50); 
    bins=[min(rate_h0): (max(rate_h1)-min(rate_h0))/50: max(rate_h1)]; 

%Convert rate of false alarm to histogram of empirical vals
    [h0, bins0]=hist(rate_h0,bins);
    
%Convert rate of detection to histogram of empirical vals
    [h1, bins1]=hist(rate_h1,bins); 
    h1 = h1/num_vectors;             
    h0 = h0/num_vectors;

%Get empirical values for cdf
    cdfh1(1) = h1(1);
    for i=2:51
        cdfh1(i)=cdfh1(i-1)+h1(i);
    end

    cdfh0(1) = h0(1);
    for i=2:51
        cdfh0(i)=cdfh0(i-1)+h0(i);
    end

%Plot alt and null hypothesis as 1-cdfh0/1-cdfh1
    hold on;    
    axis([0 1 0 1]);
    if (K == 1)
        plot(1-cdfh0, 1-cdfh1, 'xr');
    elseif(K == 2)
        plot(1-cdfh0, 1-cdfh1, 'xm');
    else
        plot(1-cdfh0, 1-cdfh1, 'xb');
    end
end


%=====> PART 2 <=====
function y  = laprnd(m, n)
    % Generate Laplacian noise where lamba = 0.5
    mu = 0;
    sigma = 10;
    u = rand(m, n) - 0.5; %array of 100 values of 0.5
    b = sigma / sqrt(2);  %sigma = lambda in formula
    
    y = mu - b * sign(u).* log(1- 2* abs(u));
end

function [] = laplacian(K)
    num_vectors = 1000; 
    num_values = 100;
    mean = 0;
    standard_deviation = 10;
    z  = laprnd(num_values,1) * standard_deviation + mean;  %create a vector Z with 100 norm dist. values in it
    x = ones(num_values,1)/K;                               %create a watermark array
    threshold = zeros(num_values,1);                        %create a threshold array
    step=0.01;

    for i=1:100
        threshold(i) = qfuncinv(step) * norm(x) * standard_deviation; 
        step = step + 0.01;
    end

%null hypothesis over 1k vectors to calc empirical FA rate
    temp=z;
    for i=[1:num_vectors]
        z=laprnd(num_values,1) * standard_deviation + mean; %COMMENT OUT THIS LINE FOR FIG 2 (a)
        %z=laprnd(num_values,1) + mean; %UNCOMMENT THIS LINE FOR FIG 2 (a)
        temp=z;
        rate_h0(i)=temp'*x; 
    end

%alt hypothesis over 1k vectors to calc empirical DET rate
    for i=[1:num_vectors]
        z=laprnd(num_values,1) * standard_deviation + mean;
        temp=z+x%*standard_deviation; %notice x being added
        rate_h1(i)=temp'*x; 
    end

%Theoretical probability of false alarm 
    for i = 1:100 %this is 99 because
        prob_failure(i) = qfunc(threshold(i) / (norm(x) * standard_deviation)); 
    end

%Theoretical probability of detection
    for i = 1:100
        prob_detection(i) = qfunc((threshold(i) - (norm(x)^2)) / (norm(x) * standard_deviation));
    end

%Plot theoretical failure vs. detection
    if (K == 1)
        plot(prob_failure, prob_detection, 'green');
    elseif(K == 2)
        plot(prob_failure, prob_detection, 'blue');
    else
        plot(prob_failure, prob_detection, 'red');
    end
    
    bins=[min(rate_h0): (max(rate_h1)-min(rate_h0))/50: max(rate_h1)]; 
    
%Plot rate of false alarm of empirical values (50 bins)
    [pdf_r_h0, bins] = hist(rate_h0, 50); 

%Plot rate of detection of empirical values
    [pdf_r_h1, bins] = hist(rate_h1, 50); 
    bins=[min(rate_h0): (max(rate_h1)-min(rate_h0))/50: max(rate_h1)]; 

%Convert rate of false alarm to histogram of empirical vals
    [h0, bins0]=hist(rate_h0,bins);
    
%Convert rate of detection to histogram of empirical vals
    [h1, bins1]=hist(rate_h1,bins); 
    h1 = h1/num_vectors;             
    h0 = h0/num_vectors;

%Get empirical values for cdf
    cdfh1(1) = h1(1);
    for i=2:51
        cdfh1(i)=cdfh1(i-1)+h1(i);
    end

    cdfh0(1) = h0(1);
    for i=2:51
        cdfh0(i)=cdfh0(i-1)+h0(i);
    end

%Plot alt and null hypothesis as 1-cdfh0/1-cdfh1
    hold on;    
    axis([0 1 0 1]);
    if (K == 1)
        plot(1-cdfh0, 1-cdfh1, 'xg');
    elseif(K == 2)
        plot(1-cdfh0, 1-cdfh1, 'xb');
    else
        plot(1-cdfh0, 1-cdfh1, 'xr');
    end
end
