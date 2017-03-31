function getBoundaries(boxes)

% showboxes(im, boxes)
% Draw boxes on top of image.

midX = zeros(1,length(boxes));
midY = zeros(1,length(boxes));
for b = boxes,
    partsize = b.xy(1,3)-b.xy(1,1)+1;
    tx = (min(b.xy(:,1)) + max(b.xy(:,3)))/2;
    ty = min(b.xy(:,2)) - partsize/2;
    for i = size(b.xy,1):-1:1;
        x1 = b.xy(i,1);
        y1 = b.xy(i,2);
        x2 = b.xy(i,3);
        y2 = b.xy(i,4);
        midX(i) = (x1 + x2)/2;
        midY(i) = (y1 + y2)/2;
    end
end

left = intmax;
right = 0;
top = intmax;
bottom = 0;
for i = 0length(midX)
    if midX(i) < left
        left = midX(i);
    end
    if midX(i) > right
        right = midX(i);
    end
    if midY(i) < top
        top = midY(i);
    end
    if midY(i) > bottom
        bottom = midY(i);
    end
end



