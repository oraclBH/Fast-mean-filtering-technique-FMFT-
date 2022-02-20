%**********************************************************************
% �����޹ؿ��پ�ֵ�˲��㷨ʵ��
% Author ��chensz
% Data     :  2022/02/16 
% Parameter declarations : w ��ֵ�˲����ڰ뾶��С, �򻯼��㣬��Ե������
% Paper��Fast mean filtering technique (FMFT)
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
     s = zeros(1, n);  %��¼�˲����ں������������ÿһ�е����غ�
     
    for  row = 1:m   %% �д���
        sm = 0;
        if row<=w || row >m-w
            continue;
        end
        if row == w+1
            for y = 1:n
                for k = -w:w
                    s(y) = s(y) + img(row+k, y);  %% �����һ����Ч�ж�Ӧ���ۼ����飬ÿ������Ԫ�ض�Ӧ���ڵĴ�С
                end
            end
        else
            for y = 1:n
                s(y) = s(y) + img(row+w, y) - img(row-w-1, y);  %% �����ۼ�����
            end
        end
        
        for col = 1:n  %%�д���
            if col<=w||col >n-w
                continue;
            end
            if col ==w+1
                for k = -w:w
                    sm =sm + s(col+k);   %% ��һ����Ч���������ۼӺ�
                end
                outIM(row, col, t) = sm;
            else
                outIM(row, col, t) = outIM(row, col-1, t) - s(col-w-1) + s(col+w);
            end
        end
    end
end

outIM = outIM ./outOne;
outIM = outIM(w+1:m-w, w+1:n-w, :);     %%����δ�˲��ı߽�
end

                                                              










                  










