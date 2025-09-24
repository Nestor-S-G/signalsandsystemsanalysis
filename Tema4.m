pkg load signal %paquete necesario para la resolución de varios ejercicios

%1

%datos enunciado
f_signal = 200.01; %Hz
A = 1; %amplitud
nyquist = 1000; %Hz
fs = nyquist*2; %frecuencia de muestreo, sacada de la definición de 'frecuencia de nyquist'
resol = 0.1; %Hz

T = 1 / resol; %duración de la señal [s]
t = 0:1/fs:T-1/fs; %vector tiempo
signal = A*sin(2*pi*f_signal*t);

% Transformada de Fourier
N = length(signal); %número de muestras
f = linspace(0, nyquist, N/2+1); %frecuencias >0
fft_signal = fft(signal); %FFT
amplitud_e = abs(fft_signal(1:N/2+1)); %amplitud del espectro
fase_e = angle(fft_signal(1:N/2+1)); %fase del espectro

%gráficas
%señal en el tiempo
figure;
plot(t, signal);
title('Señal sinusoidal en el tiempo');
xlabel('Tiempo (s)');
ylabel('Amplitud');

%amplitud espectral
figure;
plot(f, amplitud_e);
title('Espectro de amplitud (parte positiva)');
xlabel('Frecuencia (Hz)');
ylabel('Amplitud');

%fase espectral
figure;
plot(f, fase_e);
title('Espectro de fase (parte positiva)');
xlabel('Frecuencia (Hz)');
ylabel('Fase (radianes)');

%2
%dado que se pide representar la señal del ejercicio 1, se reutilizan algunas variables
ventana = hann(length(signal))'; %ventana Hanning
signal_v = signal .* ventana; %señal enventanada

%Transformada de Fourier para la resolución original
fft_signal_v = fft(signal_v, N); % FFT
amplitud_original = abs(fft_signal_v(1:N/2+1)); %amplitud

%Transformada de Fourier para resolución 0.01 Hz
resol1 = 0.01; %nueva resolución
T_1 = 1 / resol1; %duración nueva resolución
t_1 = 0:1/fs:T_1-1/fs; %vector tiempo nuevo
signal_1 = A * sin(2 * pi * f_signal * t_1) .* hann(length(t_1))'; %señal enventanada

N_fine = length(signal_1); %número de puntos para la FFT 0.01
f_fine = linspace(0, fs/2, N_fine/2+1); %frecuencias >0
fft_signal_1 = fft(signal_1, N_fine);
amplitude_1 = abs(fft_signal_1(1:N_fine/2+1));

%gráficas
%señal en el tiempo (con ventana de Hanning)
figure;
plot(t, signal, 'b', 'DisplayName', 'Original');
hold on;
plot(t, signal_v, 'r', 'DisplayName', 'Enventanada');
hold off;
title('Señal sinusoidal en el tiempo (con y sin ventana Hanning)');
xlabel('Tiempo (s)');
ylabel('Amplitud');
legend;

%parte positiva del espectro (resolución original y 0.01)
figure;
plot(f, amplitud_original, 'b', 'LineWidth', 1.5, 'DisplayName', 'Resolución 0.1 Hz');
hold on;
plot(f_fine, amplitude_1, 'r--', 'LineWidth', 1.5, 'DisplayName', 'Resolución 0.01 Hz');
hold off;
title('Espectro de amplitud (parte positiva)');
xlabel('Frecuencia (Hz)');
ylabel('Amplitud');
legend;

3%
%datos
fs = 1000; % Hz
T = 20; % s
t = 0:1/fs:T-1/fs; %vector tiempo
f0 = 10; %frecuencia fundamental de la señal en Hz
A = 10; %amplitud en 10 Hz

%señal periódica
N = length(t); %número de muestras totales
signal = zeros(size(t)); %inicializador de señal

%pulso rectangular
pulse_duration = 1 / (2 * 100); %duración de cada pulso, con el dato del enunciado de que el lóbulo principal tenga una anchura de 100Hz
pulse = A * rectpuls(t - pulse_duration/2, pulse_duration); %pulso centrado

%suma de pulsos para crear la señal periódica
for k = 0:f0:(fs/2)
    signal = signal + A * sin(2 * pi * k * t);
end

%transformada de Fourier
fft_signal = fft(signal);
N_fft = length(fft_signal);
f = linspace(0, fs/2, N_fft/2+1); %frecuencias >0
amplitud_espec = abs(fft_signal(1:N_fft/2+1));

%gráficas
%primeros 0.5s en el dominio temporal
figure;
plot(t(t <= 0.5), signal(t <= 0.5));
title('Señal periódica (primeros 0.5 segundos)');
xlabel('Tiempo (s)');
ylabel('Amplitud');

%espectro positivo
figure;
plot(f, amplitud_espec);
title('Espectro de amplitud (parte positiva)');
xlabel('Frecuencia (Hz)');
ylabel('Amplitud');

%4
%enunciado
fs = 10000; % Hz
T = 20; % s
t = 0:1/fs:T-1/fs; %vector tiempo
sigma = 20; %desviación estándar del ruido blanco gaussiano

noise = sigma * randn(size(t)); %ruido blanco con la desviación estándar dada en el enunciado

N = length(noise); %número de puntos
fft_noise = fft(noise); %FFT del ruido
f = linspace(0, fs/2, N/2+1); %frecuencias >0
spd = abs(fft_noise(1:N/2+1)).^2 / N;

%gráficas
%ruido en el dominio temporal, primeros 0.5s
figure;
plot(t(t <= 0.5), noise(t <= 0.5));
title('Ruido blanco Gaussiano (primeros 0.5")');
xlabel('Tiempo (s)');
ylabel('Amplitud');

%densidad espectral de potencia
figure;
plot(f, spd);
title('Densidad espectral de potencia (SPD)');
xlabel('Frecuencia (Hz)');
ylabel('Potencia');

%5
fs = 1000;
fs_sub = 100; %frecuencia para submuestreo (Hz)
factor_sub = fs / fs_sub; %factor de submuestreo = 10

%submuestreo de la señal periódica
signal_sub = signal(1:factor_sub:end); %submuestrear tomando una muestra cada 10 submuestras
t_sub = 0:1/fs_sub:T-1/fs_sub; %vector tiempo submuestreado

%gráficas
figure;
subplot(2,1,1);
plot(t(t <= 0.5), signal(t <= 0.5));
title('Señal Original (primeros 0.5 segundos)');
xlabel('Tiempo (s)');
ylabel('Amplitud');

subplot(2,1,2);
plot(t_sub(t_sub <= 0.5), signal_sub(t_sub <= 0.5));
title('Señal Submuestreada (primeros 0.5 segundos)');
xlabel('Tiempo (s)');
ylabel('Amplitud');

%6

%Transformada de Fourier de la señal compuesta
N = length(signal_sub);
fft_composed = fft(signal_sub);
f = linspace(0, fs_sub/2, N/2+1); %frecuencias >0
amplitude_spectrum = abs(fft_composed(1:N/2+1)); % Espectro de amplitud

%determinación de la frecuencia de corte
f_cutoff = 50; %valor tomado aleatoriamente

%eliminar todo lo que esté por encima de la frecuencia de corte en la FFT
fft_composed_filtered = fft_composed;
fft_composed_filtered(f > f_cutoff) = 0; % Eliminar componentes espectrales por encima de la frecuencia de corte

%Transformada inversa de Fourier para obtener la señal filtrada
signal_filtered = ifft(fft_composed_filtered);

%gráficas
%primeros 0.5 seg. de la señal filtrada
figure;
plot(t_sub(t_sub <= 0.5), signal_filtered(t_sub <= 0.5));
title('Señal filtrada (primeros 0.5 segundos)');
xlabel('Tiempo (s)');
ylabel('Amplitud');

%comparación señal original
figure;
plot(t_sub(t_sub <= 0.5), signal_sub(t_sub <= 0.5));
title('Señal original compuesta (primeros 0.5 segundos)');
xlabel('Tiempo (s)');
ylabel('Amplitud');

%7
%parámetros de la señal análogos al ejemplo
srate = 1000; % Frecuencia de muestreo (Hz), ajustada para que sea más del doble de 440 de la señal portadora
speriod = 1 / srate; % Período de muestreo
duration = 3; % Duración de la señal, ajustada según enunciado
t_max = duration - speriod; % Tiempo máximo de la señal
t = 0:speriod:t_max; % Eje temporal
n = length(t); % Número de muestras

%parámetros señal portadora
f_carrier = 440; %Hz, La4
a_portadora = 5; %amplitud señal
carrier = a_portadora * sin(2 * pi * f_carrier * t);

%señal moduladora (triangular)
f_modulator = 12; %frecuencia Hz
a_moduladora = 2; %amplitud señal moduladora
modulator = a_moduladora * sawtooth(2 * pi * f_modulator * t, 0.5); %onda triangular

% Efecto de trémolo (modulación de amplitud)
tremolo_signal = carrier .* (1 + modulator); %señal modulada

%gráficas señal portadora y modulada
figure;
subplot(3,1,1);
plot(t(1:round(srate)), carrier(1:round(srate)));
title('Señal Portadora (440 Hz)');
xlabel('Tiempo (s)');
ylabel('Amplitud');

subplot(3,1,2);
plot(t(1:round(srate)), tremolo_signal(1:round(srate)));
title('Señal Modulada (Trémolo)');
xlabel('Tiempo (s)');
ylabel('Amplitud');

%reproducción señales portadora y modulada
sound(carrier, srate);
pause(5); %sperar a que termine la reproducción
sound(tremolo_signal, srate);

% Espectro de la señal portadora, moduladora y modulada
%FFT de cada señal
fft_carrier = fft(carrier);
fft_modulator = fft(modulator);
fft_tremolo_signal = fft(tremolo_signal);

f = linspace(0, srate/2, n/2+1); %frecuencias de la FFT

%amplitud espectral, parte >0
amplitude_spectrum_carrier = abs(fft_carrier(1:n/2+1));
amplitude_spectrum_modulator = abs(fft_modulator(1:n/2+1));
amplitude_spectrum_tremolo_signal = abs(fft_tremolo_signal(1:n/2+1));

%gráficas
figure;
subplot(3,1,1);
plot(f, amplitude_spectrum_carrier);
title('Espectro de la Señal Portadora (440 Hz)');
xlabel('Frecuencia (Hz)');
ylabel('Amplitud');

subplot(3,1,2);
plot(f, amplitude_spectrum_modulator);
title('Espectro de la Señal Moduladora (12 Hz)');
xlabel('Frecuencia (Hz)');
ylabel('Amplitud');

subplot(3,1,3);
plot(f, amplitude_spectrum_tremolo_signal);
title('Espectro de la Señal Modulada (Trémolo)');
xlabel('Frecuencia (Hz)');
ylabel('Amplitud');

%la frecuencia de muestreo original de 500 no era adecuada pues no cumplía la regla de ser >2x la portadora. Una vez ajustada el problema quedó resuelto.

%8

% Parámetros de la señal
srate = 48000; % Hz
duration = 3; % s
t = 0:1/srate:duration-1/srate; %vector tiempo

%señal portadora (triangular)
f_portadora = 261.63; % Hz, Do4
a_portadora = 5; %amplitud
carrier = a_portadora * sawtooth(2 * pi * f_portadora * t, 0.5); % Onda triangular

% Parámetros de la señal moduladora (sinusoidal)
f_modula = 5; % Hz
a_modula = 0.25; %amplitud
modula = a_modula * sin(2 * pi * f_modula * t);

% Efecto de vibrato (modulación de frecuencia)
vibrato_signal = a_portadora * sawtooth(2 * pi * (f_portadora + modula) .* t, 0.5);

% Reproducir la señal portadora y la señal modulada
sound(carrier, srate);
pause(4);
sound(vibrato_signal, srate);

%FFT
N = length(t);
f = linspace(0, srate/2, N/2+1); % Frecuencias >0

fft_carrier = fft(carrier);
fft_modula = fft(modula);
fft_vibrato_signal = fft(vibrato_signal);

amplitud_spectrum_porta = abs(fft_carrier(1:N/2+1));
amplitud_spectrum_modula = abs(fft_modula(1:N/2+1));
amplitud_spectrum_vibrato_signal = abs(fft_vibrato_signal(1:N/2+1));

%gráficas
figure;
subplot(3,1,1);
plot(f, amplitud_spectrum_porta);
title('Espectro de la Señal Portadora (Triangular)');
xlabel('Frecuencia (Hz)');
ylabel('Amplitud');

subplot(3,1,2);
plot(f, amplitud_spectrum_modula);
title('Espectro de la Señal Moduladora (5 Hz)');
xlabel('Frecuencia (Hz)');
ylabel('Amplitud');

subplot(3,1,3);
plot(f, amplitud_spectrum_vibrato_signal);
title('Espectro de la Señal Modulada (Vibrato)');
xlabel('Frecuencia (Hz)');
ylabel('Amplitud');

