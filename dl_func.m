function [outputArg1] = dl_func(data)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
temp = [];
window = 20;

if exist('Hd','var')==1
for i = 1:size(data,1)
    temp(i,:) = filter(Hd,data(i,1:idivide(length(data),int16(20)*window)));
end
else
    load('Hd');
end


temp = reshape(temp,[size(data,1) 20 1 length(temp)/window]);

if exist('net','var')==1
    YTest = classify(net, temp);
else
    load('learned_model.mat');
    YTest = classify(net, temp);
end




outputArg1 = temp;

end

