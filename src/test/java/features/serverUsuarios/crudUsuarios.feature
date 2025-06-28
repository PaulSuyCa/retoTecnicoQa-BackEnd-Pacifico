@TOTAL
@ServerUsuarios
@Crud
Feature: Casos de prueba CRUD Usuario

  Background: Antecedente CRUD
    * url baseServerUsuarios + '/usuarios'
    * def dataGet = read('classpath:resources/dataPath/serverUsuarios/getUsuarios/getUsuario.json')
    * def dataPost = read('classpath:resources/dataPath/serverUsuarios/postUsuarios/'+ dataPath +'/postUsuario.json')
    # esquema del response
    * def schemaGet = read('classpath:resources/schema/serverUsuarios/getUsuarios.json')
    * def schemaPost = read('classpath:resources/schema/serverUsuarios/postUsuarios.json')
    # Registrar Usuario Nuevo
    * def body = dataPost.body.Nuevo
    And request body
    When method post
    And print response
    Then status 201
    And match $ == schemaPost
    * def UsuarioId = response._id
    * print 'Usuario Id: ', UsuarioId

  Scenario: Caso CRUD - Consultar, Actualizar y Eliminar registro usuarios
    # Registro correo existente
    * def body = dataPost.body.Nuevo
    And request body
    When method post
    And print response
    Then status 400
    And match response.message contains "Este email já está sendo usado"
    # Listado de Usuario
    * def param = dataGet.Params._id
    * set param._id = UsuarioId
    * print 'param: ', param
    Given params param
    When method get
    And print 'url: ', karate.prevRequest.url
    And print 'headers: ', karate.prevRequest.headers
    And print 'response: ', response
    Then status 200
    And match $.quantidade == schemaGet.quantidade
    And match each $.usuarios[*] == schemaGet.usuarios[0]
    # Actualizar Usuario
    * def body = dataPost.body.Nuevo
    * set body.nome = 'Testing User Server Actualizo'
    * print body
    Given path UsuarioId
    And request body
    When method put
    And print 'url: ', karate.prevRequest.url
    And print 'headers: ', karate.prevRequest.headers
    And print 'response: ', response
    Then status 200
    And match $.message contains "Registro alterado com sucesso"
    # Consultar Usuario
    Given path UsuarioId
    When method get
    And print 'url: ', karate.prevRequest.url
    And print 'headers: ', karate.prevRequest.headers
    And print 'response: ', response
    Then status 200
    And match $ == schemaGet.usuarios[0]
    # Eliminar Usuario
    Given path UsuarioId
    When method delete
    And print 'url: ', karate.prevRequest.url
    And print 'headers: ', karate.prevRequest.headers
    And print 'response: ', response
    Then status 200
    And match $.message contains "Registro excluído com sucesso"