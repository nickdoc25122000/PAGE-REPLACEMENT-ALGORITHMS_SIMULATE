clear
frames=5;
data=[1, 3, 5, 4, 2, 4, 3, 2, 1, 0, 5, 3, 5, 0, 4, 3, 5, 4, 3, 2, 1, 3, 4, 5];
unique_elements = unique(data);
num_unique_elements = length(unique_elements);
frametable =-1 * ones(1, frames);
frametablestatus = zeros(1, frames);
pf(1:length(data)+1)=0.1;
numColors = 256;
customMap = rand(numColors, 3);
for i=2:length(data)+1
    check=frametable(i-1,:)==data(i-1);
    if(sum(check)==1)
        frametable(i,:)=frametable(i-1,:);
        frametablestatus=frametablestatus+1;
        frametablestatus(1,find(check))=0;
        continue;
    end
    position=min(find(frametablestatus==max(frametablestatus)));
    frametable(i,:)=frametable(i-1,:);
    frametable(i,position)=data(i-1);
    frametablestatus=frametablestatus+1;
    frametablestatus(position)=0;
    pf(i)=1.1;
end
frametable;
pf=pf';
pfnum=sum(round(pf));
figure;
heatmap([frametable ,pf ,[-1 data]']);
h=heatmap([frametable ,pf ,[-1 data]'])
h.FontName = ['Calibri''bold'];
h.FontSize = 14;
colormap(customMap);
colorbar('off');
title(['LRU  Frames:' num2str(frames) '   Page Faults:' num2str(pfnum) '   Sequence Length:' num2str(length(data)) '   Pages:' num2str(num_unique_elements)]);
