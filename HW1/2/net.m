img=imread('1.png');
[m n]=size(img);

imgn=zeros(m,n);
for i=2:m-1
   for j=2:n-2 
        
       pow=0;
        for p=i-1:i+1
            for q =j-1:j+1
                if img(p,q) > img(i,j)
                    if p~=i || q~=j         %有的文章?里是3*3的?????，我就按?理?序??了。
                                            %反正都是特征描述啥的，只要按相同??就行了。
                      imgn(i,j)=imgn(i,j)+2^pow;
                      pow=pow+1;
                    end
                end
            end
        end
            
   end
end
figure;
%imshow(imgn,[]);
imshow(imgn,[]);
hist=cell(1,4);     %划分四??域求直方?，10*10的太多了，?里搞???
hist{1}=imhist(img(1:floor(m/2),1:floor(n/2)));
hist{2}=imhist(img(1:floor(m/2),floor(n/2)+1:n));
hist{3}=imhist(img(floor(m/2)+1:m,1:floor(n/2)));
hist{4}=imhist(img(floor(m/2)+1:m,floor(n/2)+1:n));
for i=1:4
   figure;
   plot(hist{i});
end