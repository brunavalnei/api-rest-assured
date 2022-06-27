Feature: PUT simulacao

  @Pre_req
  Scenario: status code 201
    Given I have baseURI "localhost"
    * I have basePath "/simulacoes"
    Given I send the body
    """
      {
        "nome": "Ígor da Madureira Filho",
        "cpf": "05132413102",
        "email": "joaopedro.cruz@gmail.com",
        "valor": 1300,
        "parcelas": 3,
        "seguro": false
      }
    """
    Given I send the POST request
    Then I print the response
    Then Http response should be 201


  @Positive
  Scenario: status code 200
    Given I have baseURI "localhost"
    * I have basePath "/simulacoes/05132413102"
    Given I send the body
    """
        {
          "nome": "Ígor da Madureira Filho alterado",
          "cpf": "05132413102",
          "email": "joaopedro.cruz@gmail.com",
          "valor": 1300,
          "parcelas": 3,
          "seguro": false
      }
    """
    * I send the PUT request
    Then I print the response
    Then Http response should be 200

    Given I have baseURI "localhost"
    * I have basePath with id "/simulacoes/"
    Given I send the DELETE request
    Then Http response should be 200

  @Negative
  Scenario Outline: status code 400 - <testDescription>
    Given I have baseURI "localhost"
    * I have basePath "/simulacoes/66414919004"
    Given I send the body
    """
        <body>
    """
    * I send the PUT request
    Then I print the response
    Then Http response should be 400
    * The response JSON must "erros.<error>" have as the string "<message>"


    Examples:
      | testDescription                        | body                                                                                                                                 | error    | message                                |
      | E-mail deve ser um e-mail válido       | {"nome": "Fernanda Silveira","cpf": "97093236014","email": "","valor": 1300,"parcelas": 3,"seguro": false}                           | email    | E-mail deve ser um e-mail válido       |
#      | Email inválido: sem o domínio          | {"nome": "Fernanda Silveira","cpf": "97093236014","email": "stella.diegues@","valor": 1300,"parcelas": 3,"seguro": false}            | email    | E-mail deve ser um e-mail válido       |
      | Parcelas deve ser igual ou maior que 2 | {"nome": "Fernanda Silveira","cpf": "97093236014","email": "stella.diegues@hotmail.com","valor": 1300,"parcelas": 1,"seguro": false} | parcelas | Parcelas deve ser igual ou maior que 2 |

  #erros encontrados na aplicação:
#  nome vazio edita
#    cpf vazio edita
  # cpf inválido é aceito
  #não valida o valor mínimo 999
#  não valida o valor máximo
  #parcela null status 200
#  não valida os campos, se são obrigatórios ou não. Retiro os campos e retorna 200
  #não valida o limite máximo de parcelas (inserido 49)
  # campo seguro retirado e retornou erro 500 (precisa inserir tratamento)
