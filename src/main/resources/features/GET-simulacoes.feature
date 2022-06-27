Feature: GET simulacoes

  @Positive
  Scenario: status code 200
    Given I have baseURI "localhost"
    * I have basePath "/simulacoes"
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