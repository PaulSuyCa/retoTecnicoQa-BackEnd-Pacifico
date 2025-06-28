@TOTAL
@ServerUsuarios
@GeneracionData
Feature:Genera emails únicos y datos válidos

  Scenario: Generacion de data
    * def user = call read('classpath:helpers/generateUserData.js')
    * print user
    * request user