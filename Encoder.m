%Encoder and Illustration

nt=[0 0 mt 0 0];  % append zeros to flush registers
N=length(nt)-2;
out=zeros(1,N*2);  % output coded bit squence
for i=1:N
    subplot(211), hold on
    title(['Time t=' int2str(i-1)]);
    text(5,35, ['m(t)=[' int2str(mt) ']']);  % plot message bit sequence
    
    text(25,55,int2str(nt(i+2)));  % draw register values
    text(35,55,int2str(nt(i+1)));
    text(45,55,int2str(nt(i)));
    
    out(2*i)=mod([1 1 1]*nt(i:i+2)',2);  % calculate encoder output u1, u2
    out(2*i-1)=mod([1 0 1]*nt(i:i+2)',2);
    text(70,35,int2str(out(2*i)));       % draw encoder output u1, u2
    text(70,65,int2str(out(2*i-1)));
    
    text(5,28,['n(t)=[' int2str(out(1:2*i)) ']']); % plot n(t) bits
% refresh trellis: three bits in n(t) defines a trellis transitional path
    if nt(i+2:-1:i)==[0 0 0], 
        plot([bax+10 bax+20], [bay+40 bay+40],'ro-');
    elseif nt(i+2:-1:i)==[1 0 0], 
        plot([bax+10 bax+20], [bay+40 bay+30],'ro--');
    elseif nt(i+2:-1:i)==[0 1 0], 
        plot([bax+10 bax+20], [bay+30 bay+20],'ro-');
    elseif nt(i+2:-1:i)==[1 1 0], 
        plot([bax+10 bax+20], [bay+30 bay+10],'ro--'); 
    elseif nt(i+2:-1:i)==[0 0 1], 
        plot([bax+10 bax+20], [bay+20 bay+40],'ro-');
    elseif nt(i+2:-1:i)==[1 0 1], 
        plot([bax+10 bax+20], [bay+20 bay+30],'ro--');
    elseif nt(i+2:-1:i)==[0 1 1], 
        plot([bax+10 bax+20], [bay+10 bay+20],'ro-');
    elseif nt(i+2:-1:i)==[1 1 1], 
        plot([bax+10 bax+20], [bay+10 bay+10],'ro--');  
    end
    
    subplot(212), hold on
% plot trellis diagram that shows encoding and decoding procedures   
    text(3,48,'Encoder output:')
    plot(10*i*ones(4,1), 10:10:40,'ko');
    plot(10*(i+1)*ones(4,1), 10:10:40,'ko');
    ebax1=[10*i 10*(i+1)];
    plot(ebax1,[40 40],'k-'); plot(ebax1, [40 30], 'k--');
    plot(ebax1,[30 20],'k-'); plot(ebax1, [30 10], 'k--');
    plot(ebax1,[20 40],'k-'); plot(ebax1, [20 30], 'k--');
    plot(ebax1,[10 20],'k-');plot(ebax1, [10 10], 'k--');

    if nt(i+2:-1:i)==[0 0 0], plot(ebax1, [40 40],'ro-');
        text(ebax1(1)+4,48,'00');
    elseif nt(i+2:-1:i)==[1 0 0], plot(ebax1, [40 30],'ro--');
        text(ebax1(1)+4,48,'11');       
    elseif nt(i+2:-1:i)==[0 1 0], plot(ebax1, [30 20],'ro-');
               text(ebax1(1)+4,48,'01');
    elseif nt(i+2:-1:i)==[1 1 0], plot(ebax1, [30 10],'ro--'); 
               text(ebax1(1)+4,48,'10');
    elseif nt(i+2:-1:i)==[0 0 1], plot(ebax1, [20 40],'ro-');
               text(ebax1(1)+4,48,'11');
    elseif nt(i+2:-1:i)==[1 0 1], plot(ebax1, [20 30],'ro--');
               text(ebax1(1)+4,48,'00');
    elseif nt(i+2:-1:i)==[0 1 1], plot(ebax1, [10 20],'ro-');
               text(ebax1(1)+4,48,'10');
    elseif nt(i+2:-1:i)==[1 1 1], plot(ebax1, [10 10],'ro--');  
               text(ebax1(1)+4,48,'01');
    end

    pause
    
% redraw fig 1
    if i<N, subplot(211), hold off, CodeFig, end
    
end    
subplot(211), hold off
subplot(212), hold off
