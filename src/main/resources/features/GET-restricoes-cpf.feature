Feature: GET restricoes - id

  @Positive
  Scenario Outline: status code 200 - Cpfs possui restrições
    Given I have baseURI "localhost"
    * I have basePath "/restricoes/<cpf>"
    Given I send the GET request
    Then I print the response
    Then Http response should be 200
    * The response JSON must "mensagem" have as the string "O CPF <cpf> tem problema"

    Examples:
      | cpf         |
      | 97093236014 |
      | 60094146012 |
      | 84809766080 |
      | 62648716050 |
      | 26276298085 |
      | 01317496094 |
      | 55856777050 |
      | 19626829001 |
      | 24094592008 |
      | 58063164083 |


#cpfs encontrados em simulacoes
  @Positive
  Scenario Outline: status code 204 - Cpfs sem restrição
    Given I have baseURI "localhost"
    * I have basePath "/restricoes/<cpfsSemRestricao>"
    Given I send the GET request
    Then Http response should be 204

    Examples:
      | cpfsSemRestricao |
      | 45340155269      |
      | 66414919004      |
      | 17822386034      |

    #melhoria: quando usuário não tem restrição, poderia ter uma mensagem de retorno, similar ao status code 200. Exemplo de mensagem: "O CPF não tem restrição"