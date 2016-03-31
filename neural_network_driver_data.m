%% read data
clc,close all, clear

driver1 = csvread('driver1.txt');
driver2 = csvread('driver2.txt');
driver3 = csvread('driver3.txt');
driver4 = csvread('driver4.txt');
driver5 = csvread('driver5.txt');
driver6 = csvread('driver6.txt');
driver7 = csvread('driver7.txt');
driver8 = csvread('driver8.txt');
driver9 = csvread('driver9.txt');
driver10 = csvread('driver10.txt');


size1 = length(driver1);
size2 = length(driver2);
size3 = length(driver3);
size4 = length(driver4);
size5 = length(driver5);
size6 = length(driver6);
size7 = length(driver7);
size8 = length(driver8);
size9 = length(driver9);
size10 = length(driver10);

minSize = min([size1, size2, size3, size4, size5, size6, size7, size8, size9, size10]);

DC1 = driver1(1,1:minSize);
SF1 = driver1(2,1:minSize);
ISU1 = driver1(3,1:minSize);
SU1 = driver1(4,1:minSize);
RB1 = driver1(5,1:minSize);

DC2 = driver2(1,1:minSize);
SF2 = driver2(2,1:minSize);
ISU2 = driver2(3,1:minSize);
SU2 = driver2(4,1:minSize);
RB2 = driver2(5,1:minSize);

DC3 = driver3(1,1:minSize);
SF3 = driver3(2,1:minSize);
ISU3 = driver3(3,1:minSize);
SU3 = driver3(4,1:minSize);
RB3 = driver3(5,1:minSize);

DC4 = driver4(1,1:minSize);
SF4 = driver4(2,1:minSize);
ISU4 = driver4(3,1:minSize);
SU4 = driver4(4,1:minSize);
RB4 = driver4(5,1:minSize);

DC5 = driver5(1,1:minSize);
SF5 = driver5(2,1:minSize);
ISU5 = driver5(3,1:minSize);
SU5 = driver5(4,1:minSize);
RB5 = driver5(5,1:minSize);

DC6 = driver6(1,1:minSize);
SF6 = driver6(2,1:minSize);
ISU6 = driver6(3,1:minSize);
SU6 = driver6(4,1:minSize);
RB6 = driver6(5,1:minSize);

DC7 = driver7(1,1:minSize);
SF7 = driver7(2,1:minSize);
ISU7 = driver7(3,1:minSize);
SU7 = driver7(4,1:minSize);
RB7 = driver7(5,1:minSize);

DC8 = driver8(1,1:minSize);
SF8 = driver8(2,1:minSize);
ISU8 = driver8(3,1:minSize);
SU8 = driver8(4,1:minSize);
RB8 = driver8(5,1:minSize);

DC9 = driver9(1,1:minSize);
SF9 = driver9(2,1:minSize);
ISU9 = driver9(3,1:minSize);
SU9 = driver9(4,1:minSize);
RB9 = driver9(5,1:minSize);

DC10 = driver10(1,1:minSize);
SF10 = driver10(2,1:minSize);
ISU10 = driver10(3,1:minSize);
SU10 = driver10(4,1:minSize);
RB10 = driver10(5,1:minSize);

%% try DC1 DC2

input = [DC1 DC2 DC3 DC4];
one_1 = ones(1, 19);
target = [one_1, zeros(1,19), zeros(1,19), zeros(1,19);...
          zeros(1,19), one_1, zeros(1,19), zeros(1,19);...
    zeros(1,19), zeros(1,19), one_1, zeros(1,19);...
    zeros(1,19), zeros(1,19), zeros(1,19), one_1];
setdemorandstream(391418381);
net = patternnet(100);
[net,tr] = train(net,input,target);

figure;
plotperform(tr)
testX = input(:,tr.testInd);
testT = target(:,tr.testInd);

testY = net(testX);
testIndices = vec2ind(testY)
figure;
plotconfusion(testT,testY)
[c,cm] = confusion(testT,testY)

fprintf('Percentage Correct Classification   : %f%%\n', 100*(1-c));
fprintf('Percentage Incorrect Classification : %f%%\n', 100*c);
figure;
plotroc(testT,testY)
%%


%% Ultimate!!!



%% Second Ultimate !!

Driver1 = [DC1 ISU1 SF1 SU1 RB1];
Driver2 = [DC2 ISU2 SF2 SU2 RB2];
Driver3 = [DC3 ISU3 SF3 SU3 RB3];
Driver4 = [DC4 ISU4 SF4 SU4 RB4];
Driver5 = [DC5 ISU5 SF5 SU5 RB5];
Driver6 = [DC6 ISU6 SF6 SU6 RB6];
Driver7 = [DC7 ISU7 SF7 SU7 RB7];
Driver8 = [DC8 ISU8 SF8 SU8 RB8];
Driver9 = [DC9 ISU9 SF9 SU9 RB9];
Driver10 = [DC10 ISU10 SF10 SU10 RB10];


out = [ones(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50);...
    zeros(1,50) ones(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50);...
    zeros(1,50) zeros(1,50) ones(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50);...
    zeros(1,50) zeros(1,50) zeros(1,50) ones(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50);...
    zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) ones(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50);...
    zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) ones(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50);...
    zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) ones(1,50) zeros(1,50) zeros(1,50) zeros(1,50);...
    zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) ones(1,50) zeros(1,50) zeros(1,50);...
    zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) ones(1,50) zeros(1,50);...
    zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) ones(1,50)];

in = [Driver1 zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50);...
    zeros(1,50) Driver2 zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50);...
    zeros(1,50) zeros(1,50) Driver3 zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50);...
    zeros(1,50) zeros(1,50) zeros(1,50) Driver4 zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50);...
    zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) Driver5 zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50);...
    zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) Driver6 zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50);...
    zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) Driver7 zeros(1,50) zeros(1,50) zeros(1,50);...
    zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) Driver8 zeros(1,50) zeros(1,50);...
    zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) Driver9 zeros(1,50);...
    zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) zeros(1,50) Driver10];

