function [output] = dl_func(path,data,model)
temp = [];
window = 20;
full_path = strcat(path,model);
for i = 1:size(data,1)
    temp(i,:) = filter(Hd,data(i,1:idivide(length(data),int16(20)*window)));
end
temp = reshape(temp,[size(data,1) 20 1 length(temp)/window]);

if exist(model,'var')==1
    YTest = classify(net, temp);
else
    load(full_path);
    YTest = classify(net, temp);
end
output = temp;
end

function Hd = Hd
% All frequency values are in Hz.
Fs = 500;  % Sampling Frequency
Fstop1 = 2.8;       % First Stopband Frequency
Fpass1 = 3;       % First Passband Frequency
Fpass2 = 30;      % Second Passband Frequency
Fstop2 = 30.1;    % Second Stopband Frequency
Astop1 = 80;      % First Stopband Attenuation (dB)
Apass  = 1;       % Passband Ripple (dB)
Astop2 = 80;      % Second Stopband Attenuation (dB)
match  = 'both';  % Band to match exactly

% Construct an FDESIGN object and call its ELLIP method.
h  = fdesign.bandpass(Fstop1, Fpass1, Fpass2, Fstop2, Astop1, Apass, ...
    Astop2, Fs);
Hd = design(h, 'ellip', 'MatchExactly', match);
end
