
%format shortG
clear all
close all
clc

%ler dados - sensorgramas com diferentes t�cnicas de detec��o do m�nimo
load receitaPMMAAu.txt

input_date = receitaPMMAAu(:,1:1);

figure(2);
plot (input_date)
xlabel('Tempo (s)');
ylabel('\lambda_R');


%A variavel winSize � o tamanho da janela
%winSize = 18;
%winSize = 20;
winSize = 5;

%Variavel para a primeira regress�o
lambdaRegress = [];
lambdaRegressB = [];
low_i = [];
high_i = [];
y_ie = [];
IC_A = [];
IC_B = [];
teste_h = [];
valor_estimado = [];

BICI = [];
BICS = [];

%Percorre todos os dados com o tamanho da janela
for i=1:1:length(input_date)

    ante = i-winSize;
    pos = i+winSize;
    if(ante <= 1)
        ante = 1;
    end
    
    if(pos > length(input_date))
       pos = length(input_date);
    end
    
    date = input_date(ante:pos); %anterior e posterior

    st = max(1,i - winSize);
    [lb_A, lb_B, valor_estim, y_i, ic_coefA, ic_coefB, teste_hip, p_value_ll, p_value_hh] = get_regress(date, 0.001);
   
    %[ICIB, ICSB] = get_bootstrap(date, 0.2);
    %[blo,bhi,~,~] = csbootint(date,'var',10000, 0.001);
    
    lambdaRegress = [lambdaRegress; lb_A];
    lambdaRegressB = [lambdaRegressB; lb_B];
    valor_estimado = [valor_estimado; valor_estim];
    y_ie = [y_ie; y_i];
    IC_A = [IC_A; ic_coefA];
    IC_B = [IC_B; ic_coefB];
    low_i = [low_i; p_value_ll];
    high_i = [high_i; p_value_hh];
    teste_h = [teste_h; teste_hip];
    
%     BICI = [BICI; ICIB];
%     BICS = [BICS; ICSB];
end

idx = IC_A <= 0 & IC_B >=0;
input_date_regress = input_date.*idx;

idx2 = (IC_A <= 0 & IC_B <= 0) | (IC_A >= 0 & IC_B >= 0);
input_date_regress2 = input_date.*idx2;

hold on;
% plot(lambdaRegress+660, 'k');
%savefig('Imagem.fig');
% z = ones(length(lambdaRegress),1)*660;
% plot(low_i + 660, 'b');
% plot(high_i+ 660, 'r');
plot(find(idx==1),input_date_regress(find(idx==1)),'ko');
% plot([1:length(lambdaRegress)]', z, 'g');

% figure(123456)
% plot(estimado, '.');

%value_yi = get_value_regress(y_ie, winSize);

% y_i = input_date(20:38,1:1) - value_yi(20:38,1:1);
% 
% figure(123412)
% histfit(y_i, 3);

% figure(1234)
% plot(y_ie, '.');
% plot(input_date);
% hold on;
% plot(value_yi, '.');





