function [ B, C ] = bind_energy( A, Z )
av = 15.5; as = 16.8; ac = 0.72; asym = 23; ap = 34; del = 0;

if mod(Z, 2) == 0 && mod(A-Z, 2) == 0
    del = A^(-3/4);
elseif mod(Z,2) ~= 0 && mod(A-Z, 2) ~= 0
    del = -A^(-3/4);
end
C = ac*(Z*(Z-1))/A^(1/3);
B = av*A - as*A^(2/3)- C - asym*((A-2*Z)^2)/A + ap*del;

end

