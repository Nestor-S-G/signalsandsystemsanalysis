%%1
clc
v = randn(1, 20) % vector con 20 elementos aleatorios
[minVal,minIdx] = min(v) % minVal identifica el mínimo y minIdx muestra su posición en el vector

disp('')
%2

%vectores
v1 = randn(100, 1);
v2 = rand(100, 1);

figure;

% v1
subplot(2, 1, 1); % 2 filas, 1 columna, primer subgráfico
hist(v1, 20); % Histograma de v1
title('Histograma del vector 1 (randn).');
xlabel('Valor');
ylabel('Frecuencia');

%v2
subplot(2, 1, 2); % Dos filas, una columna, segundo subgráfico
hist(v2, 20); % Histograma de v2
title('Histograma del vector 2 (rand).');
xlabel('Valor');
ylabel('Frecuencia');

%La función randn() genera una distribución que se aproxima a una normal/gaussiana, con mayor
%concentración entorno al centro de la distribución y menor concentración en las colamdas izquierda
%y derecha. Por su parte, la función rand() da lugar a distribuciones más homogéneas.

disp('')
%3

suma = 0; %se  inicia la cuenta en 0

for i = 1:length(v)
  suma = suma + (v(i)-mean(v))^2;
end

disp(suma)

%Se emplea el bucle for debido a que se conoce de antemano el número de elementos del vector.

disp('')
%4

suma = 0; %se pone a 0 el contador de nuevo para que utilice el del código anterior
i = 1;
while i <= length(v)
    suma = suma + (v(i)-mean(v))^2;
    i = i +1;
end

disp(suma)

disp('')
%5

v3 = 10 * rand(1, 100); % vector aleatorio con valores entre 0 y 1 multiplicados por 10 para cumpli
                        % la condición del enunciado

for i = 1:length(v3)
  if v3(i) >= 8
    printf('%d\n', i)
  endif
end

disp('')
%6

A = [2 3 1; 0 8 -2];
B = [3 1 4; 7 9 5];

A.*B

disp('')
%7
figure; % para que no sobreescriba los histogramas del ejercicio 1

w = linspace(0, 1.5, 300); % se crea un vector con 300 elementos equidistantes entre 0 y 1.5
x = bsxfun(@times, cos(2*pi*w), sin(w)');
contourf(w, w, x)

 %bsxfun aplica la operación del primer argumento (en este caso, una multiplicación '@times') a las matrices
 %de los siguientes argumentos, en este caso una matriz transpuesta de senos (de ahí el ') y la que incluye el
 % resultado de 2*pi multiplicado a cada elemento del vector w, dando lugar a la matriz x.

 %Por último, contourf crea un gráfico rellenando el contorno empleando los valores de w en el eje de ordenadas
 % y abscisas, usando w como altura
