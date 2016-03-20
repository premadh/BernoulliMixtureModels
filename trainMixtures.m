function trainMixtures
%  Code to train Mixture Models of Multivariate Bernoulli Distributions
%  This code is in the public domain. 
%
% (c) Prem Raj Adhikari
%     www.premraj.me
%     August, 2010

% Clear previous results
clc;
clear;
format long

% Initialize a matrix to store the results  
mdllikehoodtrain = zeros(19,4); # Training Results
mdllikehoodtest  = zeros(19,4); # Test Results
% Number of clusters, i.e., component distributions
for clusters=2:20
	
	% Initialize a matrix for storing the results
    lkhood=zeros(50,1);
    tlkhood=zeros(50,1);
    % Number of folds in cross validation
    for dtype = 1:10
    	% Number of repeats of the experiment
        for janta = 1:50 
        	# Call BernoulliMix Commands
            cmd_train = ['bmix_train -f train',num2str(dtype),'.data -t 1000 -r 0.000001 -o ',num2str(clusters),'_', num2str(janta),'.model -c ', num2str(clusters), ' -e ', num2str(clusters)];
            cmd_like = ['bmix_like -f train', num2str(dtype), '.data -i ', num2str(clusters),'_', num2str(janta),'.model ',  ' --total-likelihood'];
			vcmd_like = ['bmix_like -f test', num2str(dtype), '.data -i ', num2str(clusters),'_', num2str(janta),'.model ',  ' --total-likelihood'];
            [testtstatus testtopt] = system(cmd_train);
            [testlstatus loutput] = system(cmd_like);
            [testlstatus voutput] = system(vcmd_like);
            lkhood(janta,1)=str2double(loutput);
            tlkhood(janta,1)=str2double(voutput);
        end
    end
    
    % Store traning results 
	mdllikehoodtrain((clusters-1),1)=mean(lkhood);
    mdllikehoodtrain((clusters-1),2)=clusters;
    mdllikehoodtrain((clusters-1),3)=mean(lkhood)+(iqr(lkhood)/2);
    mdllikehoodtrain((clusters-1),4)=mean(lkhood)-(iqr(lkhood)/2);
    
    % Store test results
	mdllikehoodtest((vclusters-1),1)=mean(tlkhood);   
	mdllikehoodtest((vclusters-1),2)=clusters;
	mdllikehoodtest((vclusters-1),3)=mean(tlkhood)+(iqr(tlkhood)/2);
	mdllikehoodtest((vclusters-1),4)=mean(tlkhood)-(iqr(tlkhood)/2);
end
% Write results to file
dlmwrite('trainlikelihood.txt', mdllikehoodtrain,' ');
dlmwrite('testlikelihood.txt', mdllikehoodtest, ' ');
end
