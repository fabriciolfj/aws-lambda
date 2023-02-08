# aws-lambda
- são funçoes, que possuem um ponto de entrada (handler) e produz um evento (json por exemplo)
- podemos integrar com outros serviços da aws (triggar), como: sqs, dynamodb e kinesis

### ENIS 
- enis de hiperplano, é um recurso de rede gerenciado pelo serviço lambda
- são utilizados para cessar recursos dentro das vpcs da sua conta

### Escalabilidade
- aws cria instancâncias para executar sua função, conforme as requisições chegam
- caso sua função esteja efetuando um processamento e uma nova requisição chega, cria-se uma nova instância e executa em paralelo.
- quando uma instância não está sendo utilizada, é destruida
- existe um limite de simultaneidade, e varia por região (Brasil é 500)
- quando a simultaneidade chega ao máximo, ela retorna um 429
- podemos mitigar esse problema, utilizando simultaneidade provisionada, onde:
  - lambda inicializa o número provisionado
  - sua função fica pronta para receber uma expanção de solicitações com latência muito baixa
  - podemos utilizar o auto-scaling para efetuar o provisionamento com base em uma quantidade mínima e máxima
  - ele controla esse ponto, com base no número de solicitações abertas

### continuacao
- https://docs.aws.amazon.com/pt_br/lambda/latest/dg/gettingstarted-package.html