
%% Part 3
clear
close all
opengl('software')

%% 3(a)
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


%X = [V1,V2,IL,V3,V4,V0]

G =[1   0          0  0          0   0;
    G_1 -(G_1+G_2) -1 0          0   0;
    0   -1         0  1          0   0;
    0   0          1  -G_3       0   0;
    0   0          0  -alpha*G_3 1   0;
    0   0          0  0          G_4 -(G_4+G_0)];


C =[0         0          0 0 0 0;
    Capacitor -Capacitor 0 0 0 0;
    0         0          L 0 0 0;
    0         0          0 0 0 0;
    0         0          0 0 0 0;
    0         0          0 0 0 0];
%F = [Vin;0;0;0;0;0];
%% 3(b)-i. DC case sweep
i = 1;
V3 = zeros(6,1);
V0 = zeros(6,1);
VsweepDC = zeros(6,1);
for Vin = -10:0.1:10
    i = i+1;
    F = [Vin;0;0;0;0;0];
    V=G\F;
    VsweepDC(i) = Vin;
    V3(i) = V(4);
    V0(i) = V(6);
end
figure;
plot(VsweepDC,V3);
hold on
plot(VsweepDC,V0);
title('DC case sweep: V0/V3 as a function of input voltage')
xlabel('Input Voltage')
ylabel('Output Voltage(V)')
legend('V3','V0')

%% Part 3(b)-ii. AC case sweep
w = logspace(0,5,50000);
F(1) = 1;
for i = 1:length(w)
    V = (G+1j*w(i)*C)\F;
    VsweepAC(i) = abs(V(6));
    gain(i) = 20*log(abs(V(6))/F(1));
end
figure;
semilogx(w, VsweepAC)
title('AC case sweep: VO as a function of w')
xlabel('log(w)')
ylabel('VO(V)')

figure;
semilogx(w, gain)
title('Gain VO/Vin as a function of w')
xlabel('log(w)')
ylabel('Gain(dB)')


%% 3(b)-iii. gain as function of random perturbations on C
std = 0.05;
w=pi;
size = 1000;
GainHisto = [];
RandomizeCapacitor = std.*randn(size,1) + Capacitor;
for n=1:size
    C(2,1)= RandomizeCapacitor(n);
    C(2,2)= -RandomizeCapacitor(n);
    V = (G+1j*w*C)\F;
    GainHisto = [GainHisto 20*log10(abs(V(5)/F(1)))];
end

figure;
histogram(GainHisto);
title('Histogram of the gain as function of random perturbations on C')
xlabel('Gain')
ylabel('Counts')