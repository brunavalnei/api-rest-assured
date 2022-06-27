Feature: POST simulacao

  @Positive
  Scenario: status code 201 - seguro false
    Given I have baseURI "localhost"
    * I have basePath "/simulacoes"
    Given I send the body
    """
        {
            "nome": "Maria Flor Carreira",
            "cpf": "25124032626",
            "email": "marcela.porteira@yahoo.com",
            "valor": 1300,
            "parcelas": 3,
            "seguro": false
        }
    """
    Given I send the POST request
    Then I print the response
    * Http response should be 201

##deleta no final
    Given I have baseURI "localhost"
    * I have basePath with id "/simulacoes/"
    Given I send the DELETE request
    Then Http response should be 200


  @Positive
  Scenario: status code 201 - seguro true
    Given I have baseURI "localhost"
    * I have basePath "/simulacoes"
    Given I send the body
    """
        {
            "nome": "Maria Flor Carreira",
            "cpf": "25124032626",
            "email": "marcela.porteira@yahoo.com",
            "valor": 1300,
            "parcelas": 3,
            "seguro": true
        }
    """
    Given I send the POST request
    Then I print the response
    * Http response should be 201

##deleta no final
    Given I have baseURI "localhost"
    * I have basePath with id "/simulacoes/"
    Given I send the DELETE request
    Then Http response should be 200

  @Negative
  Scenario Outline: status code 400 - <testDescription>
    Given I have baseURI "localhost"
    * I have basePath "/simulacoes"
    Given I send the body
    """
        <body>
    """
    * I send the POST request
    Then Http response should be 400
    * The response JSON must "erros.<error>" have as the string "<message>"

    Examples:
      | testDescription                           | body                                                                                                                                  | error    | message                                   |
      | Nome não pode ser vazio                   | {"cpf": "97093236014","email": "stella.diegues@hotmail.com","valor": 1300,"parcelas": 3,"seguro": false}                              | nome     | Nome não pode ser vazio                   |
      | CPF não pode ser vazio                    | {"nome": "Fernanda Silveira","email": "stella.diegues@hotmail.com","valor": 1300,"parcelas": 3,"seguro": false}                       | cpf      | CPF não pode ser vazio                    |
      | E-mail não deve ser vazio                 | {"nome": "Fernanda Silveira","cpf": "97093236014","valor": 1300,"parcelas": 3,"seguro": false}                                        | email    | E-mail não deve ser vazio                 |
      | E-mail deve ser um e-mail válido          | {"nome": "Fernanda Silveira","cpf": "97093236014","email": "","valor": 1300,"parcelas": 3,"seguro": false}                            | email    | E-mail deve ser um e-mail válido          |
      | Valor não pode ser vazio                  | {"nome": "Fernanda Silveira","cpf": "97093236014","email": "stella.diegues@hotmail.com","parcelas": 3,"seguro": false}                | valor    | Valor não pode ser vazio                  |
#      | Email inválido: sem o domínio             | {"nome": "Fernanda Silveira","cpf": "97093236014","email": "stella.diegues@ ","valor": 1300,"parcelas": 3,"seguro": false}             | email    | E-mail deve ser um e-mail válido          |
      | Valor deve ser menor ou igual a R$ 40.000 | {"nome": "Fernanda Silveira","cpf": "97093236014","email": "stella.diegues@hotmail.com","valor": 40001,"parcelas": 3,"seguro": false} | valor    | Valor deve ser menor ou igual a R$ 40.000 |
      | Parcelas não pode ser vazio               | {"nome": "Fernanda Silveira","cpf": "97093236014","email": "stella.diegues@hotmail.com","seguro": false}                              | parcelas | Parcelas não pode ser vazio               |
      | Parcelas deve ser igual ou maior que 2    | {"nome": "Fernanda Silveira","cpf": "97093236014","email": "stella.diegues@hotmail.com","valor": 1300,"parcelas": 1,"seguro": false}  | parcelas | Parcelas deve ser igual ou maior que 2    |

  #erros encontrados na aplicação:
#  nome vazio cadastra
#    cpf vazio cadastra
  # cpf inválido é aceito
  #não valida o valor mínimo 999
  #não valida o limite máximo de parcelas (inserido 49)
  # campo seguro retirado e retornou erro 500 (precisa inserir tratamento)
#  expected:<[não é um endereço de e-mail]> but was:<[E-mail deve ser um e-mail válido] Email inválido: sem o domínio - cenário com erro intermitente

