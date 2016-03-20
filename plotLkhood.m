function plotLkhood(chr, res, k)

% Given chromosome and resolution read the written training and validation likelihood  and plot
%
% input (optional) chr  The chromosome to plot (default = 1)
% input (optional) res  The resolution of the chromosome to plot (default = 393 )
% input (optional) k    The figure to plot if called multiple times (default = 1)
%
% The files are save in folder as chr[chromosome number]/[chromosome resolution]/[test|train]likelihood.txt 

% The format of files is 
% [Likelihood] [Number of Components] [LIkelihood - IQR] [Likelihood + IQR]

% Example
% -4.4512 2 -4.2616 -4.6407
% -3.4616 3 -3.4616 -3.4616
% -3.1780 4 -3.1780 -3.1780

%  This code is in the public domain. 
%
% (c) Prem Raj Adhikari
%     www.premraj.me
%     August, 2010

% Check if the arguments are passed otherwise set them to default

if ~exist('chr','var'), chr = 1; end
if ~exist('res','var'), res = 393; end
if ~exist('k','var'), k = 1; end

# Format the filenames
flnametest=['chr',int2str(chr),'/',int2str(res),'/testlikelihood.txt'];
flnametrain=['chr',int2str(chr),'/',int2str(res),'/trainlikelihood.txt'];

# Check if file exists otherwise exit showing an error

if (exist(flnametest,'file') && exist(flnametrain, 'file'))
    mdllikehoodtrain = load(flnametrain);
    mdllikehoodtest =load(flnametest);
    
    # Change resolution 393 to 400 (Readability)
    if (res==393)
        res=400;
    end
    
    # Title of the plot
    sirsak=['Chromosome-',int2str(chr), 'and Resolution-',int2str(res)];
    
    h=figure(k);
    clf;
    plot(mdllikehoodtrain(:,2),mdllikehoodtrain(:,1),'s-r',mdllikehoodtest(:,2), mdllikehoodtest(:,1),'-ob', 'LineWidth',0.7 );
    hold on;
    plot(mdllikehoodtrain(:,2),mdllikehoodtrain(:,3),'-.g',mdllikehoodtest(:,2), mdllikehoodtest(:,3),':k' );
    hold on;
    plot(mdllikehoodtrain(:,2),mdllikehoodtrain(:,4),'-.g',mdllikehoodtest(:,2), mdllikehoodtest(:,4),':k' );
    axis([2 20 (min(min(mdllikehoodtrain(:,1),min(mdllikehoodtest(:,1))))-0.1) max((max(mdllikehoodtrain(:,1),max(mdllikehoodtest(:,1))))+0.1)])
    xlabel('Number of Components');          %  add axis labels and plot title
    ylabel('Log likelihood');
    title(sirsak,'FontSize',26,'FontName', 'Times');
    legend('Training Set', 'Validation Set','Training IQR','Validation IQR','location','SE')
    
    # Filename of the plot to write
    filename = ['newfigures/chr',int2str(chr),'dm',int2str(res),'wt.eps'];
    h_xlabel = get(gca,'XLabel');
    set(gca,'FontSize',18);
    set(h_xlabel,'FontSize',22,'FontName', 'Times');
    h_ylabel = get(gca,'YLabel');
    set(h_ylabel,'FontSize',22,'FontName', 'Times');
    set(gca,'XTick',[2:2:20])
    print(h, '-depsc', filename); # Write the plot to file 
    %-depsc  -dpng
else
   bhanne=['Some files for resolution ', int2str(res), ' Chromosome ', int2str(chr),' does not exist'];
   disp(bhanne);
end


