function C = mult_chunk(A,B,opt)
if nargin < 3;  opt.subsize = 64;   end
if ~isfield(opt,'subsize');     opt.subsize = 64;       end
subsize = opt.subsize;
[m,l] = size(A);        [a,n] = size(B);
C = zeros(m,n);
if l ~= a ;     printf('invalid size');     return; end
if max([m,n,l]) <= subsize;  C = A*B;    return; end
a = ceil(m/subsize);   b = ceil(n/subsize);     c = ceil(l/subsize);
d = a*b;
parfor r = 1:d;
    i = mod(r-1,b)+1;
    j = floor(r-1,a)+1;
    s = min(i*subsize,m);   t = min(j*subsize,n);
    tmp = zeros(s-(i-1)*subsize,t-(j-1)*subsize);
    for k = 1:c
       q = min(k*subsize,l);
       tmp = tmp+A((i-1)*subsize+1:s,(k-1)*subsize+1:q)*B((k-1)*subsize+1:q,(j-1)*subsize+1:t);
    end
    C = tmp+C;
end
