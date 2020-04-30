%function [ a_line, b_line, low_i, high_i, value_estim, valor_IC_low, valor_IC_high, teste_hipo] = get_regress(lambda, error) 
function [ beta_2, beta_1, value_estim, e, valor_IC_low, valor_IC_high, teste_hip, p_value_low, p_value_high] = get_regress(lambda, error) 

%Gerando os valores 1 e os coeficientes X
X = [ones(length(lambda),1) (1:length(lambda))'];

X1 = X'*X;
XY = X'*lambda;

%Valores dos coeficientes de beta1 e beta2
beta = inv(X1)*XY;

%Estimador de vari�ncia
y_trans = (lambda'*lambda - beta'*XY)/(length(lambda) - 2);

%Matriz de Covari�ncia
Cjj = inv(X1);
%Valores dos coeficientes da regress�o beta_1 � o valor beta 0
%E o valor beta_2 � o valor beta 1.
beta_1 = beta(1:1,1:1);
beta_2 = beta(2:2,1:1);
 
%Valor estimado da Regress�o
value_estim = beta_1 + beta_2 * X(:, 2:2:2);
%m_a_line = sqrt(y_trans*Cjj(2:2,2:2));

e = lambda - value_estim;

%Teste de hipotese do coeficiente da regress�o
teste_hip = (beta_2/sqrt(y_trans*Cjj(2:2,2:2)));
   
%P-valor de acordo com a tabela
 p_value_low = -tinv(1-error/2,length(lambda)-2);
 p_value_high = tinv(1-error/2,length(lambda)-2);
   
%Verifica��o do Teste de Hipotese com o p-value
teste_hipo = teste_hip > p_value_low & teste_hip < p_value_high;
  
%Intervalo de Confian�a
valor_IC_low = -tinv(1-error/2,length(lambda)-2)*sqrt(y_trans*Cjj(2:2,2:2)) + beta_2;
valor_IC_high = tinv(1-error/2,length(lambda)-2)*sqrt(y_trans*Cjj(2:2,2:2)) + beta_2;

%Teste de Signific�ncia da Regress�o
% SQ_t = lambda'*lambda - (sum(lambda)^2/length(lambda));
% SQ_r = beta' * X'*lambda - (sum(lambda)^2/length(lambda));
% 
% SQ_e = SQ_t - SQ_r;
% F0 = (SQ_r/1)/(SQ_e/(length(lambda) - 2));
% f_test = finv(1-error/2,1,length(lambda)-2);

% SQ_t = y'*y - (sum(y)^2/length(lambda));
% SQ_r = beta2' * X'*y - (sum(y)^2/length(lambda));

%SQ_e = SQ_t - SQ_r;

%R^2 Ajustado
%R2 = 1 - (SQ_e/SQ_t)

%[~, ~, ~, ~, stats] = regress(lambda, X, error)
%a_line = b(2);
%b_line = b(1);
 
%se = sqrt(sum(err.^2)/(length(lambda)-2));
%kk = [1:length(lambda)]';
%den = sqrt(sum((kk-mean(kk)).^2));
%sa = se/den;
%error_low_hign = 1-erro/2;
%low_i = -tinv(1-error/2,length(lambda)-2)*sa+a_line;
%high_i = tinv(1-error/2,length(lambda)-2)*sa+a_line;


end

