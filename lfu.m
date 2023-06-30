clear
frames=5;
data=[1, 3, 5, 4, 2, 4, 3, 2, 1, 0, 5, 3, 5, 0, 4, 3, 5, 4, 3, 2, 1, 3, 4, 5];
pages = unique(data);
num_pages = length(pages);
frametable =-1 * ones(1, frames);
pages_status = zeros(1, num_pages);
pf(1:length(data)+1)=0.1;
numColors = 256;
customMap = rand(numColors, 3);
for i=2:length(data)+1
    check=frametable(i-1,:)==data(i-1);
    if(sum(check)==1)
        frametable(i,:)=frametable(i-1,:);
        pages_status(find(data(i-1)==pages))=pages_status(find(data(i-1)==pages))+1;
        continue;
    end
    if sum(frametable(i-1,:)==-1)~=0
    position = min(find(frametable(i-1,:)==-1));
    frametable(i,:)=frametable(i-1,:);
    frametable(i,position)=data(i-1);
    pages_status(find(data(i-1)==pages))=pages_status(find(data(i-1)==pages))+1;
    pf(i)=1.1;
    continue;
    end
    k=-1;
    for j=1:frames
        if k==-1 || k>pages_status(find(frametable(i-1,j)==pages))
            k=pages_status(find(frametable(i-1,j)==pages));
            position = j;
        end
    end
   
    frametable(i,:)=frametable(i-1,:);
    frametable(i,position)=data(i-1);
    pages_status(find(frametable(i-1,position)==pages))=pages_status(find(frametable(i-1,position)==pages))+1;
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
title(['LFU  Frames:' num2str(frames) '   Page Faults:' num2str(pfnum) '   Sequence Length:' num2str(length(data)) '   Pages:' num2str(num_pages)]);
