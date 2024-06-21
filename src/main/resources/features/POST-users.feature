Feature: POST users

  @Positive
  Scenario: status code 201 - POST users
    Given I have baseURI "getNet"
    * I have basePath "/users"
    Given I send the body
    """
        {
            "name": "morpheus",
            "job": "leader"
        }
    """
    Given I send the POST request
    Then I print the response
    * Http response should be 201

##deleta no final
    Given I have baseURI "getNet"
    * I have basePath with id "/users/"
    Given I send the DELETE request
    Then Http response should be 204


  @Positive
  Scenario Outline: status code ?
    Given I have baseURI "localhost"
    * I have basePath "/users"
    Given I send the body
    """
        {
            "name": "<name>",
            "job": "<job>"
        }
    """
    Given I send the POST request
    Then I print the response
    * Http response should be 201



##deleta no final
    Given I have baseURI "localhost"
    * I have basePath with id "/users/"
    Given I send the DELETE request
    Then Http response should be 204

    Examples:

      | name     | job    |
      |          |        |
      | morpheus |        |
      |          | leader |


#    não consigo validar se o body está correto, normalmente precisa validar se tem conteúdo, se o conteúdo está de acordo mas essas informações não encontrei na documentação



