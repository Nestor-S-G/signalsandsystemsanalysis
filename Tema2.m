%1

srate = 1000; % se comienza definiendo la frecuencia del muestreo, 1000Hz
time = 0:1/srate:6; % se crea un vector tiempo entre 0 y 6 unidades temporales en pasos de 1/srate (0.001 en este caso)
sinefreq = 10; % se define la 'frecuencia sinusoidal' en 10 Hz
boxfreq = 1; % se define la 'frecuencia cuadrada' en 1 Hz

sinewave = sin( 2 * pi * sinefreq * time ); % fórmula estándar para crear una onda sinusoidal:
                                            % 2 * pi * sinefreq convierte Hz en radianes/segundo
                                            % y *time genera una onda a lo largo del tiempo definido previamente
boxwave = sin( 2 * pi * boxfreq * time ) > 0; % análogo al anterior, con la salvedad de que la comparación > 0
                                              % convierte la onda sinusoidal en una onda cuadrada con valores binarios
                                              %1 o 0, por contraposición a la sinusoidal, que por propieades matemáticas
                                              %oscila entre -1 y 1.
solution1 = boxwave .* sinewave; %el comando .* realiza la operación elemento por elemento entre ambos vectores.
                                 %como boxwave sólo contiene 0s y 1s, por lo que los valores de sinewave bien
                                 %permanecen inalterados, bien se convierten en 0 en el vector resultante.
solution2 = solution1 + 3*boxwave;%al triplicar los valores de boxwave, ahora sus valores binarios son 3/0
                                  %y sumando esos valores a 'solution1' se agranda la onda sinusoidal obteniendo
                                  %así una mejora en la visualización

clf % limpia cualquier gráfica previa
plot(time, solution1) %crea una gráfica usando time como eje de abscisas y solution1 como ordenadas.
plot(time, solution2) %íden al anterior, con solution2
set(gca, 'ylim', [-.5 4.5] ) %gca selecciona los ejes activos y son 'set' se modifica la propiedad deseada,
                             %, en este caso los límites del eje Y ('ylim') en el intervalo -.05 - 4.5.


2%

%se reciclan srate y time del ejercicio anterior

amplitudes = [1 0.8 0.6 0.5 0.4 0.3 0.2]; %amplitud de las ondas sinusoidales
frequencies = [5 10 15 20 25 30 35]; %frecuencias de dichas ondas en Hz

combined_signal = zeros(size(time)); %se inicializa un contador de ceros

for i = 1:length(frequencies)
    sinewave = amplitudes(i) * sin(2 * pi * frequencies(i) * time); %se genera una onda sinusoidal con amplitud y frecuencia específicos
                                                                    %usando la fŕomula del ejercicio anterior, multiplicando por la amplitud.
    combined_signal = combined_signal + sinewave; % se añade la onda senoidal a la señal combinada

end

% Graficar la señal compuesta
plot(time, combined_signal);
title('Señal combinada con múltiples frecuencias');
xlabel('Tiempo (s)');
ylabel('Amplitud');
grid on; % para activar la cuadrícula en el gráfico en uso mejorando la visualización


%En frequencies he ido aumentado el número de elementos y hasta 7 (código actual) se distinguen, con el octavo se alisa y no se perciben las frecuencias con claridad.

%3

srate = 1000; % Frecuencia de muestreo (Hz)
time = 0:1/srate:5; %intervalo temporal de 5"
frequencies = [5 15 30]; % vector con las frecuencias en Hz

%ondas sinusoidales. como la amplitud es 1, se omite en el presente código
sinewave1 = sin(2 * pi * frequencies(1) * time);
sinewave2 = sin(2 * pi * frequencies(2) * time);
sinewave3 = sin(2 * pi * frequencies(3) * time);

% Señal combinada
combined_signal = sinewave1 + sinewave2 + sinewave3;

figure;
subplot(2,1,1);
plot(time, combined_signal);
title('Señal combinada sin ruido');
xlabel('Tiempo (s)');
ylabel('Amplitud');
grid on;

%ruido aleatorio generado con la función randn
noise_amplitude = 1.25;
noisy_signal = combined_signal + noise_amplitude * randn(size(time));

%graficar la señal combinada con ruido
subplot(2,1,2);
plot(time, noisy_signal);
title(['Señal combinada con ruido (Amplitud del ruido = ' num2str(noise_amplitude) ')']);
xlabel('Tiempo (s)');
ylabel('Amplitud');
grid on;

%variando el valor "noise_amplitude" manualmente se puede estimar el nivel de ruido que hace las ondas indistinguibles.
%alrededor de 1.25 (valor actual) ya se hace dificil distinguir las diferentes ondas.

%4

%se reciclan srate y time del ejercicio anterior

n = length(time); %número de puntos en el tiempo

base_series = randn(1, n); %serie temporal gaussiana/normal a emplear como base

%ruido estacionario (con varianza constante de 0.5)
stationary_noise = .5 * randn(1, n);
stationary_series = base_series + stationary_noise;

%ruido no estacionario (varianza cambiante en el intervalo 0-20)
nonstationary_noise = abs(linspace(0, 20, n) .* randn(1, n));
nonstationary_series = base_series + nonstationary_noise;

% Graficar ambas series en la misma gráfica
figure;
plot(time, stationary_series, 'b', 'DisplayName', 'Ruido Estacionario'); hold on;
plot(time, nonstationary_series, 'r', 'DisplayName', 'Ruido No Estacionario');
title('Serie con Ruido Estacionario y No Estacionario');
xlabel('Tiempo (s)');
ylabel('Amplitud');
legend show; %leyenda para identificar las series
grid on;
hold off;


