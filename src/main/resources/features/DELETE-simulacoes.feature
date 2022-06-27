Feature: DELETE simulacoes

  @Positive
  Scenario: status code 201
    Given I have baseURI "localhost"
    * I have basePath "/simulacoes"
    Given I send the body
    """
      {
          "nome": "Morgana de Lara",
          "cpf": "54575416223",
          "email": "mariasophia.pimenta@hotmail.com",
          "valor": 1300,
          "parcelas": 3,
          "seguro": false
      }
    """
    Given I send the POST request
    Then I print the response
    Then Http response should be 201
#deleta no final
    Given I have baseURI "localhost"
    * I have basePath with id "/simulacoes/"
    Given I send the DELETE request
    Then Http response should be 200

  @Negative
  Scenario: status code 404
    Given I have baseURI "localhost"
    * I have basePath "/simulacoes/teste"
    Given I send the DELETE request
    Then Http response should be 400


  #erros encontrados
#  simulacao criada e deletada. status code 200, deveria ser 204 de acordo com o protocolo http
#  simulação deletada, deleto novamente e o status continua sendo 200, de acordo com a documentação deveria ser 404 (precisa validar como está sendo feita a deleção)