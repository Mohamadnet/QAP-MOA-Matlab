function result=MOA_find(pop_no,f,d,iteration,ro,alpha)
size_f=size(f);
R=2;
m=size_f(1);
L=round(pop_no^0.5);
best_magnet=inf;
%initialization
x = R*rand(pop_no,m)-R/2;
v = zeros(pop_no,m);

for counter=1:iteration
    magnet=genetic_fractal_real_fitness(pop_no,x,d,f);
    Min=min(magnet);
    Max=max(magnet);
    if sum(abs(magnet-Min))==0
        magnet=magnet+rand(1,pop_no);
    end
    
    [Min I]=min(magnet);
    if Min<best_magnet
        best_indi=x(I,:);
        best_magnet=Min;
    end
result(counter) = best_magnet;
%     fitnesses(counter)=genetic_fractal_real_fitness(best_indi,Domain_pool,range_block,domain_horizontal,domain_vertical);
    
    magnet=(magnet-Min)/(Max-Min);
    mass=ro*magnet+alpha;
    
    diver=0;
    for ii=1:pop_no
        row=ceil(ii/L);
        column=mod(ii-1,L)+1;
        neighbor(1)=ii-1;
        neighbor(2)=ii+1;
        neighbor(3)=ii+L;
        neighbor(4)=ii-L;
        if column==1 neighbor(1)=ii+L-1;end
        if column==L neighbor(2)=ii-L+1;end
        if row==L neighbor(3)=ii-(L-1)*L;end
        if row==1 neighbor(4)=ii+(L-1)*L;end

        if neighbor(1)>pop_no neighbor(1)=ii-1;end
        if neighbor(2)>pop_no neighbor(2)=ii-1;end
        if neighbor(3)>pop_no neighbor(3)=ii-1;end
        if neighbor(4)>pop_no neighbor(4)=ii-1;end
        
        [del S]=size(neighbor);
        F=zeros(1,m);
        for k=1:S
            distance(k)=mean(mean(abs(x(neighbor(k),:)-x(ii,:))))/R;
            help=x(neighbor(k),:) - x(ii,:);
            F=F+(help).*magnet(neighbor(k))/(distance(k)+0.0001);
        end
        force(ii,:)=rand(1,m).*F;
    end
    

    for ii=1:pop_no       
        v(ii,:)=((force(ii,:))./mass(ii));
        del=v(ii,:);
        x(ii,:)=x(ii,:)+v(ii,:);
        x(ii,:)=max(x(ii,:),-R/2);
        x(ii,:)=min(x(ii,:),R/2);
    end
%     x(1,:)=best_indi;
end