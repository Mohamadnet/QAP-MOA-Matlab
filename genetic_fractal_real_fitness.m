function result=genetic_fractal_real_fitness(pop_no,indi,d,f)
size_ind=size(f);
list=zeros(1,size_ind(1));
row=zeros(1,size_ind(1));
for ii=1:pop_no  %agent
    temp_row=1:size_ind(2);
    [list(:) temp_row] = mergeSort(indi(ii,:),temp_row);
    for jj=1:size_ind(2) 
        row(temp_row(jj))=jj;
    end
    for jj=1:size_ind(2) 
        d_temp(jj,:)=d(row(jj),:);
    end
	for jj =1:size_ind(1)
      result_temp(jj)= sum(sum(f(jj,:) * d_temp(:,jj)));
    end
result(ii)=sum(result_temp);
end

end