function [C,cost] = matrix_mult(A,B,solver)
if nargin < 3;  solver = 'default';        end
A_dis = distributed(A);
B_dis = distributed(B);
% clear(A),clear(B);
switch(solver)
    case 'default'
        tic;
        C = A_dis*B_dis;
        cost = toc;
    case 'mult_chunk'
        tic;
        C = mult_chunk(A,B);
        cost = toc;
end
% C = gather(C);