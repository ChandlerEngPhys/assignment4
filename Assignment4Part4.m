
%% Part 4
clear
close all
opengl('software')

%% Part 4 (a)
% By inspection this circuit appears to be a low pass filter because the
% gain and output voltage is high at low frequencies. The gain/output
% voltage approach zero as the frequency increases.

%% Part 4 (b)
% Since this is a low pass filter we would expect the frequency to repond
% by being rejected/attenuated at higher frequencies while allowing the low frequencies
% to pass
%% Initialize Matrices
R_1= 1;
Capacitor = 0.25;
R_2 = 2;
L = 0.2;
R_3 = 10;
alpha = 100;
R_4 = 0.1;
R_0 = 1000;

G_1 = 1/R_1;
G_2 = 1/R_2;
G_3 = 1/R_3;
G_4 = 1/R_4;
G_0 = 1/R_0;

Vin = 1;


%X = [V1,V2,IL,V3,V4,V0]

G = [1 0 0 0 0 0;
    G_1 -(G_1+G_2) -1 0 0 0;
    0 -1 0 1 0 0;
    0 0 1 -G_3 0 0;
    0 0 0 -alpha*G_3 1 0;
    0 0 0 0 G_4 -(G_4+G_0)];


C = [0 0 0 0 0 0;
    Capacitor -Capacitor 0 0 0 0;
    0 0 L 0 0 0;
    0 0 0 0 0 0;
    0 0 0 0 0 0;
    0 0 0 0 0 0];

F = [Vin;0;0;0;0;0];

%% Part 4 (d)-iii.A. Step function output
steps=1000;
dt=0.001;
V_step=zeros(6,steps);
V_zero=zeros(6,1);
V_old = zeros(6,1);
for i = 1:steps
    
    if i < 30
        V_step(:,i) = (C./dt+G)\(0+C*V_zero/dt);
    elseif i == 30
        V_step(:,i) = (C./dt+G)\(F+C*V_zero/dt);
    else
        V_step(:,i) = (C./dt+G)\(F+C*V_old/dt);
    end
    V_old = V_step(:, i);
    
end

figure;
plot(1:steps, V_step(6,:),1:steps, V_step(1,:))
title('Vin and VO using timestep at 0.03s')
xlabel('Time (ms)')
ylabel('Voltage (V)')
legend('V0','Vin')
%% Part 4 (d)-iii.B. Sine function output
V_sine=zeros(6,steps);
V_old = zeros(6,1);
freq = zeros(6,1);
for i = 1 : steps
    freq(1) = sin(2*pi*(1/0.03)*i/steps);
    V_sine(:,i) = (C./dt+G)\(freq+C*V_old/dt);
    V_old = V_sine(:, i);
end

figure;
plot(1:steps, V_sine(6,:),1:steps, V_sine(1,:))
title('Vin and VO using function sin(2pift)')
xlabel('Time (ms)')
ylabel('Voltage (V)')
legend('V0','Vin')

%% Part 4 (d)-iii.C. Gauss function output
V_gauss=zeros(6,steps);
V_old = zeros(6,1);
GaussPulse = zeros(6,1);
for i = 1:steps
    GaussPulse(1) =  exp(-((i*dt-0.06)/(0.03))^2);
    V_gauss(:,i) = (C./dt+G)\(GaussPulse+C*V_old/dt);
    V_old = V_gauss(:, i);
end

figure;
plot(1:steps, V_gauss(6,:),1:steps, V_gauss(1,:))
title('Vin and V0 with a guassian pulse')
xlabel('Time (ms)')
ylabel('Voltage (V)')
legend('V0','Vin')

%% Part 4 (d)-iv.A. Step function Fourier Transform
figure;
fourier_output = abs(fftshift(fft(V_step(6,:))));
fourier_input = abs(fftshift(fft(V_step(1,:))));
plot(((1:length(fourier_output))/steps)-0.5,fourier_output,((1:length(fourier_input))/steps)-0.5,fourier_input);
title('Step Function Fourier Transform')
xlabel('Frequency (Hz)')
ylabel('Voltage (V)')
legend('V0','Vin');
%% Part 4 (d)-iv.B. Sine function Fourier Transform
figure;
fourier_output = abs(fftshift(fft(V_sine(6,:))));
fourier_input = abs(fftshift(fft(V_sine(1,:))));
plot(((1:length(fourier_output))/steps)-0.5,fourier_output,((1:length(fourier_input))/steps)-0.5,fourier_input);
title('Sine Function Fourier Transform')
xlabel('Frequency (Hz)')
ylabel('Voltage (V)')
legend('V0','Vin');
%% Part 4 (d)-iv.C. Gauss function Fourier Transform
figure;
fourier_output = abs(fftshift(fft(V_gauss(6,:))));
fourier_input = abs(fftshift(fft(V_gauss(1,:))));
plot(((1:length(fourier_output))/steps)-0.5,fourier_output,((1:length(fourier_input))/steps)-0.5,fourier_input);
title('Gauss Function Fourier Transform')
xlabel('Frequency (Hz)')
ylabel('Voltage (V)')
legend('V0','Vin');

%end