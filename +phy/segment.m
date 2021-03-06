% PHY.SEGMENT
%
% Copyright (C) 2018 Olivier Lartillot
% Some code taken from MoCap Toolbox, Copyright 2008, 
% University of Jyvaskyla, Finland
% All rights reserved.
% License: New BSD License. See full text of the license in LICENSE.txt in
% the main folder of the MiningSuite distribution.

function varargout = segment(varargin)
varargout = sig.operate('phy','segment',options,@init,@main,@after,...
                        varargin,'concat_sample');


function options = options
options = sig.Signal.signaloptions('FrameAuto',.05,.5);

    fill.key = 'Fill';
    fill.type = 'Boolean';
    fill.when = 'After';
    fill.default = 0;
options.fill = fill;

    connect.key = 'Connect';
%     connect.when = 'After';
    connect.default = [];
options.connect = connect;

    reduce.key = 'Reduce';
%     reduce.when = 'After';
    reduce.default = [];
options.reduce = reduce;

    extract.key = {'Extract','Excerpt'};
    extract.type = 'Unit';
    extract.number = 2;
    extract.default = [];
    extract.unit = {'s','sp'};
options.extract = extract;

    j2spar.position = 2;
options.j2spar = j2spar;

    sgmindex.position = 3;
%     sgmindex.key = 'SgmIndex';
    sgmindex.default = [];
options.sgmindex = sgmindex;

                        
function [x,type] = init(x,option)
x = phy.point(x,'Fill',option.fill,'Reduce',option.reduce,'Connect',option.connect);
type = 'phy.Segment';
    

function out = main(d,option)
if iscell(d)
    d = d{1};
end
data = d.Ydata.content;
srate = d.Srate;
missing = d.missing;
connect = d.connect;
N = size(data,1);
M = size(data,2);
eucl = NaN(N,M,3);
r = NaN(M);
quat = NaN(N,M,4);
angle = NaN(N,M);

par = option.j2spar;
parent = par.parent;
label = par.segmentName;

if strcmp(par.type,'j2spar')
    roottrans = data(:,par.rootMarker,:);
    frontalPlane = cross(data(:,par.frontalPlane(2),:)...
                         - data(:,par.frontalPlane(1),:),...
                         data(:,par.frontalPlane(3),:)...
                         - data(:,par.frontalPlane(1),:),...
                         3);
    norm = vecnorm(frontalPlane,2,3);
    frontalPlaneUnit = frontalPlane ./ repmat(norm,1,1,3);
    [th,phi,r] = cart2sph(frontalPlaneUnit(:,1),frontalPlaneUnit(:,2),frontalPlaneUnit(:,3));
    th = unwrap(th);
    rootrot.az = 90 + 180*th/pi;
    rootrot.el = 180*phi/pi;
    rdata = rotate(data, -rootrot.az);
    
    parent = par.parent;
    % Euclidean parameters
    for k = 1:length(parent)
        if parent(k)>0
            euclk = rdata(:,k,:) - rdata(:,parent(k),:);
            eucl(:,k,:) = euclk;
            neuclk = vecnorm(euclk,2,3);
            r(k) = mean(neuclk(isfinite(neuclk)));
            % Quaternions
            quat(:,k,:) = dir2quat(euclk);
        end
    end
    
    % segment angles
    for k = 1:length(parent)
        if par.parent(k) > 0 && parent(parent(k)) > 0
            angle(:,k)= (180/pi)*acos(dot(euclk,eucl(:,parent(k),:),3)...
                ./(vecnorm(euclk,2,3).*vecnorm(eucl(:,parent(k),:),2,3)));
        end
    end
else
    roottrans = par.roottrans;
    rootrot = par.rootrot;
    for i = 1:M
        eucli = par.segm(i).eucl;
        ri = par.segm(i).r;
        quati = par.segm(i).quat;
        angli = par.segm(i).angle;
        if ~isempty(eucli)
            eucl(:,i,:) = eucli;
        end
        if ~isempty(ri)
            r(i) = ri;
        end
        if ~isempty(quati)
            quat(:,i,:) = quati;
        end
        if ~isempty(angli)
            angle(:,i) = angli;
        end
    end
end

eucl = sig.data(eucl,{'sample','segment','dim'});
r = sig.data(r,{'sample'});
quat = sig.data(quat,{'sample','segment','dim'});
angle = sig.data(angle,{'sample','segment'});
out = phy.Segment(data,'Srate',srate,'Missing',missing,...
    'Eucl',eucl,'R',r,'Quat',quat,'Angle',angle,...
    'Parent',parent,'RootTrans',roottrans,'RootRot',rootrot,...
    'Label',label,'Connect',connect);
out.design.files = {d.files};


function out = after(obj,option)
if iscell(obj)
    obj = obj{1};
end

if ~isempty(option.extract)
    obj = obj.extract(option.extract,'sample','saxis','Ydata');
end

if option.fill
    obj = obj.fill;
end

sgmindex = option.sgmindex;
if ~isempty(sgmindex)
    obj.spar =  mcgetsegmpar('Dempster',sgmindex);
end

% connect = option.connect;
% if ~isempty(connect)
%     if isstruct(connect)
%         connect = connect.conn;
%     end
%     obj.connect = connect;
% end
% 
% if ~isempty(option.reduce)
%     obj.label = option.reduce.markerName;
%     l = length(option.reduce.markerNum);
%     d = zeros(size(obj.Ydata.content,1),l,3);
%     for i = 1:l
%         d(:,i,:) = mean(obj.Ydata.content(:,option.reduce.markerNum{i},:),2);
%     end
%     obj.Ydata.content = d;
% end

out = {obj};


function dat2 = rotate(dat,theta)
% N = size(dat,1);
% if length(theta)==1 
%     theta = theta*ones(N,1);
% else
%     theta = interp1(linspace(1,N,length(theta)),theta,1:N)';
% end
axis = [0 0 1]; 
 
dd = dat(isfinite(dat));
m = mean(mean(dd,1),2);

dat2 = zeros(size(dat));
for k=1:size(dat,2) % per marker
    ind=find(isfinite(dat(:,k,1)));
    if ~isempty(ind)
        q = [cos(pi*theta(ind)/360) axis(1)*sin(pi*theta(ind)/360) axis(2)*sin(pi*theta(ind)/360) axis(3)*sin(pi*theta(ind)/360)];
        dat2(ind,k,:) = quatrot(dat(ind,k,:)-m, q) + m;
    end
end


function w = quatrot(v, q)
% rotates vector V by quaternion Q
w = zeros(size(v));
t2 = q(:,1).*q(:,2);
t3 = q(:,1).*q(:,3);
t4 = q(:,1).*q(:,4);
t5 = -q(:,2).*q(:,2);
t6 = q(:,2).*q(:,3);
t7 = q(:,2).*q(:,4);
t8 = -q(:,3).*q(:,3);
t9 = q(:,3).*q(:,4);
t10 = -q(:,4).*q(:,4);
w(:,1,1) = 2*((t8 + t10).*v(:,1,1) + (t6 - t4).*v(:,1,2) + (t3 + t7).*v(:,1,3)) + v(:,1,1);
w(:,1,2) = 2*((t4 + t6).*v(:,1,1) + (t5 + t10).*v(:,1,2) + (t9 - t2).*v(:,1,3)) + v(:,1,2);
w(:,1,3) = 2*((t7 - t3).*v(:,1,1) + (t2 +  t9).*v(:,1,2) + (t5 + t8).*v(:,1,3)) + v(:,1,3);


function q = dir2quat(v)
% converts vector V to the quaternions representing the rotation
% needed to obtain V/norm(V) from BASE (default: BASE = (0,-1,0))
% for an N*3 matrix performs the operation for each row separately 
base = [0 -1 0];
q = zeros(size(v,1), 4);
for k=1:size(v,1)
    vv = v(k,:) / norm(v(k,:));
    ax = cross(base, vv); % rotation axis
    ax = ax / norm(ax);
    alpha = acos(dot(base, vv));
    q(k,:) = [cos(alpha/2) ax*sin(alpha/2)];
end


function segmpar = mcgetsegmpar(model, segm)
% Get parameters for body segments. 
%
% syntax
% spar = mcgetsegmpar(model, segm);
%
% input parameters
% model: string indicating the body-segment model used (possible value: 'Dempster', 
%   more to be added in the future)
% segm: vector indicating numbers for each segment
%
% output
% spar: segmpar structure
%
% examples
% segmnum = [0 0 8 7 6 0 8 7 6 13 12 10 11 3 2 1 11 3 2 1];
% spar = mcgetsegmpar('Dempster', segmnum);
%
% comments
% Returns the mass relative to total body mass (spar.m), 
% relative distance of center of mass from proximal joint (spar.comprox) 
% and distal joint (spar.comdist), and radius of gyration relative to 
% center of gravity (spar.rogcg), proximal joint (spar.rogprox) and 
% distal joint (spar.rogdist) of for body segments indicated in 
% segmnum according to given body-segment model. 
%
% Segment number values for model 'Dempster': no parameter=0, hand=1, forearm=2, 
% upper arm=3, forearm and hand=4, upper extremity=5, foot=6, leg=7, thigh=8, 
% lower extremity=9, head=10, shoulder=11, thorax=12, abdomen=13, pelvis=14, 
% thorax and abdomen=15, abdomen and pelvis=16, trunk=17, head, arms and trunk 
% (to glenohumeral joint)=18, head, arms and trunk (to mid-rib)=19.
%
% references
% Robertson, D. G. E., Caldwell, G. E., Hamill, J., Kamen, G., & Whittlesley, S. N. (2004). 
% Research methods in biomechanics. Champaign, IL: Human Kinetics.
%
% Part of the Motion Capture Toolbox, Copyright 2008, 
% University of Jyvaskyla, Finland

segmpar=[];

if ~isletter(model)
     disp([10, 'First input argument has to be a string.', 10]);
     [y,fs] = audioread('mcsound.wav');
     sound(y,fs);
     return
end
if ~isnumeric(segm)
     disp([10, 'Second input argument has to be numeric.', 10]);
     [y,fs] = audioread('mcsound.wav');
     sound(y,fs);
     return
end

if strcmp(model,'Dempster')
    md =[.006 .016 .028 .022 .05 .0145 .0465 .1 .161 .081 .0158 .216 .139 .142 .355 .281 .497 .678 .678];
    comproxd =[.506 .43 .436 .682 .53 .5 .433 .433 .447 1 .712 .82 .44 .105 .63 .27 .495 .626 1.142];
    comdistd = 1-comproxd;
    rogcgd =[.298 .303 .322 .468 .368 .475 .302 .323 .326 .495 0 0 0 0 0 0 .406 .496 .903];
    rogproxd =[.587 .526 .542 .827 .645 .69 .528 .54 .56 1.116 0 0 0 0 0 0 .64 .798 1.456];
    rogdistd =[.577 .647 .645 .565 .596 .69 .643 .653 .65 .495 0 0 0 0 0 0 .648 .621 .914];
    
    segmpar.type = 'segmpar';
    segmpar.m=zeros(1,length(segm)); segmpar.m(find(segm>0))=md(segm(find(segm>0)));
    segmpar.comprox=zeros(1,length(segm)); segmpar.comprox(find(segm>0))=comproxd(segm(find(segm>0)));
    segmpar.comdist=zeros(1,length(segm)); segmpar.comdist(find(segm>0))=comdistd(segm(find(segm>0)));
    segmpar.rogcg=zeros(1,length(segm)); segmpar.rogcg(find(segm>0))=rogcgd(segm(find(segm>0)));
    segmpar.rogprox=zeros(1,length(segm)); segmpar.rogprox(find(segm>0))=rogproxd(segm(find(segm>0)));
    segmpar.rogdist=zeros(1,length(segm)); segmpar.rogdist(find(segm>0))=rogdistd(segm(find(segm>0)));
else
    disp([10, 'Unknown model: ' model])
    disp(['Models included: Dempster. Please choose this one.', 10])
    [y,fs] = audioread('mcsound.wav');
    sound(y,fs);
end
