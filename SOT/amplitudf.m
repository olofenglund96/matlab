function amplitudf = amplitudf(h);
%
global t
global DELTAT
global N
domega = 2*pi/DELTAT/2^N;
amplitudf = abs(fftshift(fft(h)))*DELTAT;
figure
plot(-40*domega:domega:40*domega,amplitudf(2^(N-1)+1-40:2^(N-1)+1+40));
xlabel('vinkelfrekvens')
grid


