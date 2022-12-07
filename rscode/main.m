clear;clc;close all;
% 比较两次深度学习得到的特征，并把第二次学到的纠正为第一次的。
load V1.mat     % 原始特征
load V2.mat    % 二次学习得到的特征
% 重构特征矩阵，列数不能大于16，且越小运行速度越快（相对）
plaintext = reshape(template11, [960, 10]); 
plaintext2 = reshape(template21, [960, 10]);

% rs编码
[~, m] = size(plaintext);
k = m;
n = 2 * floor(0.5 * (2 ^ m - 1 - k)) + k; 

msg = gf(plaintext, m);     % 转换信息到伽罗瓦域
ciphertext_gf = rsenc(msg, n, k);      % 加密

codetext = ciphertext_gf(:, k + 1:end);
msg2 = gf(plaintext2, m);
ciphertext_gf2 = [msg2, codetext];
% decodetext = rsdec(ciphertext2, n, k);   % 解密
% 
% ciphertext(1, 1) = 100;     % 修改密文
decodetext = rsdec(ciphertext_gf2, n, k);  % 解密

% 比较纠错后的矩阵与原矩阵。
1==1
decodetext == msg