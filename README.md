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

### Criação de uma lambda via cli
```
aws lambda create-function --function-name my-function \
--zip-file fileb://function.zip --handler index.handler --runtime nodejs16.x \
--role arn:aws:iam::763114715754:role/lambda-ex
```
- invocando o lambda via cli
```
aws lambda invoke --function-name my-function out --log-type Tail
```
- para atualizar um lambda
```
aws lambda update-function-configuration \
--function-name my-function \
--memory-size 256
```
- para excluir
```
aws lambda delete-function --function-name my-function
```

### Permissões
- lambda coloca na requisições, além das credenciais (token gerado pela role vinculada a ela), sua arn
- desta forma podemos identificar, qual lambda chamou nosso recurso, através do lambda:SourceFunctionArn

#### Chaves
- A chave de condição lambda:SourceFunctionArn é diferente das chaves de condição lambda:FunctionArn e aws:SourceArn. 
- A chave de condição lambda:FunctionArn aplica-se somente a mapeamentos de fontes de eventos e ajuda a definir quais funções a sua fonte de evento pode invocar. 
- A chave de condição aws:SourceArn se aplica apenas a políticas nas quais a função do Lambda é o recurso visado e ajuda a definir quais outros serviços e recursos da AWS podem invocar essa função. 
- A chave de condição lambda:SourceFunctionArn pode ser aplicada a qualquer política baseada em identidade ou SCP para definir as funções específicas do Lambda que têm permissões para fazer determinadas chamadas de API da AWS para outros recursos.

#### continuar
https://docs.aws.amazon.com/pt_br/lambda/latest/dg/access-control-identity-based.html