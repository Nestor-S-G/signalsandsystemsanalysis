%1.a
fs = 1000; %frecuencia de muestreo [Hz]
t = 0:1/fs:10; %vector de tiempo de 10s según enunciado

%señal 1
t1 = t(t >= 2 & t <= 7);
f1 = linspace(10, 25, length(t1)); %incremento frecuencia de 10 a 25Hz
a1 = linspace(1, 2, length(t1)); %incremento amplitud de 1 a 2 s
signal1 = a1 .* sin(2 * pi * f1 .* t1);

%señal 2
t2 = t(t >= 5 & t <= 10);
f2 = linspace(45, 30, length(t2)); %decremento recuencia de 45 a 30 Hz
a2 = linspace(2, 1, length(t2)); %disminución amplitud de 2 a 1
signal2 = a2 .* sin(2 * pi * f2 .* t2);

%serie temporal combinada
signal = zeros(size(t));
signal(t >= 2 & t <= 7) = signal1;
signal(t >= 5 & t <= 10) = signal(t >= 5 & t <= 10) + signal2;

%gráfico
figure;
plot(t, signal);
title('Serie temporal combinada');
xlabel('Tiempo (s)');
ylabel('Amplitud');

%b
fmin = 5;  %frecuencia mínima para el análisis
fmax = 50; %frecuencia máxima
num_frequencies = 100; %cantidad frecuencias a evaluar
frequencies = linspace(fmin, fmax, num_frequencies);

%parámetros de la ondícula de Morlet
sigma_t = 1; %ancho de la ventana temporal
wavelet_duration = 5 * sigma_t; %duración efectiva de la ondícula
time_wavelet = -wavelet_duration:1/fs:wavelet_duration;
time_freq_analysis = zeros(num_frequencies, length(t)); %inicialización de matriz para el espectrograma

%cálculo de la transformada usando la convolución
for i = 1:num_frequencies
    freq = frequencies(i);
    sigma_f = 1 / (2 * pi * sigma_t); %ancho de banda en frecuencia
    wavelet = exp(2 * 1i * pi * freq * time_wavelet) .* exp(-time_wavelet.^2 / (2 * sigma_t^2));
    wavelet = wavelet / sqrt(sum(abs(wavelet).^2)); %normalización de energía
    conv_result = conv(signal, wavelet, 'same');
    time_freq_analysis(i, :) = abs(conv_result); %magnitud
end

%gráfico
figure;
imagesc(t, frequencies, time_freq_analysis);
axis xy;
xlabel('Tiempo (s)');
ylabel('Frecuencia (Hz)');
title('Análisis tiempo-frecuencia con ondícula de Morlet');
colorbar;

%Se utiliza 1000 como frecuencia de muestreo para tener un amplio margen, ya que el teorema de Nyquist, que exige que sea de al menos el doble de la frecuencia máxima (45Hz)
%si se eligen 100, también se cumple pero se perderían detalles en la resolución; si en su lugar de pusieran 10000, se incrementaría innecesariamente el coste de computación.
%Se eligen un valor de 10 segundos como duración de la señal porque permite incluir los intervalos de señales dados en el enunciado.
%Se toma 5sigma como duración de la ondícula de Morlet para que la ondícula tenga amplitud suficiente para capturar los componentes de la frecuencia sin perder resolución temporal.
%una ondícula más corta mejoraría la resolución temporal, pero como contrapartida se perdería precisión al identificar frecuencias específicas, y si fuera más larga se daría la situación opuesta,
%mejoraría la resolución de las frecuencias, pero empeoraría la temporal.

%2
%a
%parámetros de ruido rosa
amp_avg = mean(abs(signal)); %amplitud promedio de la señal original
max_noise_amp = 2 * amp_avg; %amplitud máxima

%ruido rosa (1/f)
N = length(t); %número de puntos de la señal
f = (0:N-1) * (fs / N); %frecuencia asociada (vector numérico)
f(f == 0) = 1; % evita errorr de división por 0 en 1/f
amplitudes = 1 ./ sqrt(f); %amplitudes distribuidas según 1/f
phases = 2 * pi * rand(1, N) - pi; %fases aleatorias
noise = ifft(amplitudes .* exp(1i * phases)); %transformada inversa para ruido rosa
noise = max_noise_amp * noise / max(abs(noise)); % Escalado de amplitud
signal_with_noise = signal + noise; %señal + ruido rosa

%gráfico
figure;
subplot(2, 1, 1);
plot(t, signal);
title('Señal original');
xlabel('Tiempo (s)');
ylabel('Amplitud');

subplot(2, 1, 2);
plot(t, signal_with_noise);
title('Señal con ruido rosa');
xlabel('Tiempo (s)');
ylabel('Amplitud');

%.b:
signal_with_noise = signal_with_noise(:);
time_freq_analysis_noise = zeros(num_frequencies, length(t)); %inicializacion

for i = 1:num_frequencies
    freq = frequencies(i);
    wavelet = exp(2 * 1i * pi * freq * time_wavelet) .* exp(-time_wavelet.^2 / (2 * sigma_t^2));
    wavelet = wavelet / sqrt(sum(abs(wavelet).^2)); % Normalización de energía
    wavelet = wavelet(:); % Asegurarse de que wavelet sea un vector columna
    conv_result = conv(signal_with_noise, wavelet, 'same');
    time_freq_analysis_noise(i, :) = abs(conv_result); % Magnitud
end


%gráficos
figure;
imagesc(t, frequencies, time_freq_analysis_noise);
axis xy;
xlabel('Tiempo (s)');
ylabel('Frecuencia (Hz)');
title('Análisis tiempo-frecuencia con ondícula de Morlet (con ruido rosa)');
colorbar;

%El ruido se aprecia más claramente en las frecuencias bajas.

%El dominio de la frecuencia es más adecuado para esta serie temporal, ya que se pueden descomponer los elementos frecuenciales mientras en el dominio del tiempo se solapan. La fórmula empleada 1/f hace que
%haya más energía en las frecuencias bajas, mientras que la distribución temporal es más uniforme.


%3
% Parámetros para la STFT
window_size = 256; %tamaño de la ventana en muestras
overlap = round(.75 * window_size); % 75% de solapamiento
nfft = 1024; %número de puntos de la FFT
win_type = 2; %tipo de ventana (2 para Hamming)
[stft_result, C] = stft(signal, window_size, overlap, nfft, win_type); %análisis tiempo-frecuencia usando STFT

t_stft = (0:length(stft_result)-1) * (overlap / fs); % tiempos de las ventanas
f_stft = (0:nfft/2-1) * (fs / nfft); %frecuencias hasta la mitad de la FFT

%gráfico espectrograma STFT
figure;
imagesc(t_stft, f_stft, abs(stft_result)); % Usando los valores de tiempo y frecuencia calculados
axis xy;
xlabel('Tiempo (s)');
ylabel('Frecuencia (Hz)');
title('Análisis tiempo-frecuencia con STFT');
colorbar;

% Comparación con análisis de ondículas de Morlet
figure;
% Subplot 1: Ondículas de Morlet
subplot(1, 2, 1);
imagesc(t, frequencies, time_freq_analysis);
axis xy;
xlabel('Tiempo (s)');
ylabel('Frecuencia (Hz)');
title('Ondículas de Morlet');
colorbar;

% Subplot 2: STFT
subplot(1, 2, 2);
imagesc(t_stft, f_stft, abs(stft_result)); % Usando los valores calculados para tiempo y frecuencia
axis xy;
xlabel('Tiempo (s)');
ylabel('Frecuencia (Hz)');
title('STFT');
colorbar;

%la STFT ofrece una imagen más nítida, lo que podría ser una ventaja sobre las ondículas de Morlet en algún caso particular. Sin embargo, aquí apenas captura los detalles de los cambios de frecuencias, por lo que parece mejor
%opción las ondículas de Morlet.
