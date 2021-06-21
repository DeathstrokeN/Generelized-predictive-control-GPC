%% by Bellila Ahmed Nassim, student at ENST
%On exchange at Université Laval
%Course UL GEL-7029 Prictive control under supervision of Prof. André Desbiens

%see Readme.txt to understand more the process

%Basic GPC

clc, clear all;
%%
Ts=1; %sampling period
N=100; %simulated points
Gd=tf([0.4],[1 -.8 0],Ts) %0.4z^-2/1-0.8z^-1 = 0.4/z^2 - 0.8z
num=[Gd.num{:}(2:end) 0] 
den=Gd.den{:}

%%
r=[0; 0; 0; 1*ones(N-3,1)]; % Set-point
w=[zeros(50,1); 2*ones(N-50,1)]; 


%%
Gu=[0 0 0; 0.4 0 0; 0.72 0.4 0;0.972 0.72 0.4];
Gu = Gu(:,1); %Hc unitary (can be modified but not fournished in this version)

Lambda = 0;
K = inv(Gu'*Gu + Lambda*eye(length(Gu'*Gu)))*Gu';
K = K(1,:);

%% initialisation
x=zeros(max(length(den),length(num))-1,1);
upast = 0; upast2 = 0;
y = 0; ypast = 0;

%% Simulation
for i=1:N
    [y,x]=filter(num,den,upast,x);
    y = y + w(i); %Disturbance
    f = [0.4; 0.72; 0.976;1.1808]*(upast-upast2)...
        + [1.8 -0.8;2.44 -1.44;2.952 -1.952;3.3616 -2.3616]*[y; ypast]; %free response         
    u = K*(r(i)-f) + upast; %controller
    simdata(i,1:3)=[r(i) y u];
    upast2 = upast;
    upast = u;
    ypast = y;
end


%% figures
figure(1);
t=Ts*(0:N-1);
subplot(211);
stairs(t,simdata(:,3),'k-');
ylabel('u');
title('Manipulated variable')
subplot(212);
plot(t,simdata(:,1),'k--',t,simdata(:,2),'r-');
ylabel('r (black) and y (red)');
xlabel('Time [sec]');
title('Controlled variable')