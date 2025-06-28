@TOTAL
@ServerUsuarios
@PutServerUsuariosId
Feature: Casos de prueba para Apis Get de ServerUsuarios
  Como usuario de ServerUsuarios
  Quiero ejecutar el Api PUT
  Para obtener los resultados esperados Editar usuario por Id

  Background: Antecedente PUT
    # url del api
    * url baseServerUsuarios + '/usuarios'
    # lee y cpnfiguracion de data de archivos
    * def data1 = read('classpath:resources/dataPath/serverUsuarios/getUsuarios/getUsuariosId.json')
    * def data2 = read('classpath:resources/dataPath/serverUsuarios/postUsuarios/'+ dataPath +'/postUsuario.json')
    # esquema del response
    * def schema = read('classpath:resources/schema/serverUsuarios/getUsuarios.json')

  Scenario: Caso - Editar usuario por Id - Editar path vacio
    * set data1.Usuario.path = ''
    * def path = data1.Usuario.path
    * print path
    * def body = data2.body.Existente
    * print body
    Given path path
    And request body
    When method put
    And print 'url: ', karate.prevRequest.url
    And print 'headers: ', karate.prevRequest.headers
    And print 'response: ', response
    Then status 405
    And match response.message contains "Não é possível realizar PUT em /usuarios/. Acesse https://serverest.dev para ver as rotas disponíveis e como utilizá-las."

  Scenario Outline: Caso - Editar usuario por Id - Editar con el <Valor> no ingresada.
    * def path = data1.Usuario.path
    * print path
    * def body = data2.body.Existente
    * remove body.<Search>
    * print body
    Given path path
    And request body
    When method put
    And print 'url: ', karate.prevRequest.url
    And print 'headers: ', karate.prevRequest.headers
    And print 'response: ', response
    Then status 400
    And match response.<Search> contains "<Message>"

    Examples:
      | Valor         | Search        | Message                     |
      | Nombre        | nome          | nome é obrigatório          |
      | Email         | email         | email é obrigatório         |
      | Contrasenia   | password      | password é obrigatório      |
      | Administrador | administrador | administrador é obrigatório |

  Scenario: Caso - Editar usuario por Id - Editar body no ingresado
    * def path = data1.Usuario.path
    * print path
    Given path path
    When method put
    And print 'url: ', karate.prevRequest.url
    And print 'headers: ', karate.prevRequest.headers
    And print 'response: ', response
    Then status 411

  Scenario Outline: Caso - Editar usuario por Id - Editar con el <Valor> vacio.
    * def path = data1.Usuario.path
    * print path
    * def body = data2.body.Existente
    * set body.<Search> = ''
    * print body
    Given path path
    And request body
    When method put
    And print 'url: ', karate.prevRequest.url
    And print 'headers: ', karate.prevRequest.headers
    And print 'response: ', response
    Then status 400
    And match response.<Search> contains "<Message>"

    Examples:
      | Valor         | Search        | Message                                      |
      | Nombre        | nome          | nome não pode ficar em branco                |
      | Email         | email         | email não pode ficar em branco               |
      | Contrasenia   | password      | password não pode ficar em branco            |
      | Administrador | administrador | administrador deve ser \'true\' ou \'false\' |

  Scenario: Caso - Editar usuario por Id - Editar Ok o Falla
    * def path = data1.Usuario.path
    * def body = data2.body.Existente
    Given path path
    And request body
    When method put
    Then assert responseStatus == 200 || responseStatus == 400
    * if (responseStatus == 200) karate.match(response.message, 'Registro alterado com sucesso')
    * if (responseStatus == 400) karate.match(response.message, 'Este email já está sendo usado')
