function QAP

run =30;                         %run   
iteration=2000;     %generation
pop_no=50;
f=dlmread('f_nug30.dat'); 
d=dlmread('d_nug30.dat');     %read from text file
N = 30 ;
x=1:iteration ;
ro=[0.1 0.5 1 1.5 2];
alphaa=[0.1 0.5 1 1.5 2];
z_temp=[];
size_ro=size(ro);
size_alpha=size(alphaa);
for jj=1:size_ro(2)
    for w=1:size_alpha(2)
        filename=['temp data\ro_' int2str(ro(jj)) ' alpha_' int2str(alphaa(w)) '.mat'];
        if exist(filename)==2
            load(filename);
        else
            for i=1:run
                mean_tempdec(i,:)=MOA_find(pop_no,f,d,iteration,ro(jj),alphaa(w));
                disp(['End of run ',num2str(i),' th.']) ;
            end
            y=mean(mean_tempdec,1);
            z_temp=[z_temp,y(iteration)];
            filename=['temp data\ro_' int2str(ro(jj)) ' alpha_' int2str(alphaa(w)) '.mat'];
            save(filename,'z_temp');
        end
    end
end
z_fitness=zeros(size_ro(2),size_alpha(2));    % (x,y)
z_fitness(:)=z_temp; 
[max_z I_z]=min(z_temp);
size_x=size_ro(2);
size_y=size_alpha(2);
ro_max=ro(ceil(I_z/size_y));
ceil(I_z/size_y)
mod(I_z,size_y)
if mod(I_z,size_x)~=0
    alpha_max=alphaa(mod(I_z,size_y));
else
    alpha_max=alphaa(size_y);
end
h= figure;
surf(alphaa,ro,z_fitness);  %(x,y,z)
colormap gray;
alpha(0.4);
axis auto ;
dlm_str=[max_z alpha_max ro_max];
dlmwrite('new\res 3d.txt',dlm_str);
dlmwrite('new\res 3d z.txt',z_fitness);
hgsave(h,'new\fig 3d');

end