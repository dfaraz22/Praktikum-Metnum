% =========================================================
%   FUNCTION NAMA DAN HURUF
%   Praktikum Metode Numerik
% =========================================================

function function_nama(param)
    fprintf('Nama saya %s!\n', param)
    function_huruf(param)
end

function function_huruf(param)
    fprintf('Kata "%s" diawali dengan huruf %c.\n', param, param(1))
end
