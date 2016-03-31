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

Driver1 = driver1';
Driver1 = Driver1(1:19,:);
Driver2 = driver2';
Driver2 = Driver2(1:19,:);
Driver3 = driver3';
Driver3 = Driver3(1:19,:);
Driver4 = driver4';
Driver4 = Driver4(1:19,:);



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



%% try svm

%load iris data
load fisheriris;
data=meas;

%prepare test set and training set
% trainset=[data(1:20,:);data(51:70,:);data(101:120,:)];
% testset=[data(21:50,:);data(71:100,:);data(121:150,:)];
% trainset =[Driver1(1:5,:); Driver2(1:5,:); Driver3(1:5,:); Driver4(1:5,:)];
% testset =[Driver1(6:10,:); Driver2(6:10,:); Driver3(6:10,:); Driver4(6:10,:)];

good_count = 0;
all_count = 0;
for index = 1:18
    driver1_train = [Driver1(1:index - 1, :); Driver1( (index + 2) : end, :)];
    driver1_test = Driver1( index : index + 1, :);
    
    driver2_train = [Driver2(1:index - 1, :); Driver2( (index + 2) : end, :)];
    driver2_test = Driver2( index : index + 1, :);
    
    driver3_train = [Driver3(1:index - 1, :); Driver3( (index + 2) : end, :)];
    driver3_test = Driver3( index : index + 1, :);
    
    train_set_size = 17;
    test_set_size = 2;
    
    train_set = [driver1_train; driver2_train; driver3_train];
    test_set = [driver1_test; driver2_test; driver3_test];
    
    class=zeros(3*train_set_size,1);
    class(1:train_set_size,1)=1;
    class(train_set_size + 1:end,1)=100;
    
    %perform first run of svm
    SVMStruct = svmtrain(train_set,class);
    Group = svmclassify(SVMStruct,test_set);
    
    class1=zeros(3*train_set_size,1);
    class1(1: 2 * train_set_size,1)=100;
    class1(2 * train_set_size + 1:end,1)=3;
    
    %perform first run of svm
    SVMStruct1 = svmtrain(train_set,class1);
    Group1 = svmclassify(SVMStruct1,test_set);
    
    %prepare final class label
    GroupF=zeros(6,1);
    for i=1:6
        if Group(i,1)==1
            GroupF(i,1)=1;
        else
            if Group1(i,1)==3
                GroupF(i,1)=3;
            else
                GroupF(i,1) = 2;
            end
        end
    end
    
    
    GroupGood = [1, 1, 2, 2, 3, 3];
    GroupGood = GroupGood';
    
    for i = 1:6
        if GroupF(i,1) == GroupGood(i,1)
            good_count = good_count + 1;
        end
        all_count = all_count + 1;
    end
    
    
end

perc = good_count / all_count

%%
