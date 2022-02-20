%**********************************************************************
% 窗口无关快速均值滤波算法实现
% Author ：chensz
% Data     :  2022/02/16 
% Parameter declarations : w 均值滤波窗口半径大小, 简化计算，边缘不处理
% Paper：Fast mean filtering technique (FMFT)
%***********************************************************************

function outIM = FMF(inIM, w) 

if ~exist('w', 'var')
    w = 5; 
end

[m, n, c] = size(inIM);
outIM = inIM;
outOne = ones(size(inIM));
outOne(w+1:m-w, w+1:n-w, :) = (2*w+1)*(2*w+1);

for t = 1:c
    img = inIM(:, :, t);
     s = zeros(1, n);  %记录滤波窗口横向所经区域的每一列的像素和
     
    for  row = 1:m   %% 行处理
        sm = 0;
        if row<=w || row >m-w
            continue;
        end
        if row == w+1
            for y = 1:n
                for k = -w:w
                    s(y) = s(y) + img(row+k, y);  %% 计算第一个有效行对应的累计数组，每个数组元素对应窗口的大小
                end
            end
        else
            for y = 1:n
                s(y) = s(y) + img(row+w, y) - img(row-w-1, y);  %% 更新累计数组
            end
        end
        
        for col = 1:n  %%列处理
            if col<=w||col >n-w
                continue;
            end
            if col ==w+1
                for k = -w:w
                    sm =sm + s(col+k);   %% 第一个有效窗口数据累加和
                end
                outIM(row, col, t) = sm;
            else
                outIM(row, col, t) = outIM(row, col-1, t) - s(col-w-1) + s(col+w);
            end
        end
    end
end

outIM = outIM ./outOne;
outIM = outIM(w+1:m-w, w+1:n-w, :);     %%剪切未滤波的边界
end

                                                              










                  










