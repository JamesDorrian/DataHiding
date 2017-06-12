function [C] = quantisation(block , y )

Q = double([16 11 10 16 24 40 51 61
            12 12 14 19 26 58 60 55
            14 13 16 24 40 57 69 56
            14 17 22 29 51 87 80 62
            18 22 37 56 68 109 103 77
            24 35 55 64 81 104 113 92
            49 64 78 87 103 121 120 101
            72 92 95 98 112 100 103 99]);
            
if y < 50
    alph = 5000/y;
elseif y <= 99
    alph = 200 - 2.*y;
else
    alph = 1;
end

Qt = double(zeros(8,8));
C = double(zeros(8,8));

Qt = round(((alph.*Q + 50) /100));
C = round(block ./ Qt);

C
end