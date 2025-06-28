@TOTAL
@ServerUsuarios
@GetServerUsuarios
Feature: Casos de prueba para Apis Get de ServerUsuarios
  Como usuario de ServerUsuarios
  Quiero ejecutar el Api GET
  Para obtener los resultados esperados Listar usuarios registrados

  Background: Antecedente GET
    # url del api
    * url baseServerUsuarios + '/usuarios'
    # lee y cpnfiguracion de data de archivos
    * def data = read('classpath:resources/dataPath/serverUsuarios/getUsuarios/getUsuario.json')
    # esquema del response
    * def schema = read('classpath:resources/schema/serverUsuarios/getUsuarios.json')

  Scenario: Caso - Listar usuarios registrados - Busqueda sin parametros
    Given method get
    When print 'url: ', karate.prevRequest.url
    And print 'headers: ', karate.prevRequest.headers
    And print 'response: ', response
    Then status 200
    And match $.quantidade == schema.quantidade
    And match each $.usuarios[*] == schema.usuarios[0]

  Scenario Outline: Caso - Listar usuarios registrados - Busqueda por <Valor> cuando esta vacio
    * def param = data.Params.<Search>
    * set param.<Search> = ''
    * print 'param: ', param
    Given params param
    When method get
    And print 'url: ', karate.prevRequest.url
    And print 'headers: ', karate.prevRequest.headers
    Then print 'Response: ', response
    * def expectedStatus = <checkStatus>
    * match responseStatus == expectedStatus
    * if (expectedStatus == 200) karate.match(response.quantidade, schema.quantidade)
    * if (expectedStatus == 200) karate.match('each response.usuarios[*] == schema.usuarios[0]')
    * if (expectedStatus == 400) karate.match('response.<Search> contains "<Message>"')

    Examples:
      | Valor         | Search        | checkStatus | Message                                      |
      | ID            | _id           | 200         |                                              |
      | Nombre        | nome          | 200         |                                              |
      | Contrasenia   | password      | 200         |                                              |
      | Administrador | administrador | 400         | administrador deve ser \'true\' ou \'false\' |
      | Email         | email         | 400         | email deve ser uma string                    |

  Scenario Outline: Validación por status - Busqueda por <Valor> no registrado
    * def param = data.Params.<Search>
    * set param.<Search> = 'UserServerDelete'
    * print ' param: ', param
    Given params param
    When method get
    And print 'url: ', karate.prevRequest.url
    And print 'headers: ', karate.prevRequest.headers
    Then print 'Response: ', response
    * def expectedStatus = <checkStatus>
    * match responseStatus == expectedStatus
    * if (expectedStatus == 200) karate.match(response.quantidade, schema.quantidade)
    * if (expectedStatus == 200) karate.match('response.usuarios[0] == "#notpresent"')
    * if (expectedStatus == 400) karate.match('response.<Search> contains "<Message>"')

    Examples:
      | Valor         | Search        | checkStatus | Message                                      |
      | ID            | _id           | 200         | -                                            |
      | Nombre        | nome          | 200         | -                                            |
      | Contrasenia   | password      | 200         | -                                            |
      | Administrador | administrador | 400         | administrador deve ser \'true\' ou \'false\' |
      | Email         | email         | 400         | email deve ser um email válido               |

  Scenario Outline: Caso - Listar usuarios registrados - Busqueda por <Valor>
    * def param = data.Params.<Search>
    * remove param
    * print ' param: ', param
    Given params param
    When method get
    And print 'url: ', karate.prevRequest.url
    And print 'headers: ', karate.prevRequest.headers
    And print 'response: ', response
    Then status 200
    And match $.quantidade == schema.quantidade
    And match each $.usuarios[*] == schema.usuarios[0]

    Examples:
      | Valor         | Search        |
      | ID            | _id           |
      | Administrador | administrador |
      | Email         | email         |
      | Nombre        | nome          |
      | Contrasenia   | password      |

  Scenario: Caso - Listar usuarios registrados - Busqueda por todos los parametros
#    * def param = data.Params.All
##    * print ' param: ', param
##    Given params param
##    When method get
##    And print 'url: ', karate.prevRequest.url
##    And print 'headers: ', karate.prevRequest.headers
##    And print 'response: ', response
##    Then status 200
##    And match $.quantidade == schema.quantidade
##    And match each $.usuarios[*] == schema.usuarios[0]