function result = complexmat(N, z0, z1)
    % skapar en N x N-matris med komplexa tal a + bi
    % där re(z0) <= a <= re(z1) och im(z0) <= b <= im(z1)
    % (jämnt fördelade i matrisen)
 
    xs = linspace(real(z0), real(z1), N);  % realdelar
    ys = linspace(imag(z0), imag(z1), N);  % imaginärdelar
 
    % skapa två matriser med real- respektive imaginärdelar
    [X, Y] = meshgrid(xs, ys);
 
    % matrisen X innehåller resultatets realdelar
    % matrisen Y innehåller resultatets imaginärdelar
 
    result = X + Y*i;   % <<< denna rad behöver utökas
end
