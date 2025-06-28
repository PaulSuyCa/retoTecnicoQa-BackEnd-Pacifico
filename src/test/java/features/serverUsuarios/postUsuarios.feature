@TOTAL
@ServerUsuarios
@PostServerUsuarios
Feature: Casos de prueba para Apis Post de ServerUsuarios
  Como usuario de ServerUsuarios
  Quiero ejecutar el Api Post
  Para obtener los resultados esperados Registrar Usuarios

  Background: Antecedente POST
    # url del api
    * url baseServerUsuarios + '/usuarios'
    # lee y cpnfiguracion de data de archivos
    * def data = read('classpath:resources/dataPath/serverUsuarios/postUsuarios/'+ dataPath +'/postUsuario.json')

  Scenario Outline: Caso - Registrar usuarios - Registro con el <Valor> no ingresada
    * def body = data.body.Existente
    * remove body.Existente.<Search>
    When method post
    And print 'url: ', karate.prevRequest.url
    And print 'headers: ', karate.prevRequest.headers
    And print 'response: ', response
    Then status 411

    Examples:
      | Valor         | Search        |
      | Nombre        | nome          |
      | Email         | email         |
      | Contrasenia   | password      |
      | Administrador | administrador |

  Scenario: Caso - Registrar usuarios - Registro un body no ingresado
    When method post
    And print 'url: ', karate.prevRequest.url
    And print 'headers: ', karate.prevRequest.headers
    And print 'response: ', response
    Then status 411

  Scenario Outline: Caso - Registrar usuarios - Registro con el <Valor> es vacio
    * def body = data.body.Existente
    * set body.Existente.<Search> = ''
    When method post
    And print 'url: ', karate.prevRequest.url
    And print 'headers: ', karate.prevRequest.headers
    And print 'response: ', response
    Then status 411

    Examples:
      | Valor         | Search        |
      | Nombre        | nome          |
      | Email         | email         |
      | Contrasenia   | password      |
      | Administrador | administrador |