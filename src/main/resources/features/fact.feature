@Test
Feature: Pets shop
  Background:
   Given host "http://localhost:8080"


  @test1
  Scenario: Validate service response when updating data of an existing pet in the shop.
    Given a timeout of 5000 milliseconds
    When a PUT request is sent to endpoint "/api/v3/pet" with body
     |{"id":10,"name":"Brandon","category":{"id":1,"name":"Dogs"},"photoUrls":["string"],"tags":[{"id":0,"name":"string"}],"status":"available"} |
    Then status code should be 200
    And json response should contain key "id" with value number 10


  @test @test2
  Scenario Outline: Validate service response when entering a new pet into the store.
    Given a timeout of 5000 milliseconds
    When a POST request is sent to endpoint "/api/v3/pet" with body
      |<body> |
    Then status code should be 200
    And json response should contain key "name" with value string "Neron"

    Examples:
      |body            |
      | {"id":170,"name":"Neron","category":{"id":1,"name":"Neron 1"},"photoUrls":["string"],"tags":[{"id":0,"name":"string"}],"status":"available"} |


  @test @test4
  Scenario: Validate service response when consulting pets by state.
    Given a timeout of 5000 milliseconds
    When a GET request is sent to endpoint "/api/v3/pet/findByStatus" with query parameters
      |status |available |
    Then status code should be 200
    And response content type should be json


  @test @test5
  Scenario Outline: Validate service response when consulting pets by tags.
    Given a timeout of 5000 milliseconds
    When a GET request is sent to endpoint "/api/v3/pet/findByTags" with query parameters
      |tags |<tags> |
    Then status code should be 200
    And response content type should be json


    Examples: GetPet
      |tags           |
      |tags1          |


  @test @test7
  Scenario: Validate service response when querying pets by ID.
    Given a timeout of 5000 milliseconds
    When a GET request is sent to endpoint "/api/v3/pet/4"
    Then status code should be 200
    And response content type should be json

  @test @test8
  Scenario: Validate service response when querying pets entering an ID that doesn't exist.
    Given a timeout of 5000 milliseconds
    When a GET request is sent to endpoint "/api/v3/pet/111222"
    Then status code should be 404
    And response content type should be json

  @test @test9
  Scenario: Validate service response when querying pets entering an incorrect ID.
    Given a timeout of 5000 milliseconds
    When a GET request is sent to endpoint "/api/v3/pet/hola"
    Then status code should be 400
    And response content type should be json


  @test @test10
  Scenario Outline: Validate service response when updating the data of a pet by sending the DNI in String format.
    Given a timeout of 5000 milliseconds
    When a PUT request is sent to endpoint "/api/v3/pet" with body
      |<body> |
    Then status code should be 400
    And response content type should be json

    Examples:
      |body            |
      |{"id":"s","name":"Brandon","category":{"id":1,"name":"Dogs"},"photoUrls":["string"],"tags":[{"id":0,"name":"string"}],"status":"available"} |


  @test @test11
  Scenario: Validate service response when deleting a pet.
    Given a timeout of 5000 milliseconds
    When a DELETE request is sent to endpoint "/api/v3/pet/2"
    Then status code should be 200
    And response content type should be json