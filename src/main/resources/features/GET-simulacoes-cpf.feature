Feature: GET simulacoes/cpf


  @Positive
  Scenario: status code 201
    Given I have baseURI "localhost"
    * I have basePath "/simulacoes"
    Given I send the body
    """
        {
            "nome": "Samuel Solimões",
            "cpf": "60711055521",
            "email": "julia.souza@bol.com.br",
            "valor": 1300,
            "parcelas": 3,
            "seguro": false
        }
    """
    Given I send the POST request
    Then I print the response
    Then Http response should be 201


    Given I have baseURI "localhost"
    * I have basePath "/simulacoes/60711055521"
    Given I send the GET request
    Then I print the response
    Then Http response should be 200
    * The variable "id" is not empty
    * The variable "nome" is not empty
    * The variable "cpf" is not empty
    * The variable "email" is not empty
    * The variable "valor" is not empty
    * The variable "parcelas" is not empty
    * The variable "seguro" is not empty

  #deleta no final
    Given I have baseURI "localhost"
    * I have basePath with id "/simulacoes/"
    Given I send the DELETE request
    Then Http response should be 200


  @Negative
  Scenario: status code 404
    Given I have baseURI "localhost"
    * I have basePath "/simulacoes/1"
    Given I send the GET request
    Then Http response should be 404
    * The response JSON must "mensagem" have as the string "CPF 1 não encontrado"

