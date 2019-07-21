
testfile = 'ragtime.wav'

%% testing migration: mirenvelope(..., 'Filter') -> sig.envelope(..., 'Filter') 
clearvars -except testfile ;
disp('testing migration: mirenvelope(..., ''Filter'') -> sig.envelope(..., ''Filter'') '); 

a = mirenvelope(testfile, 'Filter');
b = sig.envelope(testfile, 'Filter', 'Mix');
tf = isequal(mirgetdata(a),b.getdata);

if tf == 1
   disp('test OK!'); 
else
   disp('test fail!');
end



%% testing migration: mirenvelope(..., 'Hilbert') -> sig.envelope(..., 'Hilbert') 
clearvars -except testfile ;
disp('testing migration: mirenvelope(..., ''Hilbert'') -> sig.envelope(..., ''Hilbert'') '); 
a = mirenvelope(testfile, 'Hilbert');
b = sig.envelope(testfile, 'Hilbert', 'Mix');
tf = isequal(mirgetdata(a),b.getdata);

if tf == 1
   disp('test OK!'); 
else
   disp('test fail!');
end


%% testing migration: mirenvelope(..., 'PreDecim', n) -> sig.envelope(..., 'PreDecim', n) 
clearvars -except testfile ;
disp('testing migration: mirenvelope(..., ''PreDecim'', n) -> sig.envelope(..., ''PreDecim'', n) '); 

n = 2;

a = mirenvelope(testfile, 'PreDecim', n);
b = sig.envelope(testfile, 'PreDecim', n, 'Mix');
tf = isequal(mirgetdata(a),b.getdata);

if tf == 1
   disp('test OK!'); 
else
   disp('test fail!');
end


%% testing migration: mirenvelope(..., 'Filtertype', 'IIR') -> sig.envelope(..., 'Filtertype', 'IIR') 
clearvars -except testfile ;
disp('testing migration: mirenvelope(..., ''Filtertype'', ''IIR'') -> sig.envelope(..., ''Filtertype'', ''IIR'') '); 


a = mirenvelope(testfile, 'Filtertype', 'IIR');
b = sig.envelope(testfile, 'Filtertype', 'IIR', 'Mix');
tf = isequal(mirgetdata(a),b.getdata);

if tf == 1
   disp('test OK!'); 
else
   disp('test fail!');
end


%% testing migration: mirenvelope(..., 'Tau', t) -> sig.envelope(..., 'Tau', t) 
clearvars -except testfile ;
disp('testing migration: mirenvelope(..., ''Tau'', t) -> sig.envelope(..., ''Tau'', t) '); 


t = 0.02;
a = mirenvelope(testfile, 'Tau', t);
b = sig.envelope(testfile, 'Tau', t, 'Mix');
tf = isequal(mirgetdata(a),b.getdata);

if tf == 1
   disp('test OK!'); 
else
   disp('test fail!');
end


%% testing migration: mirenvelope(..., 'Filtertype', 'HalfHann') -> sig.envelope(..., 'Filtertype', 'HalfHann') 
clearvars -except testfile ;
disp('testing migration: mirenvelope(..., ''Filtertype'', ''HalfHann'') -> sig.envelope(..., ''Filtertype'', ''HalfHann'') '); 



a = mirenvelope(testfile, 'Filtertype', 'HalfHann');
b = sig.envelope(testfile, 'Filtertype', 'HalfHann', 'Mix');
tf = isequal(mirgetdata(a),b.getdata);

if tf == 1
   disp('test OK!'); 
else
   disp('test fail!');
end


%% testing migration: mirenvelope(..., 'Filtertype', 'Butter') -> sig.envelope(..., 'Filtertype', 'Butter') 
clearvars -except testfile ;
disp('testing migration: mirenvelope(..., ''Filtertype'', ''Butter'') -> sig.envelope(..., ''Filtertype'', ''Butter'') '); 

a = mirenvelope(testfile, 'Filtertype', 'Butter');
b = sig.envelope(testfile, 'Filtertype', 'Butter', 'Mix');
tf = isequal(mirgetdata(a),b.getdata);

if tf == 1
   disp('test OK!'); 
else
   disp('test fail!');
end


%% testing migration: mirenvelope(..., 'CutOff', c) -> sig.envelope(..., 'CutOff', c) 
clearvars -except testfile ;
disp('testing migration: mirenvelope(..., ''CutOff'', c) -> sig.envelope(..., ''CutOff'', c) '); 

c = 1500;

a = mirenvelope(testfile, 'CutOff', c);
b = sig.envelope(testfile, 'CutOff', c, 'Mix');
tf = isequal(mirgetdata(a),b.getdata);

if tf == 1
   disp('test OK!'); 
else
   disp('test fail!');
end

%% testing migration: mirenvelope(..., 'PostDecim',N) -> sig.envelope(..., 'PostDecim', N) 
clearvars -except testfile ;
disp('testing migration: mirenvelope(..., ''PostDecim'', N) -> sig.envelope(..., ''PostDecim'', N) '); 


N = 16;

a = mirenvelope(testfile, 'PostDecim', N);
b = sig.envelope(testfile, 'PostDecim', N, 'Mix');
tf = isequal(mirgetdata(a),b.getdata);


if tf == 1
   disp('test OK!'); 
else
   disp('test fail!');
end


%% testing migration: mirenvelope(..., 'Spectro') -> sig.envelope(..., 'Spectro') 
clearvars -except testfile ;
disp('testing migration: mirenvelope(..., ''Spectro'') -> sig.envelope(..., ''Spectro'') '); 

a = mirenvelope(testfile, 'Spectro');
b = sig.envelope(testfile, 'Spectro', 'Mix');
tf = isequal(mirgetdata(a),b.getdata);

if tf == 1
   disp('test OK!'); 
else
   disp('test fail!');
end


%% testing migration: mirenvelope with sig.envelope with Frame, b='Freq'

% clearvars -except testfile ;
% disp('testing migration: mirenvelope with sig.envelope with Frame, b=''Freq''');
% 
% b = 'Freq';
% 
% a = mirenvelope(testfile, 'Frame', .1, 's', .1, '/1','Window','hanning',b);
% b = sig.envelope(testfile, 'Frame', 1, 's', 1, '/1','Window','hanning',b, 'Power');
% tf = isequal(mirgetdata(a),b.getdata);
% 
% if tf == 1
%    disp('test OK!'); 
% else
%    disp('test fail!');
% end

%% testing migration: mirenvelope(..., 'Frame') -> sig.envelope(..., 'Frame') 
clearvars -except testfile ;
disp('testing migration: mirenvelope(..., ''Frame'') -> sig.envelope(..., ''Frame'') '); 

clearvars -except testfile ;
disp('testing migration: mirenvelope with sig.envelope with Frame');

a = mirenvelope(testfile, 'Frame');
b = sig.envelope(testfile, 'Frame', 'Mix');
tf = isequal(mirgetdata(a),b.getdata);

if tf == 1
   disp('test OK!'); 
else
   disp('test fail!');
end

%% testing migration: mirenvelope(..., 'UpSample', N) -> sig.envelope(..., 'UpSample', N) 
clearvars -except testfile ;
disp('testing migration: mirenvelope(..., ''UpSample'', N) -> sig.envelope(..., ''UpSample'', N) '); 

N = 2;

a = mirenvelope(testfile, 'UpSample',N);
b = sig.envelope(testfile, 'UpSample',N, 'Mix');
tf = isequal(mirgetdata(a),b.getdata);

if tf == 1
   disp('test OK!'); 
else
   disp('test fail!');
end


%% testing migration: mirenvelope(..., 'Complex') -> sig.envelope(..., 'Complex') 
clearvars -except testfile ;
disp('testing migration: mirenvelope(..., ''Complex'') -> sig.envelope(..., ''Complex'') '); 

a = mirenvelope(testfile, 'Complex');
b = sig.envelope(testfile, 'Complex', 'Mix');
tf = isequal(mirgetdata(a),b.getdata);

if tf == 1
   disp('test OK!'); 
else
   disp('test fail!');
end

%% testing migration: mirenvelope(..., 'PowerSpectrum') -> sig.envelope(..., 'PowerSpectrum') 
clearvars -except testfile ;
disp('testing migration: mirenvelope(..., ''PowerSpectrum'') -> sig.envelope(..., ''PowerSpectrum'') '); 

a = mirenvelope(testfile, 'PowerSpectrum');
b = sig.envelope(testfile, 'PowerSpectrum', 'Mix');
tf = isequal(mirgetdata(a),b.getdata);

if tf == 1
   disp('test OK!'); 
else
   disp('test fail!');
end


%% testing migration: mirenvelope(..., 'TimeSmooth', n) -> sig.envelope(..., 'TimeSmooth', n) 
clearvars -except testfile ;
disp('testing migration: mirenvelope(..., ''TimeSmooth'', n) -> sig.envelope(..., ''TimeSmooth'', n) '); 

n = 0;

a = mirenvelope(testfile, 'TimeSmooth', n);
b = sig.envelope(testfile, 'TimeSmooth', n, 'Mix');
tf = isequal(mirgetdata(a),b.getdata);

if tf == 1
   disp('test OK!'); 
else
   disp('test fail!');
end


%% testing migration: mirenvelope(..., 'Sampling', r) -> sig.envelope(..., 'Sampling', r) 
clearvars -except testfile ;
disp('testing migration: mirenvelope(..., ''Sampling'', r) -> sig.envelope(..., ''Sampling'', r) '); 


r = 2000; %rate in Hz

a = mirenvelope(testfile, 'Sampling', r);
b = sig.envelope(testfile, 'Sampling', r, 'Mix');
tf = isequal(mirgetdata(a),b.getdata);

if tf == 1
   disp('test OK!'); 
else
   disp('test fail!');
end


%% testing migration: mirenvelope(..., 'Halfwave') -> sig.envelope(..., 'Halfwave') 
clearvars -except testfile ;
disp('testing migration: mirenvelope(..., ''Halfwave'') -> sig.envelope(..., ''Halfwave'') '); 

a = mirenvelope(testfile, 'Halfwave');
b = sig.envelope(testfile, 'Halfwave', 'Mix');
tf = isequal(mirgetdata(a),b.getdata);

if tf == 1
   disp('test OK!'); 
else
   disp('test fail!');
end


%% testing migration: mirenvelope(..., 'Center') -> sig.envelope(..., 'Center') 
clearvars -except testfile ;
disp('testing migration: mirenvelope(..., ''Center'') -> sig.envelope(..., ''Center'') '); 

a = mirenvelope(testfile, 'Center');
b = sig.envelope(testfile, 'Center', 'Mix');
tf = isequal(mirgetdata(a),b.getdata);

if tf == 1
   disp('test OK!'); 
else
   disp('test fail!');
end


%% testing migration: mirenvelope(..., 'HalfwaveCenter') -> sig.envelope(..., 'HalfwaveCenter') 
clearvars -except testfile ;
disp('testing migration: mirenvelope(..., ''HalfwaveCenter'') -> sig.envelope(..., ''HalfwaveCenter'') '); 

a = mirenvelope(testfile, 'HalfwaveCenter');
b = sig.envelope(testfile, 'HalfwaveCenter', 'Mix');
tf = isequal(mirgetdata(a),b.getdata);

if tf == 1
   disp('test OK!'); 
else
   disp('test fail!');
end


%% testing migration: mirenvelope(..., 'Log') -> sig.envelope(..., 'Log') 
clearvars -except testfile ;
disp('testing migration: mirenvelope(..., ''Log'') -> sig.envelope(..., ''Log'') '); 

a = mirenvelope(testfile, 'Log');
b = sig.envelope(testfile, 'Log', 'Mix');
tf = isequal(mirgetdata(a),b.getdata);

if tf == 1
   disp('test OK!'); 
else
   disp('test fail!');
end


%% testing migration: mirenvelope(..., 'MinLog', ml) -> sig.envelope(..., 'MinLog', ml) 
clearvars -except testfile ;
disp('testing migration: mirenvelope(..., ''MinLog'', ml) -> sig.envelope(..., ''MinLog'', ml) '); 

ml = -24; %dB

a = mirenvelope(testfile, 'MinLog', ml);
b = sig.envelope(testfile, 'MinLog', ml, 'Mix');
tf = isequal(mirgetdata(a),b.getdata);

if tf == 1
   disp('test OK!'); 
else
   disp('test fail!');
end


%% testing migration: mirenvelope(..., 'Power') -> sig.envelope(..., 'Power') 
clearvars -except testfile ;
disp('testing migration: mirenvelope(..., ''Power'') -> sig.envelope(..., ''Power'') '); 


a = mirenvelope(testfile, 'Power');
b = sig.envelope(testfile, 'Power', 'Mix');
tf = isequal(mirgetdata(a),b.getdata);

if tf == 1
   disp('test OK!'); 
else
   disp('test fail!');
end

%% testing migration: mirenvelope(..., 'Diff') -> sig.envelope(..., 'Diff') 
clearvars -except testfile ;
disp('testing migration: mirenvelope(..., ''Diff'') -> sig.envelope(..., ''Diff'') '); 


a = mirenvelope(testfile, 'Diff');
b = sig.envelope(testfile, 'Diff', 'Mix');
tf = isequal(mirgetdata(a),b.getdata);

if tf == 1
   disp('test OK!'); 
else
   disp('test fail!');
end


%% testing migration: mirenvelope(..., 'HalfwaveDiff') -> sig.envelope(..., 'HalfwaveDiff') 
clearvars -except testfile ;
disp('testing migration: mirenvelope(..., ''HalfwaveDiff'') -> sig.envelope(..., ''HalfwaveDiff'') '); 


a = mirenvelope(testfile, 'HalfwaveDiff');
b = sig.envelope(testfile, 'HalfwaveDiff', 'Mix');
tf = isequal(mirgetdata(a),b.getdata);

if tf == 1
   disp('test OK!'); 
else
   disp('test fail!');
end


%% testing migration: mirenvelope(..., 'Normal') -> sig.envelope(..., 'Normal') 
clearvars -except testfile ;
disp('testing migration: mirenvelope(..., ''Normal'') -> sig.envelope(..., ''Normal'') '); 


a = mirenvelope(testfile, 'Normal');
b = sig.envelope(testfile, 'Normal', 'Mix');
tf = isequal(mirgetdata(a),b.getdata);

if tf == 1
   disp('test OK!'); 
else
   disp('test fail!');
end


%% testing migration: mirenvelope(..., 'Normal', 'AcrossSegments') -> sig.envelope(..., 'Normal', 'AcrossSegments') 
clearvars -except testfile ;
disp('testing migration: mirenvelope(..., ''Normal'', ''AcrossSegments'') -> sig.envelope(..., ''Normal'', ''AcrossSegments'') '); 


a = mirenvelope(testfile, 'Normal' , 'AcrossSegments');
b = sig.envelope(testfile, 'Normal', 'AcrossSegments', 'Mix');
tf = isequal(mirgetdata(a),b.getdata);

if tf == 1
   disp('test OK!'); 
else
   disp('test fail!');
end


%% testing migration: mirenvelope(..., 'Smooth', o) -> sig.envelope(..., 'Smooth', o) 
clearvars -except testfile ;
disp('testing migration: mirenvelope(..., ''Smooth'', o) -> sig.envelope(..., ''Smooth'', o) '); 

o = 30; %default is 30

a = mirenvelope(testfile, 'Smooth' , o);
b = sig.envelope(testfile, 'Smooth', o, 'Mix');
tf = isequal(mirgetdata(a),b.getdata);

if tf == 1
   disp('test OK!'); 
else
   disp('test fail!');
end


%% testing migration: mirenvelope(..., 'Gauss', o) -> sig.envelope(..., 'Gauss', o) 
clearvars -except testfile ;
disp('testing migration: mirenvelope(..., ''Gauss'', o) -> sig.envelope(..., ''Gauss'', o) '); 

o = 30; %default is 30

a = mirenvelope(testfile, 'Gauss' , o);
b = sig.envelope(testfile, 'Gauss', o, 'Mix');
tf = isequal(mirgetdata(a),b.getdata);

if tf == 1
   disp('test OK!'); 
else
   disp('test fail!');
end


