%% read data
clc,close all, clear all

driver1 = csvread('driver1_speed.txt');
driver2 = csvread('driver2_speed.txt');
driver3 = csvread('driver3_speed.txt');
driver4 = csvread('driver4_speed.txt');
driver5 = csvread('driver5_speed.txt');
driver6 = csvread('driver6_speed.txt');
driver7 = csvread('driver7_speed.txt');
driver8 = csvread('driver8_speed.txt');
driver9 = csvread('driver9_speed.txt');
driver10 = csvread('driver10_speed.txt');


%% multi class svm

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

%TrainingSet = [driver1 driver2 driver3 driver4 driver5 driver6 driver7 driver8 driver9 driver10]';
%target = [ones(1, size1) 2*ones(1,size2) 3*ones(1, size3) 4*ones(1, size4) 5*ones(1, size5) 6*ones(1, size6) 7*ones(1, size7) 8*ones(1, size8) 9*ones(1, size9) 10*ones(1, size10)];


% choose features here
rowNums = [2 3 4 5 6 8];
rows = length(rowNums);

driver1_refined = [];
for i = 1:rows
    driver1_refined = [driver1_refined; driver1(i,:)];
end

driver2_refined = [];
for i = 1:rows
    driver2_refined = [driver2_refined; driver2(i,:)];
end

driver3_refined = [];
for i = 1:rows
    driver3_refined = [driver3_refined; driver3(i,:)];
end

driver4_refined = [];
for i = 1:rows
    driver4_refined = [driver4_refined; driver4(i,:)];
end

driver5_refined = [];
for i = 1:rows
    driver5_refined = [driver5_refined; driver5(i,:)];
end

driver6_refined = [];
for i = 1:rows
    driver6_refined = [driver6_refined; driver6(i,:)];
end

driver7_refined = [];
for i = 1:rows
    driver7_refined = [driver7_refined; driver7(i,:)];
end

driver8_refined = [];
for i = 1:rows
    driver8_refined = [driver8_refined; driver8(i,:)];
end

driver9_refined = [];
for i = 1:rows
    driver9_refined = [driver9_refined; driver9(i,:)];
end

driver10_refined = [];
for i = 1:rows
    driver10_refined = [driver10_refined; driver10(i,:)];
end


% TrainingSet = [driver1_refined driver2_refined driver3_refined driver4_refined]';
% target = [ones(1, size1) 2*ones(1,size2) 3*ones(1, size3) 4*ones(1, size4)];

TrainingSet = [driver1_refined driver2_refined driver3_refined driver4_refined driver5_refined driver6_refined driver7_refined driver8_refined driver9_refined driver10_refined]';
target = [ones(1, size1) 2*ones(1,size2) 3*ones(1, size3) 4*ones(1, size4) 5*ones(1, size5) 6*ones(1, size6) 7*ones(1, size7) 8*ones(1, size8) 9*ones(1, size9) 10*ones(1, size10)];



%% train and test using for loop

data_size = length(TrainingSet); 
count = 0;
tot_num = 0;
predict = zeros(1,data_size);

for index = 1:data_size
    training_set = [TrainingSet(1:index - 1,:); TrainingSet(index + 1:end,:)];
    test_set = TrainingSet(index,:);
    target_set = [target(1:index - 1) target(index + 1:end)];
    [result] = multisvm(training_set, target_set, test_set);
    
    predict(index) = result;
    
    if result == target(index)
        count = count + 1;
    end
    tot_num = tot_num + 1;
end

count
tot_num

correct = count / tot_num

compare = [target; predict];





