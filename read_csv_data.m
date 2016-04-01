clc
clear all
close all
M = csvread('some_file.csv',2,0);
pid = M(:,1);
pid_val = M(:,2);
lat = M(:,3);
lon = M(:,4);
time = M(:,5);

%% Shift events timing
[sorted_time,I] = sort(time);
new_pid_val = pid_val(I);

figure

k = find(pid==16);
time_jason = time(k);

size = length(k);

time_inc = zeros(1,size);
time_inc(1) = 0;


for i = 2:size
    time_inc(i) = time_jason(i) - time_jason(i-1) + time_inc(i-1);
end

set(gca, 'FontSize', 20);

plot(time_inc,pid_val(k),'.')
ylim([0 25])
ylabel('Shift event')
xlabel('Elapsed Time (ms)')

index = 1;

Pid_only_necessary = pid_val(k);
shift = zeros(1,20);

for i = 2:size
   if Pid_only_necessary(i) - Pid_only_necessary(i-1) < -8.5
       
       if index == 1
           shift(index) = time_jason(i);
           index = index + 1;
       else
           if abs(time_jason(i) - shift(index - 1)) > 15000
                shift(index) = time_jason(i);
                index = index + 1;
           end
       end

   end   
end
index = index -1
format short
shift

%% Power mode events timing
[sorted_time,I] = sort(time);
new_pid_val = pid_val(I);

figure

k = find(pid==48);
time_jason = time(k);

size = length(k);

time_inc = zeros(1,size);
time_inc(1) = 0;


for i = 2:size
    time_inc(i) = time_jason(i) - time_jason(i-1) + time_inc(i-1);
end

set(gca, 'FontSize', 20);

plot(time_inc,pid_val(k),'.')
ylim([0 5])
ylabel('Power mode event')
xlabel('Elapsed Time (ms)')


index = 1;
Pid_only_necessary = pid_val(k);
power = zeros(1,20);

for i = 2:size
   if Pid_only_necessary(i) - Pid_only_necessary(i-1) > 0 && Pid_only_necessary(i) == 3
       
       if index == 1
           power(index) = time_jason(i);
           index = index + 1;
       else
           if abs(time_jason(i) - power(index - 1)) > 15000
                power(index) = time_jason(i);
                index = index + 1;
           end
       end
       
   end
end
index = index -1
format short
power

%% Brake plotting and event
[sorted_time,I] = sort(time);
new_pid_val = pid_val(I);

figure

k = find(pid==338);
time_jason = time(k);

size = length(k);

time_inc = zeros(1,size);
time_inc(1) = 0;


for i = 2:size
    time_inc(i) = time_jason(i) - time_jason(i-1) + time_inc(i-1);
end

set(gca, 'FontSize', 20);

plot(time_inc,pid_val(k),'.')
ylim([0 100])
ylabel('Release Brake event')
xlabel('Elapsed Time (ms)')



index = 1;

Pid_only_necessary = pid_val(k);
brake = zeros(1,20);
shiftIndex = 1;

shiftIndexMax = length(shift);

brake_value = zeros(1,20);

for i = 1:size
   if time_jason(i) - shift(shiftIndex) < 50
       brake_value(shiftIndex) = Pid_only_necessary(i);
   end
    
   if time_jason(i) > shift(shiftIndex) && Pid_only_necessary(i) < 5 
       brake(index) = time_jason(i);
       shiftIndex = shiftIndex + 1;
       index = index + 1;
       if shiftIndex == shiftIndexMax + 1
           break;
       end

   end   
end

index = index -1
format short
brake

%% Door Event Number

clear doorOpen
clear doorClose
[sorted_time,I] = sort(time);
new_pid_val = pid_val(I);

figure

k = find(pid==144);
time_jason = time(k);

size = length(k);

time_inc = zeros(1,size);
time_inc(1) = 0;



for i = 2:size
    time_inc(i) = time_jason(i) - time_jason(i-1) + time_inc(i-1);
end

set(gca, 'FontSize', 20);

plot(time_inc,pid_val(k),'.k')
ylim([0 3])
ylabel('Door Open/Close')
xlabel('Elapsed Time (ms)')


time(pid_val(k)==1);

door_open_time = 0;
door_close_time = 0;
index = 1;
index2 = 1;
Pid_only_necessary = pid_val(k);
doorOpen = zeros(1,20);
doorClose = zeros(1,20);
powerIndex = 1;
doorIndex = 1;

powerIndexMax = length(power);

for i = 2:size
   if time_jason(i) < power(powerIndex) && Pid_only_necessary(i) - Pid_only_necessary(i-1) == 1
       
       doorOpen(doorIndex) = time_jason(i);
       
              
   end 
   
   if time_jason(i) < power(powerIndex) && Pid_only_necessary(i) - Pid_only_necessary(i-1) == -1
       
       doorClose(doorIndex) = time_jason(i);
       if doorClose(doorIndex) == 0
           disp('Problem')
       end
       
   end 
   
   if time_jason(i) > power(powerIndex)
       doorIndex = doorIndex + 1;
       powerIndex = powerIndex + 1;
   end
   if powerIndex == powerIndexMax + 1
       break;
   end
   

end
doorIndex = doorIndex -1
format short
doorOpen
doorClose

%% Seatbelt Event

[sorted_time,I] = sort(time);
new_pid_val = pid_val(I);

figure

k = find(pid==608);
time_jason = time(k);

size = length(k);

time_inc = zeros(1,size);
time_inc(1) = 0;

for i = 2:size
    time_inc(i) = time_jason(i) - time_jason(i-1) + time_inc(i-1);
end

set(gca, 'FontSize', 20);

plot(time_inc,pid_val(k),'.')
ylim([0 1.5])
ylabel('Seatbelt (Degree)')
xlabel('Elapsed Time (ms)')

seatbelt = time_jason;
seatbeltSize = length(seatbelt);


%% find out the time difference
doorOpenSize = length(doorOpen);

doorOpenTimeD = zeros(1,doorOpenSize - 1);
for i = 1:doorOpenSize - 1
    doorOpenTimeD(i) = doorOpen(i + 1) - doorOpen(i);
end
doorOpenTimeD

doorCloseTimeD = zeros(1,doorOpenSize - 1);
for i = 1:doorOpenSize - 1
    doorCloseTimeD(i) = doorClose(i + 1) - doorClose(i);
end
doorCloseTimeD


shiftSize = length(shift);
clear zeros;
shiftTimeD = zeros(1, shiftSize - 1);
for i = 1:shiftSize - 1
    shiftTimeD(i) = shift(i + 1) - shift(i);
end
shiftTimeD

powerSize = length(power);
clear zeros;
powerTimeD = zeros(1, powerSize - 1);
for i = 1:powerSize - 1
    powerTimeD(i) = power(i + 1) - power(i);
end
powerTimeD

brakeSize = length(brake);
clear zeros;
brakeTimeD = zeros(1, brakeSize - 1);
for i = 1:brakeSize - 1
    brakeTimeD(i) = brake(i + 1) - brake(i);
end
brakeTimeD


%% try to plot the event timing

figure
x = ones(1, brakeSize);
y = ones(1, powerSize);
z = ones(1, seatbeltSize);
plot(doorOpen, y, 'go',...
     doorClose, y, '.b',...
     power, y, 'mx', ...
     shift, x, 'r+',...
     brake, x, 'ks',...
     seatbelt, z, 'cd',...
     'MarkerSize', 10)
legend('DO','DC','P','S','B', 'SB')
% plot(shift, x, 'r+',...
%     'MarkerSize', 10)


%% extract features
clear dataPoints
dataPoints = zeros(1,6);

doorOpenIndex = 1;
doorCloseIndex = 1;
seatbeltIndex = 1;
powerIndex = 1;
shiftIndex = 1;
brakeIndex = 1;
threshold = 30000; % 10 sec

trailIndex = 1;

while doorOpenIndex <= doorOpenSize
    %get door time
    while doorClose(doorCloseIndex) < doorOpen(doorOpenIndex)
        doorCloseIndex = doorCloseIndex + 1;
    end
    
    doorTime = doorClose(doorCloseIndex) - doorOpen(doorOpenIndex);
    if doorTime > threshold
         doorOpenIndex = doorOpenIndex + 1;
         continue
    end
    dataPoints(trailIndex, 1) = doorTime;
    
    %get seatbelt time
    while seatbelt(seatbeltIndex) < doorClose(doorCloseIndex)
        seatbeltIndex = seatbeltIndex + 1;
    end
    
    seatbeltTime = seatbelt(seatbeltIndex) - doorClose(doorCloseIndex);
    if seatbeltTime > threshold
        doorOpenIndex = doorOpenIndex + 1;
        continue
    end
    dataPoints(trailIndex, 2) = seatbeltTime;
    
    
    % get power time
    while power(powerIndex) < doorClose(doorCloseIndex)
        powerIndex = powerIndex + 1;
    end
    powerTime = power(powerIndex) - seatbelt(seatbeltIndex);
    if powerTime > threshold
        doorOpenIndex = doorOpenIndex + 1;
        continue
    end
    dataPoints(trailIndex, 3) = powerTime;
    
    % get shift time
    while shift(shiftIndex) < doorClose(doorCloseIndex)
        shiftIndex = shiftIndex + 1;
    end
    shiftTime = shift(shiftIndex) - power(powerIndex);
    if shiftTime > threshold
        doorOpenIndex = doorOpenIndex + 1;
        continue
    end
    dataPoints(trailIndex, 4) = shiftTime;
    dataPoints(trailIndex, 6) = brake_value(shiftIndex);
    
    
    % get brake time
    while brake(brakeIndex) < doorClose(doorCloseIndex)
        brakeIndex = brakeIndex + 1;
    end
    brakeTime = brake(brakeIndex) - shift(shiftIndex);
    if brakeTime > threshold
        doorOpenIndex = doorOpenIndex + 1;
        continue
    end
    dataPoints(trailIndex, 5) = brakeTime;
    
    % next trail
    trailIndex = trailIndex + 1;
    doorOpenIndex = doorOpenIndex + 1;
    
end

%% separate drivers

d1Door = zeros(1);
d1Seatbelt = zeros(1);
d1Power = zeros(1);
d1Shift = zeros(1);
d1Brake = zeros(1);
d1Brake_value = zeros(1);

d2Door = zeros(1);
d2Seatbelt = zeros(1);
d2Power = zeros(1);
d2Shift = zeros(1);
d2Brake = zeros(1);
d2Brake_value = zeros(1);

index = 1;
size = length(dataPoints);

d1Index = 1;
d2Index = 1;
while index <= size
    if mod(index, 2) == 0 %driver 1
        d1Door(d1Index) = dataPoints(index, 1);
        d1Seatbelt(d1Index) = dataPoints(index, 2);
        d1Power(d1Index) = dataPoints(index, 3);
        d1Shift(d1Index) = dataPoints(index, 4);
        d1Brake(d1Index) = dataPoints(index, 5);
        d1Brake_value(d1Index) = dataPoints(index, 6);
        d1Index = d1Index + 1;
    else %driver 2
        d2Door(d2Index) = dataPoints(index, 1);
        d2Seatbelt(d2Index) = dataPoints(index, 2);
        d2Power(d2Index) = dataPoints(index, 3);
        d2Shift(d2Index) = dataPoints(index, 4);
        d2Brake(d2Index) = dataPoints(index, 5);
        d2Brake_value(d2Index) = dataPoints(index, 6);
        d2Index = d2Index + 1;
    end
    index = index + 1;
end

dataPoints


%% write the txt files

driver1 = [d1Door; d1Seatbelt; d1Power; d1Shift; d1Brake; d1Brake_value];
driver2 = [d2Door; d2Seatbelt; d2Power; d2Shift; d2Brake; d2Brake_value];

csvwrite('driver1.txt', driver1);
csvwrite('driver2.txt', driver2);


