%% Part 5
clear
close all
opengl('software')

%% Initialize Matrices (C matrix updated from additional capactitor)
%% Part 5 (a/b)
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

C_n = 0.00001;

%X = [V1,V2,IL,V3,V4,V0]

G =[1   0          0  0          0   0;
    G_1 -(G_1+G_2) -1 0          0   0;
    0   -1         0  1          0   0;
    0   0          1  -G_3       0   0;
    0   0          0  -alpha*G_3 1   0;
    0   0          0  0          G_4 -(G_4+G_0)];


C =[0         0          0 0    0 0;
    Capacitor -Capacitor 0 0    0 0;
    0         0          L 0    0 0;
    0         0          0 -C_n 0 0;
    0         0          0 0    0 0;
    0         0          0 0    0 0];

F = [Vin;0;0;0;0;0];

%% Part 5 (c)
In = 0.1;

steps=1000;
dt=0.001;
V_gauss=zeros(6,steps);
V_old = zeros(6,1);
GaussPulse = zeros(6,1);
for i = 1:steps
    GaussPulse(1) =  exp(-((i*dt-0.06)/(0.03))^2);
    GaussPulse(3) = In*normrnd(0,1);
    V_gauss(:,i) = (C./dt+G)\(GaussPulse+C*V_old/dt);
    V_old = V_gauss(:, i);
end
%% V0 with noise source
figure;
plot(1:steps, V_gauss(6,:),1:steps, V_gauss(1,:))
title('Vin and V0 with a guassian pulse and noise source')
xlabel('Time (ms)')
ylabel('Voltage (V)')
legend('V0','Vin')

%% Spectrum of output
figure;
fourier_output = abs(fftshift(fft(V_gauss(6,:))));
fourier_input = abs(fftshift(fft(V_gauss(1,:))));
plot(((1:length(fourier_output))/steps)-0.5,fourier_output,((1:length(fourier_input))/steps)-0.5,fourier_input);
title('Gauss Function with Noise Source Fourier Transform')
xlabel('Frequency (Hz)')
ylabel('Voltage (V)')
legend('V0','Vin');

%% V0 with Cn = 0.001
In = 0.01;
C(4,4) = -0.001;
steps=1000;
dt=0.001;
V_gauss=zeros(6,steps);
V_old = zeros(6,1);
GaussPulse = zeros(6,1);
for i = 1:steps
    GaussPulse(1) =  exp(-((i*dt-0.06)/(0.03))^2);
    GaussPulse(3) = In*normrnd(0,1);
    V_gauss(:,i) = (C./dt+G)\(GaussPulse+C*V_old/dt);
    V_old = V_gauss(:, i);
end
figure;
plot(1:steps, V_gauss(6,:),1:steps, V_gauss(1,:))
title('Vin and V0 with Cn=0.001')
xlabel('Time (ms)')
ylabel('Voltage (V)')
legend('V0','Vin')

%% V0 with Cn = 0.01
In = 0.01;
C(4,4) = -0.01;
steps=1000;
dt=0.001;
V_gauss=zeros(6,steps);
V_old = zeros(6,1);
GaussPulse = zeros(6,1);
for i = 1:steps
    GaussPulse(1) =  exp(-((i*dt-0.06)/(0.03))^2);
    GaussPulse(3) = In*normrnd(0,1);
    V_gauss(:,i) = (C./dt+G)\(GaussPulse+C*V_old/dt);
    V_old = V_gauss(:, i);
end
figure;
plot(1:steps, V_gauss(6,:),1:steps, V_gauss(1,:))
title('Vin and V0 with Cn=0.01')
xlabel('Time (ms)')
ylabel('Voltage (V)')
legend('V0','Vin')
%% V0 with Cn = 0.1
In = 0.01;
C(4,4) = -0.1;
steps=1000;
dt=0.001;
V_gauss=zeros(6,steps);
V_old = zeros(6,1);
GaussPulse = zeros(6,1);
for i = 1:steps
    GaussPulse(1) =  exp(-((i*dt-0.06)/(0.03))^2);
    GaussPulse(3) = In*normrnd(0,1);
    V_gauss(:,i) = (C./dt+G)\(GaussPulse+C*V_old/dt);
    V_old = V_gauss(:, i);
end
figure;
plot(1:steps, V_gauss(6,:),1:steps, V_gauss(1,:))
title('Vin and V0 with Cn=0.1')
xlabel('Time (ms)')
ylabel('Voltage (V)')
legend('V0','Vin')
%% V0 with time step = 0.0005
In = 0.0001;
C(4,4) = -0.00001;
steps=1000;
dt=0.0005;
V_gauss=zeros(6,steps);
V_old = zeros(6,1);
GaussPulse = zeros(6,1);
for i = 1:steps
    GaussPulse(1) =  exp(-((i*dt-0.06)/(0.03))^2);
    GaussPulse(3) = In*normrnd(0,1);
    V_gauss(:,i) = (C./dt+G)\(GaussPulse+C*V_old/dt);
    V_old = V_gauss(:, i);
end
figure;
plot(1:steps, V_gauss(6,:),1:steps, V_gauss(1,:))
title('Vin and V0 with timestep=0.0005 (default 0.001)')
xlabel('Time (ms)')
ylabel('Voltage (V)')
legend('V0','Vin')

%% V0 with time step = 0.0001
In = 0.0001;
C(4,4) = -0.00001;
steps=1000;
dt=0.0001;
V_gauss=zeros(6,steps);
V_old = zeros(6,1);
GaussPulse = zeros(6,1);
for i = 1:steps
    GaussPulse(1) =  exp(-((i*dt-0.06)/(0.03))^2);
    GaussPulse(3) = In*normrnd(0,1);
    V_gauss(:,i) = (C./dt+G)\(GaussPulse+C*V_old/dt);
    V_old = V_gauss(:, i);
end
figure;
plot(1:steps, V_gauss(6,:),1:steps, V_gauss(1,:))
title('Vin and V0 with timestep=0.0001')
xlabel('Time (ms)')
ylabel('Voltage (V)')
legend('V0','Vin')
