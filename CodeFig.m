EncoderFig1=[10 55; 20 55; 20 60; 50 60; 50 50; 20 50; 20 55];
EncoderFig2=[30 50; 30 60];
EncoderFig3=[40 50; 40 60];

EncoderFig4=[25 60; 25 70; 45 70; 70 70];
EncoderFig5=[45 60; 45 70];

EncoderFig6=[25 50; 25 40; 70 40];
EncoderFig7=[35 50; 35 40];
EncoderFig8=[45 50; 45 40];

%subplot(211), 
plot(EncoderFig1(:,1), EncoderFig1(:,2)); 
axis([0 130 10 80])
hold on
plot(EncoderFig2(:,1), EncoderFig2(:,2));
plot(EncoderFig3(:,1), EncoderFig3(:,2));
plot(EncoderFig4(:,1), EncoderFig4(:,2));
plot(EncoderFig5(:,1), EncoderFig5(:,2));
plot(EncoderFig6(:,1), EncoderFig6(:,2));
plot(EncoderFig7(:,1), EncoderFig7(:,2));
plot(EncoderFig8(:,1), EncoderFig8(:,2));
text(1,55, 'm(t)');
text(75, 40, 'u2(t)');
text(75, 70, 'u1(t)');
text(45,70, '+');
text(35,40,'+'); text(45,40,'+');
text(20,55,'>'); text(70,40,'>'); text(70,70,'>');
%text(45,70,'^'); 
text(45,70,'>');
%text(35,40,'v'); 
text(35,40,'>'); 
%text(45,40,'v');

text(26,45,'R0'); text(36,45,'R1'); text(46,45,'R2');

% trellis
bax=100; bay=10;
plot((bax+10)*ones(4,1), bay+(10:10:40),'bo');
plot((bax+20)*ones(4,1), bay+(10:10:40),'go');
bax1=bax+[10 20];
plot(bax1, bay+[40 40], 'b-');
plot(bax1, bay+[40 30], 'g--');
plot(bax1, bay+[30 20], 'b-');
plot(bax1, bay+[30 10], 'g--');

plot(bax1, bay+[20 40], 'b-');
plot(bax1, bay+[20 30], 'g--');
plot(bax1, bay+[10 20], 'b-');
plot(bax1, bay+[10 10], 'g--');

text(bax-10,bay+50,'State:[R1,R2]');
text(bax-5,bay+40,'[0 0]');
text(bax-5,bay+30,'[1 0]');
text(bax-5,bay+20,'[0 1]');
text(bax-5,bay+10,'[1 1]');

text(bax+14,bay+50,'NewState:[R0,R1]');
text(bax+22,bay+40,'[0 0]');
text(bax+22,bay+30,'[1 0]');
text(bax+22,bay+20,'[0 1]');
text(bax+22,bay+10,'[1 1]');

text(bax+3, bay+55,'R0, output[u1 u2]');
text(bax+3,bay+45,'0,   [00]');
text(bax+3,bay+38,'1,   [11]');
text(bax+3,bay+33,'0,   [01]');
text(bax+3,bay+28,'1,   [10]');
text(bax+3,bay+23,'0,   [11]');
text(bax+3,bay+18,'1,   [00]');
text(bax+3,bay+13,'0,   [10]');
text(bax+3,bay+8,'1,   [01]');

%hold off
