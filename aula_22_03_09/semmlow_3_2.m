close all; clear variables; clc;

fs = 500; % Sampling frequency
Tt = 1; % Total time
N = Tt*fs; % Determine N
f1 = 1/Tt; % Fundamental frequency
t = (1:N)/fs; % Time vector
x = zeros(1,N); % Construct waveform
x(1:N/2) = t(1:N/2);
% Fourier decomposition
a0 = 2*mean(x); % Calculate a(0)

for m = 1:250
 f(m) = m*f1; % Sinusoidal frequencies
 a= (2/N)*sum(x.*cos(2*pi*f(m)*t)); % Cosine coeff
 b = (2/N)*sum(x.*sin(2*pi*f(m)*t)); % Sine coeff
 X_mag(m) = sqrt(a^2 + b^2); % Magnitude spectrum
 X_phase(m) = -atan2(b,a); % Phase spectrum
end
x100 = zeros(1,N); % Reconstruct waveform
for m = 1:100
 x100 = x100 + X_mag(m)*cos(2*pi*f(m)*t + X_phase(m)); % Eq. 3.15
end
x100 = x100 + a0/2; % Add in DC term
subplot(2,1,1); 
plot(t,x100,'b','DisplayName','Reconstructed signal'); hold on;
plot(t,x,'k','DisplayName','Original signal'); % Plot reconstructed and original waveform
legend('Orientation','horizontal','Box','on','Location','southoutside')
title('Reconstruction with 100 components')

x250 = zeros(1,N); % Reconstruct waveform with 
for m = 1:250
 x250 = x250 + X_mag(m)*cos(2*pi*f(m)*t + X_phase(m)); % Eq. 3.15
end
x250 = x250 + a0/2; % Add in DC term
subplot(2,1,2);
plot(t,x250,'b','DisplayName','Reconstructed signal'); hold on;
plot(t,x,'k','DisplayName','Original signal'); % Plot reconstructed and original waveform
legend('Orientation','horizontal','Box','on','Location','southoutside')
title('Reconstruction with 250 components')
saveas(gcf,sprintf('%s.png',mfilename))
