%%%%%%%%%%%%%%%%%%%%%%% Transmitter %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;
clc;
close all;
Fs=44100;
Rb=100;
Eb=1/(2*Rb); % bit energy

% Input Signal
M=5;  % number of input bits, change here to define 
k=1; n=2; K=3;  % convolution encoder 

inp='hello';
% disp('Press a key to start the transmission');
% pause
% disp('Initializing');
bin = reshape(dec2bin(inp, 8).'-'0',1,[]);
disp(bin)
mt=bin;

%code fig
figure(1);
subplot(2,1,1);
CodeFig;  % plot the code block diagram and trellis diagram

% Encoder illustration
subplot(2,1,2);
hold on
axis([0 (M+2)*10+20 0 50]);
Encoder;  % call the encoder sub-routine 

y2=out; % without noise
disp(y2);

%Barker code
bk=[0 0 0 1 1 0 1];
%bk=[1, 1, 1, 1, 1, 0, 0, 1, 1, 0, 1, 0, 1];
y3=[bk y2];

% Mapping
y3=(2*y3)-1;
p=length(y3);
t=(0:p-1)/Fs;  % t is the time with sampling interval 1/Fs
figure(2);
subplot(3,2,1);
stem(t,y3);
xlabel('Time');
ylabel('Amplitude');
title('Mapped Signal');

% Oversampling
z=((Fs/Rb)-1); % zeros insertion 
for j=1:(((z*p)-1))
    if(mod(j,z)==1)
        y4(j)=y3(((j-1)./z)+1);
    else
        y4(j)=0;
    end
end
subplot(3,2,2);
stem(1:length(y4), y4); 
xlabel('Samples');
ylabel('Amplitude');
title('Oversampled Signal');

% Root-raised cosine filter
r=0.35;      % Roll-Off Factor
t_T=(-3:(Rb/Fs):3)+1e-8;  % filter length is a couple of symbol intervals
h_t=(cos((1+r)*pi*t_T)+sin ((1-r)*pi*t_T)./(4*r*t_T))./(1-(4*r*t_T).^2);
subplot(3,2,3);
plot(t_T,h_t);
xlabel('Time');
ylabel('Amplitude');
title('Root raised cosine filter');

% Baseband modulated signal
y5=(conv(y4,h_t));
y5 = y5(length(h_t):end);
tn=(0:length(y5)-1)/Fs;  % time is sampling interval is 1/Fs
subplot(3,2,4);
plot(y5);
xlabel('Time');
ylabel('Amplitude');
title('Baseband Signal');

% Carrier Signal
Fc=1000; 
c=0.5*cos(2*pi*Fc*tn);
subplot(3,2,5);
plot(tn,c+0.5)
xlabel('Time');
ylabel('Amplitude');
title('Carrier Signal');

% Bandpass modulation
y6=y5.*c;
subplot(3,2,6);
plot(y6);
xlabel('Time');
ylabel('Amplitude');
title('Transmitted BPSK signal');

%Send transmission signal
wavplay(y6,Fs,'async'); 
txsig = wavrecord(length(y6),Fs); 
%sound(y6);

%%%%%%%%%%%%%%%%%%%%%%% Receiver %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Received signal
figure(3);
subplot(5,1,1);
plot(txsig);
xlabel('Time');
ylabel('Amplitude');
title('Received BPSK signal');

% Bandpass demodulation
Fc2=1000; % to be estimated from the carrier frequency
tn2=(0:length(y6)-1)/Fs;
c2=0.5*cos(2*pi*Fc2*tn2); % Local carrier
txsig1=transpose(txsig);
y7=txsig1.*c2;

subplot(5,1,2);
plot(y7);
xlabel('Time');
ylabel('Amplitude');
title('Recevied Bandpass Demodulated signal');

% Baseband demodulated signal
h_t = fliplr(h_t);
y7 = conv(h_t,y7);
y7 = y7(length(h_t):end);
K=100;                        
mag=zeros(1,Fs/Rb);  
for i=1:Fs/Rb            % interval has 441 samples
    mag(i)=sum(abs(y7((i-1)*K+1:1:i*(K-1)))); %1:441:44100
    mag(i)=mag(i)/K;     % find the average 
end
Pos=find(mag==max(mag)); % maximum position as optimal sampling time
y8=y7(Pos:Fs/Rb:length(y7));
subplot(5,1,3);
plot(y8);
xlabel('Time');
ylabel('Amplitude');
title('Recevied Baseband Demodulated Signal');

% Detector signal
n1=length(y8);
y9=zeros(1,n1);
for i=1:n1
    if((y8(i)+0.5)<0.5)
        y9(i)=0;
    else 
        y9(i)=1;
    end
end
shift = mod(length(h_t),10);
y9 = [y9(end-shift+1:end) y9(1:end-shift)];
subplot(5,1,4);
plot(y9);
xlabel('Time');
ylabel('Amplitude');
title('Detected Signal');


%Sampled recevied signal
subplot(5,1,5);
stem(y9);
xlabel('Time');
ylabel('Amplitude');
title('Sampled Detected Signal');

figure(4);
Decoder;% call the decoder sub-routine

xcor=xcorr(bk);
for i=1:length(xcor)
    if (xcor(i)==max(xcor))
        shift=i;
        break;
    end
end
       
%Transmitted and received
figure(5)
subplot(3,1,1);
stem(nt);
xlabel('Time');
ylabel('Amplitude');
title('Transmitted Signal');
subplot(3,1,2);
stem(bm);
xlabel('Time');
ylabel('Amplitude');
title('Received signal');
subplot(3,1,3);
stem(xcor);

nt = nt(shift+length(bk):end-shift);
bm = bm(shift+length(bk):end-shift);
be=biterr(nt,bm);
disp('Bit error=');
disp(be);
