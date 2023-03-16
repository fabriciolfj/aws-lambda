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

#### Imagens
- Quando fazemos uso de imagens base da aws para função lambda, ela nos proporciona um ambiente de teste
```
docker run -p 9090:8080 hello-world
curl -XPOST "http://localhost:9000/2015-03-31/functions/function/invocations" -d '{}'
```

### Codigo em java
- um repositorio git com vários exemplos: https://github.com/awsdocs/aws-lambda-developer-guide/tree/main/sample-apps
- temos como lib principais:
```
com.amazonaws:aws-lambda-java-core (obrigatória): define as interfaces do método do manipulador e o objeto de contexto que o tempo de execução transmite ao manipulador. Se você definir seus próprios tipos de entrada, esta será a única biblioteca necessária.

com.amazonaws:aws-lambda-java-events: tipos de entrada para eventos de serviços que invocam funções do Lambda.

com.amazonaws:aws-lambda-java-log4j2: uma biblioteca appender do Apache Log4j 2 que você pode usar para adicionar o ID de solicitação da invocação atual aos logs de função.
```

#### python
- precisa baixar as dependencias
```
pip install --target ./package requests
```
- zip as mesmas
```
cd package
zip -r ../my-deployment-package.zip .
```
- incluir a função dentro do zip que possui as depenencias
```
cd ..
zip my-deployment-package.zip lambda_function.py
```

### https://docs.aws.amazon.com/pt_br/lambda/latest/dg/lambda-services.html