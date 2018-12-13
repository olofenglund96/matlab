function [ m ] = mass_from_defect( A, del )
c = 931.502;
m = del/c + A;
end

