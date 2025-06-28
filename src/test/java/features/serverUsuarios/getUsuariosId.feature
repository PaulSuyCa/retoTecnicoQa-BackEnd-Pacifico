@TOTAL
@ServerUsuarios
@GetServerUsuariosId
Feature: Casos de prueba para Apis Get de ServerUsuarios
  Como usuario de ServerUsuarios
  Quiero ejecutar el Api GET
  Para obtener los resultados esperados Buscar usuario por Id

  Background: Antecedente GET Id
    # url del api
    * url baseServerUsuarios + '/usuarios'
    # lee y cpnfiguracion de data de archivos
    * def data = read('classpath:resources/dataPath/serverUsuarios/getUsuarios/getUsuariosId.json')
    # esquema del response
    * def schema = read('classpath:resources/schema/serverUsuarios/getUsuarios.json')

  Scenario: Caso - Buscar usuario por Id - Busqueda path vacio
    * set data.Usuario.path = ''
    * def path = data.Usuario.path
    * print path
    Given path path
    When method get
    And print 'url: ', karate.prevRequest.url
    And print 'headers: ', karate.prevRequest.headers
    And print 'response: ', response
    Then status 200
    And match $.quantidade == schema.quantidade
    And match each $.usuarios[*] == schema.usuarios[0]

  Scenario Outline: Caso - Buscar usuario por Id - Busqueda path vacio
    * set data.Usuario.path = '<Valor>'
    * def path = data.Usuario.path
    * print path
    Given path path
    When method get
    And print 'url: ', karate.prevRequest.url
    And print 'headers: ', karate.prevRequest.headers
    And print 'response: ', response
    Then status 400
    And match response.<Search> contains "<Message>"

    Examples:
      | Valor              | Search  | Message                                           |
      | usuarioNoExistente | id      | id deve ter exatamente 16 caracteres alfanumérico |
      | 0uxuPY0cbm11p111   | message | Usuário não encontrado                            |

  Scenario: Caso - Buscar usuario por Id - Busqueda por todos los parametros
    * def path = data.Usuario.path
    * print path
    Given path path
    When method get
    And print 'url: ', karate.prevRequest.url
    And print 'headers: ', karate.prevRequest.headers
    And print 'response: ', response
    Then status 200
    And match $ == schema.usuarios[0]