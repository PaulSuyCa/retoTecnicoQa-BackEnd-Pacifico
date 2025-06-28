@TOTAL
@ServerUsuarios
@DeleteServerUsuariosId
Feature: Casos de prueba para Apis Delete de ServerUsuarios
  Como usuario de ServerUsuarios
  Quiero ejecutar el Api DELETE
  Para obtener los resultados esperados Excluir usuario por Id

  Background: Antecedente DELETE
    # url del api
    * url baseServerUsuarios + '/usuarios'
    # lee y cpnfiguracion de data de archivos
    * def data = read('classpath:resources/dataPath/serverUsuarios/deleteUsuarios/deleteUsuariosId.json')
    # esquema del response
    * def schema = read('classpath:resources/schema/serverUsuarios/getUsuarios.json')

  Scenario: Caso - Excluir usuario por Id - Eliminar con path vacio
    * set data.UsuarioEL.path = ''
    * def path = data.UsuarioEL.path
    * print path
    Given path path
    When method delete
    And print 'url: ', karate.prevRequest.url
    And print 'headers: ', karate.prevRequest.headers
    And print 'response: ', response
    Then status 405
    And match response.message contains "Não é possível realizar DELETE em /usuarios/. Acesse https://serverest.dev para ver as rotas disponíveis e como utilizá-las."

  Scenario: Caso - Excluir usuario por Id - Eliminar path vacio
    * set data.UsuarioEL.path = 'usuarioNoExistente'
    * def path = data.UsuarioEL.path
    * print path
    Given path path
    When method delete
    And print 'url: ', karate.prevRequest.url
    And print 'headers: ', karate.prevRequest.headers
    And print 'response: ', response
    Then status 200
    And match response.message contains "Nenhum registro excluído"

  Scenario: Caso - Excluir usuario por Id - No Elimina registros
    * def path = data.UsuarioRT.path
    * print path
    Given path path
    When method delete
    And print 'url: ', karate.prevRequest.url
    And print 'headers: ', karate.prevRequest.headers
    And print 'response: ', response
    Then status 200
    And match response.message contains "Nenhum registro excluído"

  Scenario: Caso - Excluir usuario por Id - No Elimina registros usuario con carrito
    * def path = data.UsuarioEL.path
    * print path
    Given path path
    When method delete
    And print 'url: ', karate.prevRequest.url
    And print 'headers: ', karate.prevRequest.headers
    And print 'response: ', response
    Then status 400
    And match response.message contains "Não é permitido excluir usuário com carrinho cadastrado"
    And match response.idCarrinho contains "qbMqntef4iTOwWfg"