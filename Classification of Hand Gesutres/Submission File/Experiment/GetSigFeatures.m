% ---------------------------- Copyright Notice ---------------------------
% This file is part of BioPatRec © which is open and free software under 
% the GNU Lesser General Public License (LGPL). See the file "LICENSE" for 
% the full license governing this code and copyrights.
%
% BioPatRec was initially developed by Max J. Ortiz C. at Integrum AB and 
% Chalmers University of Technology. All authors’ contributions must be kept
% acknowledged below in the section "Updates % Contributors". 
%
% Would you like to contribute to science and sum efforts to improve 
% amputees’ quality of life? Join this project! or, send your comments to:
% maxo@chalmers.se.
%
% The entire copyright notice must be kept in this or any source file 
% linked to BioPatRec. This will ensure communication with all authors and
% acknowledge contributions here and in the project web page (optional).
%
% -------------------------- Function Description -------------------------
% Funtion to Breakdown the time and frecuency features
% Input : data  Matrix of MxN where the rows are the channels
%       : sF    Sampling Frequency
%       : fID   features ID, if not fID given, it compute the hard-coded
%               ones
% Output: features    Signal features is an struct
%
% ------------------------- Updates & Contributors ------------------------
% [Contributors are welcome to add their email]
% 2011-07-27 / Max Ortiz  / Creation from the old analyze_signal fuction in
%                           EMG_AQ in 2009
% 2012-07-19 / Max Ortyiz / Add LoadFeaturesID funtion instead of
%                           hard-coded IDs
% 2012-11-23 / Max Ortyiz / Vectorized implementation of tzc and tslpch2
%                           for speed improvement
%                           
% 2016-03-01 / Eva Lendaro / Added the filter information in the
%                            procFreature structure (needed for
%                            cardinality)


function xFeatures = GetSigFeatures(data,sF,fFilter, fID)

    % If not features ID were receved, then compute the following ones:
    if ~exist('fID','var')
        fID = LoadFeaturesIDs;            
    end

    % General information required to calculate different signal features
    % other processing is added by specific futures in their functions
    procFeatures.ch      = length(data(1,:));
    procFeatures.sp      = length(data(:,1));
    procFeatures.sF      = sF;
    procFeatures.data    = data;
    procFeatures.absdata = abs(data);
    procFeatures.f       = {};
    procFeatures.filter  = fFilter;
    
    % Calculate signal features
    for i = 1 : size(fID,1)
        fName = ['GetSigFeatures_' fID{i}];
        procFeatures = feval(fName, procFeatures); 
    end
    xFeatures = procFeatures.f;
end

function pF = GetSigFeatures_tmabs(pF)
% 2011-07-27 Max Ortiz / Creation
    pF.f.tmabs = mean(pF.absdata);  
end

function pF = GetSigFeatures_twl(pF)
% Waveform Length (acumulative changes in the length)
% 2011-07-27 Max Ortiz / Creation
    mdata = [zeros(1,pF.ch) ; pF.data(1:pF.sp-1,:)];
    pF.f.twl = sum(abs(pF.data - mdata));
end

function pF = GetSigFeatures_trms(pF)
% 2011-07-27 Max Ortiz / Creation
    pF.f.trms = sqrt(sum(pF.absdata .^ 2)/pF.sp);
end

function pF = GetSigFeatures_tzc(pF)
global MEAN_ABSOLUTE_THRESHOLD

% 2011-07-27 Max Ortiz / Creation
    %check if tmabs is available
    if ~isfield(pF.f,'tmabs')
        pF = GetSigFeatures_tmabs(pF);
    end
    
    if isempty(MEAN_ABSOLUTE_THRESHOLD) == 0
        tmp = MEAN_ABSOLUTE_THRESHOLD;
    else
        tmp = repmat(pF.f.tmabs,[size(pF.data,1),1] );
    end   
   
    
    zc = ( pF.data >= tmp ) - (pF.data < tmp );
    pF.f.tzc = sum( ( zc(1:pF.sp-1,:) - zc(2:pF.sp,:) ) ~= 0);
    
%     % Zero Crossing / using the abs mean as threshold
%     for i = 1 : pF.ch
%         zc = (pF.data(:,i) >= pF.f.tmabs(i)) - (pF.data(:,i) < pF.f.tmabs(i));
%         pF.f.tzc(i) = sum((zc(1:pF.sp-1) - zc(2:pF.sp)) ~= 0);
%     end
end

function pF = GetSigFeatures_tslpch2(pF)
% 2011-07-27 Max Ortiz / Creation
    % Slope Changes using the diff of the raw signal and the computing
    % zero crossing
    global MEAN_ABSOLUTE_THRESHOLD;
    
 if ~isfield(pF.f,'tmabs')
        pF = GetSigFeatures_tmabs(pF);
 end
    
    if isempty(MEAN_ABSOLUTE_THRESHOLD) == 0
        tmp = MEAN_ABSOLUTE_THRESHOLD;
    else
        tmp = repmat(pF.f.tmabs,[size(pF.data,1)-1,1] );
    end   
   
    if ~isfield(pF,'diffData')
        pF.diffData = diff(pF.data);           % Get the diff
    end    
    
    zc = (pF.diffData > tmp ) - (pF.diffData < tmp);
    pF.f.tslpch2 = sum( abs( zc(1:end-1,:) - zc(2:end,:) ) > 1 );
    
%     for i = 1 : pF.ch
%         zc = (pF.diffData(:,i) > 0) - (pF.diffData(:,i) < 0); 
%         pF.f.tslpch2(i) = sum(abs(zc(1:end-1) - zc(2:end)) > 1);
%     end
end

function pF = GetSigFeatures_twamp(pF)
global RMS_THRESHOLD
%check if tmabs is available
if isempty(RMS_THRESHOLD) == 0
       threshold = RMS_THRESHOLD; 
else 
    threshold = sqrt(sum(pF.absdata .^ 2)/pF.sp);
end
	pF.f.twamp = mean(abs(diff(pF.data))> threshold);
end

function pF = GetSigFeatures_tcard(pF)

if strcmp(pF.filter,'None')
        % Do nothing and exit if
else
   %scale to 14 bits
    
    a = 4096;   
    b = a;
    a = a * -1;
    
    % Range of the original aquisition
    minX = -5;
    maxX = 5;
    
    % Scale
    pF.data = round((pF.data- minX) .* (b-a) ./ (maxX-minX) + a);
    
end

    for ch = 1 : pF.ch
        % Get the number of different values and their number of repetitions
        v = unique(pF.data(:,ch));
        m = size(v,1);      % Number of unique values, or cardinality        
        pF.f.tcard(ch) =  m;
    end
end

