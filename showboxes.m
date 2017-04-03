function showboxes(im, boxes, posemap)

% showboxes(im, boxes)
% Draw boxes on top of image.
figure(1)
imagesc(im);
hold on;
axis image;
axis off;
midX = zeros(1,length(boxes));
midY = zeros(1,length(boxes));
for b = boxes
    partsize = b.xy(1,3)-b.xy(1,1)+1;
    tx = (min(b.xy(:,1)) + max(b.xy(:,3)))/2;
    ty = min(b.xy(:,2)) - partsize/2;
%     text(tx,ty, num2str(posemap(b.c)),'fontsize',18,'color','c');
    for i = size(b.xy,1):-1:1
        x1 = b.xy(i,1);
        y1 = b.xy(i,2);
        x2 = b.xy(i,3);
        y2 = b.xy(i,4);
%         line([x1 x1 x2 x2 x1]', [y1 y2 y2 y1 y1]', 'color', 'b', 'linewidth', 1);
        midX(i) = (x1 + x2)/2;
        midY(i) = (y1 + y2)/2;
%         plot(midX(i),midY(i),'r.','markersize',15);
    end
end
left = midX(1);
right = midX(1);
top = midY(1);
bottom = midY(1);
lefti = 1;
righti = 1;
topi = 1;
bottomi = 1;
disp(midX(1));
disp(midY(1));

for i = 1: length(midX)
    if midX(i) < left
        left = midX(i);
        lefti = i;
    end
    if midX(i) > right
        right = midX(i);
        righti = i;
    end
    if midY(i) < top
        top = midY(i);
        topi = i;
    end
    if midY(i) > bottom
        bottom = midY(i);
        bottomi = i;
    end
end
x1 = midX(lefti);
x2 = midX(righti);
y1 = midY(topi);
y2 = midY(bottomi);
x = [x1, x2, x2, x1, x1];
y = [y1, y1, y2, y2, y1];
% plot(x, y, 'r-', 'LineWidth', 3);
% hold on;

x1 = int64(x1);
x2 = int64(x2);
y1 = int64(y1);
y2 = int64(y2);

midx = double((x1 + x2) / 2);
midy = double((y1 + y2) / 2);
imconstant = im;

for i = 1: 477
    for j = 1: 268
        dist = (double((i - midx)^2 + (j - midy)^2))^.5;
        
        if dist < 12
            im(j,i,:) = im(j,i,:) + 50 - dist;
        else
            im(j,i,:) = im(j,i,:) + 500/dist;
        end
    end
end
figure(2)
imagesc(im)


for i = 1: 477
    for j = 1: 268
        imconstant(j,i,:) = imconstant(j,i,:) + 100;
    end
end
figure(3)
imagesc(imconstant)

% plot(midX(lefti),midY(topi),'r.','markersize',15);
% plot(midX(righti),midY(topi),'r.','markersize',15);
% plot(midX(righti),midY(bottomi),'r.','markersize',15);
% plot(midX(lefti),midY(bottomi),'r.','markersize',15);
% hold on
drawnow;
