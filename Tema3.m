%1

%señales
x = [1, 2, 3, 4, -4, -3, -2, -1];
y = [0, -1, 0, 1, 0, -1, 0, 1];
n = 0:length(x)-1; % índices a emparejar con los valores de los vectores

% a) x[n]
figure; stem(n, x, 'filled'); title('x[n]'); xlabel('n'); ylabel('x[n]'); %se emplea stem() debido a la naturaleza discreta de las señales en lugar de plot(), para continuas.
                                                                          %filled rellena los puntos en la gráfica.
% b) y[n]
figure; stem(n, y, 'filled'); title('y[n]'); xlabel('n'); ylabel('y[n]');

% c) 5x[n]
figure; stem(n, 5*x, 'filled'); title('5x[n]'); xlabel('n'); ylabel('5x[n]');

% d) -7y[n]
figure; stem(n, -7*y, 'filled'); title('-7y[n]'); xlabel('n'); ylabel('-7y[n]');

% e) x[n-3]
n_e = n - 3;
x_e = [zeros(1, 3), x]; %relleno de ceros para mantener los índices >0.
n_new = 0:length(x_e)-1; %nuevos índices
figure; stem(n_new, x_e, 'filled'); title('x[n-3]'); xlabel('n'); ylabel('x[n-3]');

% f) y[n+1]
y_f = [y(2:end), 0]; %desplazar los valores y añadir un 0 al final
figure; stem(n, y_f, 'filled'); title('y[n+1]'); xlabel('n'); ylabel('y[n+1]');

% g) 2x[n+1]
x_g = [x(2:end), 0];
figure; stem(n, 2*x_g, 'filled'); title('2x[n+1]'); xlabel('n'); ylabel('2x[n+1]');

% h) -y[n-1]
y_h = [0, y(1:end-1)];
figure; stem(n, -y_h, 'filled'); title('-y[n-1]'); xlabel('n'); ylabel('-y[n-1]');

% i) x[n] + y[n]
sum_xy = x + y;
figure; stem(n, sum_xy, 'filled'); title('x[n] + y[n]'); xlabel('n'); ylabel('x[n] + y[n]');

% j) -2x[n-1] + 3y[n+2]
x_j = [0, x(1:end-1)]; % x[n-1]
y_j = [y(3:end), zeros(1, 2)]; % y[n+2]
result = -2*x_j + 3*y_j;
figure; stem(n, result, 'filled'); title('-2x[n-1] + 3y[n+2]'); xlabel('n'); ylabel('Resultado');

% k) 3x[n+2] - 2y[n+2]
x_k = [x(3:end), zeros(1, 2)]; % x[n+2]
y_k = [y(3:end), zeros(1, 2)]; % y[n+2]
result = 3*x_k - 2*y_k;
figure; stem(n, result, 'filled'); title('3x[n+2] - 2y[n+2]'); xlabel('n'); ylabel('Resultado');

% l) x[n] + x[n-2]
x_l = [zeros(1, 2), x(1:end-2)]; % x[n-2]
result = x + x_l;
figure; stem(n, result, 'filled'); title('x[n] + x[n-2]'); xlabel('n'); ylabel('Resultado');

% m) 2x[n] - 3x[n-2] + 3y[n+1]
x_m = [zeros(1, 2), x(1:end-2)]; % x[n-2]
y_m = [y(2:end), 0]; % y[n+1]
result = 2*x - 3*x_m + 3*y_m;
figure; stem(n, result, 'filled'); title('2x[n] - 3x[n-2] + 3y[n+1]'); xlabel('n'); ylabel('Resultado');


%2

%intervalo de n
n = -8:1:8;

% a)
x_a = sin(2 * pi * n / 8);
figure; stem(n, x_a, 'filled'); title('x[n] = sin(2 \pi n / 8)'); xlabel('n'); ylabel('x[n]');

% b)
x_b = cos(2 * pi * n / 4);
figure; stem(n, x_b, 'filled'); title('x[n] = cos(2 \pi n / 4)'); xlabel('n'); ylabel('x[n]');

% c)
x_c = sin(2 * pi * n / 2);
figure; stem(n, x_c, 'filled'); title('x[n] = sin(2 \pi n / 2)'); xlabel('n'); ylabel('x[n]');

% d)
x_d = cos(2 * pi * n / 2);
figure; stem(n, x_d, 'filled'); title('x[n] = cos(2 \pi n / 2)'); xlabel('n'); ylabel('x[n]');

% e)
x_e = zeros(size(n));
x_e(n > 2) = n(n > 2) - 3;
figure; stem(n, x_e, 'filled'); title('x[n] = n-3 si n > 2, 0 en otro caso'); xlabel('n'); ylabel('x[n]');

% f)
x_f = zeros(size(n));
x_f(n < -3) = 1;
x_f(n >= 4) = 5;
figure; stem(n, x_f, 'filled'); title('x[n] = 1 si n < -3, 0 si 0 < n < 4, 5 en otro caso'); xlabel('n'); ylabel('x[n]');


%3

t = -8:1:8; % intervalo de t

% a)
x_a = sin(2 * pi * t / 8);
figure; plot(t, x_a, 'LineWidth', 2); title('x(t) = sin(2 \pi t / 8)'); xlabel('t'); ylabel('x(t)'); %LineWidth y el número siguiente, en este caso 2, indican el grosor de la linea en la gráfica.

% b)
x_b = cos(2 * pi * t / 4);
figure; plot(t, x_b, 'LineWidth', 2); title('x(t) = cos(2 \pi t / 4)'); xlabel('t'); ylabel('x(t)');

% c)
x_c = sin(2 * pi * t / 2);
figure; plot(t, x_c, 'LineWidth', 2); title('x(t) = sin(2 \pi t / 2)'); xlabel('t'); ylabel('x(t)');

% d)
x_d = cos(2 * pi * t / 2);
figure; plot(t, x_d, 'LineWidth', 2); title('x(t) = cos(2 \pi t / 2)'); xlabel('t'); ylabel('x(t)');

% e)
x_e = zeros(size(t));
x_e(t > 2) = t(t > 2) - 3;
figure; plot(t, x_e, 'LineWidth', 2); title('x(t) = t-3 si t > 2, 0 en otro caso'); xlabel('t'); ylabel('x(t)');

% f)
x_f = zeros(size(t));
x_f(t < -3) = 1;
x_f(t >= 4) = 5;
figure; plot(t, x_f, 'LineWidth', 2); title('x(t) = 1 si t < -3, 0 si 0 < t < 4, 5 en otro caso'); xlabel('t'); ylabel('x(t)');

%4

%señal
x = [0, 2, 3, 4, 3, 2, -1, 0, -2, -3, 2, 1];
n = 0:length(x)-1; %índices para la señal

%a

%par
x_par = 0.5 * (x + fliplr(x)); %fliplr() sirve para reflejar las señal y trabajar de forma indirecta con indices negativos, algo que de forma directa daría error en Octave.
figure; stem(n, x_par, 'filled'); title('Parte Par de x[n]'); xlabel('n'); ylabel('Parte Par de x[n]');

%impar
x_impar = 0.5 * (x - fliplr(x));
figure; stem(n, x_impar, 'filled'); title('Parte Impar de x[n]'); xlabel('n'); ylabel('Parte Impar de x[n]');

%b
x_entrelazada = x_par + x_impar; %recomponer la señal a partir de las partes
figure; stem(n, x_entrelazada, 'filled'); title('Descomposición Entrelazada de x[n]'); xlabel('n'); ylabel('Descomposición Entrelazada');

%c
x_e1 = x_par + x_impar;
x_e2 = x_par - x_impar;
x_e3 = x_par + 2 * x_impar;

figure; stem(n, x_e1, 'filled'); title('Etapa 1 de descomposición'); xlabel('n'); ylabel('x[n]');
figure; stem(n, x_e2, 'filled'); title('Etapa 2 de descomposición'); xlabel('n'); ylabel('x[n]');
figure; stem(n, x_e3, 'filled'); title('Etapa 3 de descomposición'); xlabel('n'); ylabel('x[n]');

%5

%datos y condiciones del enunciado
t = 0:.1:5;
b = zeros(size(t));
b(t > 0 & t < 2) = 1;

x = zeros(size(t));
x(t > 1 & t < 2) = -1;
x(t > 2 & t < 3) = 1;
x(t > 3 & t < 4) = 4;
x(t > 4 & t < 5) = 2;

%a
figure; plot(t, b, 'LineWidth', 2); title('b(t)'); xlabel('t'); ylabel('b(t)');
figure; plot(t, x, 'LineWidth', 2); title('x(t)'); xlabel('t'); ylabel('x(t)');

%b

%escalas (aX, correspondientes a la amplitud de cada pulso) y traslados (sX, correspondiente con el inicio de los pulsos en t)
a1 = -1; s1 = 1;
a2 = 1; s2 = 2;
a3 = 4; s3 = 3;

%cálculo de versiones escaladas y trasladadas
b1 = a1 * (t > (s1) & t < (s1 + 2));
b2 = a2 * (t > (s2) & t < (s2 + 1));
b3 = a3 * (t > (s3) & t < (s3 + 1));

figure; plot(t, b1, 'LineWidth', 2); title('Componente 1 de x(t): a1 * b(t - s1)'); xlabel('t'); ylabel('Componente 1');
figure; plot(t, b2, 'LineWidth', 2); title('Componente 2 de x(t): a2 * b(t - s2)'); xlabel('t'); ylabel('Componente 2');
figure; plot(t, b3, 'LineWidth', 2); title('Componente 3 de x(t): a3 * b(t - s3)'); xlabel('t'); ylabel('Componente 3');

%c
x_recompuesta = b1 + b2 + b3;
figure; plot(t, x_recompuesta, 'LineWidth', 2); title('Señal recompuesta x(t)'); xlabel('t'); ylabel('x(t)');

