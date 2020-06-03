% Decoder illustration
subplot(211), hold on
if norm(y9-round(y9))<0.01, text(5,21, ['z(t)=[' int2str(y9) ']']);
else text(5,21,['z(t)=[' num2str(y9,'%5.1f') ']']);
end
subplot(212), hold on
text(5,44,'Received:'); text(3, 2, 'Detected:');

% define trellis metric arrays
mu=zeros(4,N+1); ps=zeros(size(mu)); % metric, previous state
mu(1:3,1)=2*N+2;  % add for zero beginning state
dis=zeros(1,2);
text(3,37,'metric:'); text(3,34,'PreState:');
text(8,37,num2str(mu(4,1))); text(8,27,num2str(mu(3,1)));
text(8,17,num2str(mu(2,1))); text(8,7,num2str(mu(1,1)));

for i=1:N
    subplot(212), title(['Decoding Time t=' int2str(i)])
    if norm(y9-round(y9))<0.01, text(10*i+4,44, int2str(y9(2*i-1:2*i)));
    else text(10*i+4,44,num2str(y9(2*i-1:2*i),'%5.1f'));
    end
    
% State 1
    dis(1)=norm(y9(2*i-1:2*i)-[0 0])^2+mu(4,i);
    dis(2)=norm(y9(2*i-1:2*i)-[1 1])^2+mu(2,i);
    j=find(dis==min(dis));  j=j(1);
    if j==1, mu(4,i+1)=dis(j); ps(1,i+1)=1;
    else mu(4,i+1)=dis(j); ps(1,i+1)=3;
    end
    
   % illustrate paths
    subplot(211), plot(bax+[10 20],bay+[40 40],'mo-');
    plot(bax+[10 20], bay+[20 40],'mo-');
   % illustrate trellis
    subplot(212), 
    if j==1, plot([10*i 10*(i+1)],[40 40],'mo-');
    else plot([10*i 10*(i+1)],[20 40],'mo-');
    end
    text(10*i+9,37,num2str(mu(4,i+1),'%4.2f'));
    text(10*i+10,34,['s' int2str(ps(1,i+1))]);
    if i==1, pause; end
    
% State 2
    dis(1)=norm(y9(2*i-1:2*i)-[1 1])^2+mu(4,i);
    dis(2)=norm(y9(2*i-1:2*i)-[0 0])^2+mu(2,i);
    j=find(dis==min(dis)); j=j(1);
    if j==1, mu(3,i+1)=dis(j); ps(2,i+1)=1;
    else mu(3,i+1)=dis(j); ps(2,i+1)=3;
    end
    
   % illustrate paths
    subplot(211), plot(bax+[10 20],bay+[40 40],'bo-');
    plot(bax+[10 20], bay+[20 40],'bo-');
    plot(bax+[10 20],bay+[40 30],'mo--');
    plot(bax+[10 20], bay+[20 30],'mo--');
   % illustrate trellis
    subplot(212), 
    if j==1, plot([10*i 10*(i+1)],[40 30],'mo--');
    else plot([10*i 10*(i+1)],[20 30],'mo--');
    end
    text(10*i+9,27,num2str(mu(3,i+1),'%4.2f'));
    text(10*i+10,24,['s' int2str(ps(2,i+1))]);    
    if i==1, pause; end
    
% State 3
    dis(1)=norm(y9(2*i-1:2*i)-[0 1])^2+mu(3,i);
    dis(2)=norm(y9(2*i-1:2*i)-[1 0])^2+mu(1,i);
    j=find(dis==min(dis)); j=j(1);
    if j==1, mu(2,i+1)=dis(j); ps(3,i+1)=2;
    else mu(2,i+1)=dis(j); ps(3,i+1)=4;
    end
    
   % illustrate paths
    subplot(211), plot(bax+[10 20],bay+[40 30],'go--');
    plot(bax+[10 20], bay+[20 30],'go--');
    plot(bax+[10 20],bay+[30 20],'mo-');
    plot(bax+[10 20], bay+[10 20],'mo-');
   % illustrate trellis
    subplot(212), 
    if j==1, plot([10*i 10*(i+1)],[30 20],'mo-');
    else plot([10*i 10*(i+1)],[10 20],'mo-');
    end
    text(10*i+9,17,num2str(mu(2,i+1),'%4.2f'));
    text(10*i+10,14,['s' int2str(ps(3,i+1))]);    
    if i==1, pause; end
    
% State 4
    dis(1)=norm(y9(2*i-1:2*i)-[1 0])^2+mu(3,i);
    dis(2)=norm(y9(2*i-1:2*i)-[0 1])^2+mu(1,i);
    j=find(dis==min(dis));  j=j(1);
    if j==1, mu(1,i+1)=dis(j); ps(4,i+1)=2;
    else mu(1,i+1)=dis(j); ps(4,i+1)=4;
    end
    
   % illustrate paths
    subplot(211),     plot(bax+[10 20],bay+[30 20],'bo-');
    plot(bax+[10 20], bay+[10 20],'bo-');
    plot(bax+[10 20],bay+[30 10],'mo--');
    plot(bax+[10 20], bay+[10 10],'mo--');
   % illustrate trellis
    subplot(212), 
    if j==1, plot([10*i 10*(i+1)],[30 10],'mo--');
    else plot([10*i 10*(i+1)],[10 10],'mo--');
    end
    text(10*i+9,7,num2str(mu(1,i+1),'%4.2f'));
    text(10*i+10,4,['s' int2str(ps(4,i+1))]);
    pause
    
% refresh fig 1
    if i<=N, subplot(211), hold off, CodeFig, 
        if norm(y9-round(y9))<0.01, text(5,21, ['z(t)=[' int2str(y9) ']']);
        else text(5,21,['z(t)=[' num2str(y9,'%5.1f') ']']);
        end
        text(5,35, ['m(t)=[' int2str(mt) ']']);
        text(5,28,['n(t)=[' int2str(out) ']']);
    end
end

% traceback to find the optimal path and decisions
bm=zeros(1, length(mt)+4);  % bit decisions
j=1; 
for i=N+1:-1:2
    subplot(212); title('Traceback along the optimal path')
    if norm([ps(j,i) j]-[1 1])==0, 
        plot([10*(i-1) 10*i],[40 40],'bx-','LineWidth',3); 
        bm(N+1-i+1)=0; text(10*(i-1)+5,2,'0');
    elseif norm([ps(j,i) j]-[1 2])==0,
        plot([10*(i-1) 10*i],[40 30],'bx--','LineWidth',3);
        bm(N+1-i+1)=1; text(10*(i-1)+5,2,'1');
    elseif norm([ps(j,i) j]-[2,3])==0,
        plot([10*(i-1) 10*i],[30 20],'bx-','LineWidth',3);
        bm(N+1-i+1)=0; text(10*(i-1)+5,2,'0');
    elseif norm([ps(j,i) j]-[2,4])==0,
        plot([10*(i-1) 10*i],[30 10],'bx--','LineWidth',3);
        bm(N+1-i+1)=1; text(10*(i-1)+5,2,'1');
    elseif norm([ps(j,i) j]-[3,1])==0,
        plot([10*(i-1) 10*i],[20 40],'bx-','LineWidth',3);
        bm(N+1-i+1)=0; text(10*(i-1)+5,2,'0');
    elseif norm([ps(j,i) j]-[3,2])==0,
        plot([10*(i-1) 10*i],[20 30],'bx--','LineWidth',3);
        bm(N+1-i+1)=1; text(10*(i-1)+5,2,'1'); 
    elseif norm([ps(j,i) j]-[4,3])==0,
        plot([10*(i-1) 10*i],[10 20],'bx-','LineWidth',3);
        bm(N+1-i+1)=0; text(10*(i-1)+5,2,'0');
    elseif norm([ps(j,i) j]-[4,4])==0,
        plot([10*(i-1) 10*i],[10 10],'bx--','LineWidth',3);
        bm(N+1-i+1)=1; text(10*(i-1)+5,2,'1');        
    end
    j=ps(j,i);
    bm1=bm(M+2:-1:3); 
    
    pause
end    
    subplot(211), hold on
    text(5,14,['d(t)=[' int2str(bm1) ']']);

subplot(211), hold off
subplot(212), hold off
