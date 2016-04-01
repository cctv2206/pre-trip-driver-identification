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


TrainingSet = [driver1 driver2 driver3 driver4]';
target = [1*ones(1, size1) 2*ones(1,size2) 3*ones(1,size3) 4*ones(1, size4)];


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

%%


