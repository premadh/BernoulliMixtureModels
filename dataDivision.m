function M=dataDivision(flname)
% Divides the data into training and test set and write them to  files 
%
% Parameters 
%  flname : Name of the datafile with location or should be in the path
% This code is in the public domain. 
% 
% (c) Prem Raj Adhikari
%     www.premraj.me
%     August, 2010

% Load  the data file
chrdm=load(flname);

% Generate the cross-validation indices
indices = crossvalind('Kfold',size(chrdm,1),10);

% Number of folds 
for j=1:10  
	% Index for training data
    indx=find(j==indices);
    testdata=chrdm(indx,:);
    
    % Index for test data
    indx=find(j~=indices);
    traindata=chrdm(indx,:);
    
    % Generate the file names to write
    testflname=['test',num2str(j),'.data'];
    trainflname=['train',num2str(j),'.data'];
    
    % Write the data to test and train filenames
    dlmwrite(testflname,testdata, ' ');
    dlmwrite(trainflname,traindata, ' ');
end



