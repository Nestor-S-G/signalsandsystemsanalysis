pkg load signal

%1
fs = 1000; %tasa de muestreo Hz
t = 0:1/fs:5-1/fs; %vector de tiempo de 0 a 5 segundos
frecuencias = [30, 3, 6, 12]; % en Hz
duracion_segmento = 5 / length(frecuencias);

%señal
data = [];
for f = frecuencias
    t_segmento = 0:1/fs:duracion_segmento-1/fs;
    data = [data, sin(2 * pi * f * t_segmento)];
end

fftWidth_ms = 500; % ancho de ventana en milisegundos
fftWidth = round(fftWidth_ms / (1000 / fs)); % ancho muestras
Ntimesteps = 50; % número de ventanas
centertimes = round(linspace(fftWidth + 1, length(t) - fftWidth, Ntimesteps));
hz = linspace(0, fs / 2, fftWidth); % intervalo de frecuencias
tf = zeros(length(hz), length(centertimes)); %matriz para resultados de potencia tiempo-frecuencia

%filtro de Hilbert
for ti = 1:length(centertimes)
    temp = data(centertimes(ti) - fftWidth/2 : centertimes(ti) + fftWidth/2 - 1); % Extraer la ventana de datos
    hilbert_transform = hilbert(temp); % Aplicar el filtro
    x = abs(fft(hilbert_transform, fftWidth)).^2; % Calcular la potencia espectral
    tf(:, ti) = x(1:length(hz));
end

%gráficos
figure;

%tiempo-frecuencia
contourf(t(centertimes), hz, tf, 40, 'LineStyle', 'none');
set(gca, 'ylim', [0 40], 'clim', [0 max(tf(:))*0.7], 'xlim', [0 5]);
xlabel('Tiempo (s)');
ylabel('Frecuencia (Hz)');
title('Potencia tiempo-frecuencia (Método del Filtro de Hilbert)');
colormap(flipud(gray)); % invertir escala de colores
colorbar;

%señal original
figure;
plot(t, data);
xlabel('Tiempo (s)');
ylabel('Amplitud');
title('Señal Original');

%los resultados muestran un gráfico tiempo-frecuencia que ha perdido claramente nitidez respecto a la figura 5.1

%2

fs = 1000; %tasa de muestreo Hz
t = 0:1/fs:6-1/fs; %vector tiempo (6")
f_start = 20; %inicio
f_end = 80; %fin

signal = sin(2 * pi * (f_start + (f_end - f_start) * (t / max(t))) .* t); %señal con frecuencia creciente lineal

%filtros
freqs = linspace(f_start, f_end, 30); %frecuencias centrales para el análisis

%distintos anchos de banda
twid_narrow = 5; %estrecho (5 Hz)
twid_wide = 20; %amplio (20 Hz)
twid_increasing = @(fc) 0.1 * fc; %anchura que incrementa en función de la frecuencia (10% de fc)
twid_decreasing = @(fc) max(1, 30 - 0.2 * fc); %ancho decreciente en función de la frecuencia

%matrices para inicializar los resultados
tf_narrow = zeros(length(freqs), length(t));
tf_wide = zeros(length(freqs), length(t));
tf_increasing = zeros(length(freqs), length(t));
tf_decreasing = zeros(length(freqs), length(t));

%función corregida para aplicar filtro de paso banda
function filtered = bandpass_filter(data, fs, fc, twid)
    %cálculo frecuencias de corte normalizadas
    low_cut = (fc - twid) / (fs / 2); %frecuencia de corte inferior
    high_cut = (fc + twid) / (fs / 2); % " "          "   superior

    if low_cut < 0
        low_cut = 0;
    end
    if high_cut > 1
        high_cut = 1;
    end %esto asegura que las frecuencias estén dentro del intervalo [0, 1]

    %aplica el filtro a las frecuencias válidas
    if low_cut < high_cut
        [b, a] = butter(4, [low_cut high_cut], 'bandpass');
        filtered = filtfilt(b, a, data);
    else
        filtered = zeros(size(data)); %devuelve ceros si el intervalo no es válido
    end
end


%descomposición tiempo-frecuencia
for i = 1:length(freqs)
    fc = freqs(i); %frecuencia central
    %paso constante estrecho
    filtered = bandpass_filter(signal, fs, fc, twid_narrow);
    tf_narrow(i, :) = abs(hilbert(filtered));

    %paso constante amplio
    filtered = bandpass_filter(signal, fs, fc, twid_wide);
    tf_wide(i, :) = abs(hilbert(filtered));

    %ancho creciente
    filtered = bandpass_filter(signal, fs, fc, twid_increasing(fc));
    tf_increasing(i, :) = abs(hilbert(filtered));

    %ancho decreciente
    filtered = bandpass_filter(signal, fs, fc, twid_decreasing(fc));
    tf_decreasing(i, :) = abs(hilbert(filtered));
end


%gráficos
figure;

%paso constante estrecho
subplot(2, 2, 1);
contourf(t, freqs, tf_narrow, 40, 'LineStyle', 'none');
title('Constante Estrecho (5 Hz)');
xlabel('Tiempo (s)');
ylabel('Frecuencia (Hz)');
colormap(jet); colorbar;

%paso constante amplio
subplot(2, 2, 2);
contourf(t, freqs, tf_wide, 40, 'LineStyle', 'none');
title('Constante Amplio (20 Hz)');
xlabel('Tiempo (s)');
ylabel('Frecuencia (Hz)');
colormap(jet); colorbar;

%anchura creciente
subplot(2, 2, 3);
contourf(t, freqs, tf_increasing, 40, 'LineStyle', 'none');
title('Ancho Creciente (10% de fc)');
xlabel('Tiempo (s)');
ylabel('Frecuencia (Hz)');
colormap(jet); colorbar;

%anchura decreciente
subplot(2, 2, 4);
contourf(t, freqs, tf_decreasing, 40, 'LineStyle', 'none');
title('Ancho Decreciente');
xlabel('Tiempo (s)');
ylabel('Frecuencia (Hz)');
colormap(jet); colorbar;

%Se aprecian claras diferencias al gráficar con diferentes configuraciones: el paso constante estrecho tiene una alta resolución frecuencial, estando cada frecuencia bien delimitada y distinguible del resto, sin embargo la resolución
%temporal es más baja. En el paso constante amplio se aprecia el caso contrario: alta resolución temporal pero baja en la frecuencia. En la condición de anchura creciente se aprecia mejor resolución en las frecuencias bajas, mienrtas
%en las altas se aprecia cierto solapamiento. Por último, en el ancho decreciente se aprecia cierta resolución en frecuencias bajas, pero es homogeneo en el resto.

%Para el paso constante estrecho la configuración apropiada parece estar entre 3 y 5Hz: más estrecho y la respuesta en el tiempo se degrada, perdiéndose claridad en transiciones rápidas; más ancho, y se ya se aproxima al paso constante
%amplio. En el paso constante amplio el intervalo parece hayarse entre 15 y 25Hz. Para la anchura creciente, si se usara algo inferior al 10% se pierde resolución temporal en las frecuncias altas, pues los filtros siguen siendo muy
%estrechos, mientras que valores superiores, del 25 ó 30%, hacen que las banda de frecuencia se solapen, perdiendo nitidez. Para la anchura decreciente, se impone un mínimo de 5Hz para evitar que el filtro se estreche demasido en
%frecuencias altas. Si en lugar de 0.2 se empleasen reducciones más agresivas, como 0.4, la anchura disminuiría demasiado y demasiado pronto, lo que daría una resolución temporal mala a las frecuencias bajas, y si se empleara
%una reducción menor, como el 0.1 la diferencia entre altas y bajas frecuencias no sería tan pronunciada, asemejandose al paso constante amlpio.
