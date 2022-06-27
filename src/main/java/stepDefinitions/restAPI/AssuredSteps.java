package stepDefinitions.restAPI;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.javafaker.Faker;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import common.utils.generator.*;
import httpClient.HttpClient;
import io.restassured.RestAssured;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import io.restassured.response.ResponseBody;
import io.restassured.specification.RequestSpecification;

import org.apache.commons.lang3.StringUtils;
import org.junit.Assert;
import org.springframework.web.util.UriUtils;

import java.util.Locale;

import static io.restassured.RestAssured.*;
import static java.nio.charset.StandardCharsets.UTF_8;

public class AssuredSteps {

    public Response response;
    public RequestSpecification requestSpecification = RestAssured.given();

    @Given("^I have baseURI \"([^\"]*)\"$")
    public void iHaveBaseURI(String baseUri) {
        Api.setDomain(baseUri);
    }

    @Given("^I have basePath \"([^\"]*)\"$")
    public void iHaveBasePath(String basePath) throws Throwable {
        Api.setPath(UriUtils.encodeQuery(JsonBody.replaceVariablesValues(basePath), UTF_8));
        Hooks.scenario.write(HttpClient.getCompletePath());
    }

    @Given("^I have basePath with id \"([^\"]*)\"$")
    public void iHaveBasePathId(String basePath) throws Throwable {
        Integer id = response.getBody().jsonPath().getInt("id");
        Api.setPath(UriUtils.encodeQuery(JsonBody.replaceVariablesValues(basePath + id), UTF_8));
        Hooks.scenario.write(HttpClient.getCompletePath());
    }

    @Given("^I send the GET request$")
    public void iSendTheGet() {
        response = given()
                .when()
                .get(HttpClient.getCompletePath())
                .then()
                .and()
                .log().all().extract().response();
    }

    @Given("^I send the POST request$")
    public void ISendThePOSTRequestT() {
        response = given()
                .contentType("application/json")
                .body(JsonBody.getJsonBodyString())
                .post(HttpClient.getCompletePath())
                .then()
                .and()
                .log().all().extract().response();
    }

    @Given("^I send the PUT request$")
    public void iSendThePutRequestTest() throws Throwable {
        response = given()
                .contentType("application/json")
                .when()
                .body(JsonBody.getJsonBodyString())
                .put(HttpClient.getCompletePath())
                .then().extract().response();
    }

    @Given("^I send the DELETE request$")
    public void ISendTheDELETERequest() {
        response = given()
                .contentType("application/json")
                .delete(HttpClient.getCompletePath())
                .then()
                .and()
                .log().all().extract().response();
    }

    @Then("^Http response should be (\\d+)$")
    public void httpResponseShouldBe(Integer statusCode) {
        Integer responseStatusCode = response.getStatusCode();
        Assert.assertEquals(responseStatusCode.toString(), statusCode.toString());
    }

    @Given("^I send the body$")
    public void iSendTheBody(String jsonBody) throws Throwable {
        JsonBody.setJsonBodyString(JsonBody.replaceVariablesValues(jsonBody));
        try {
            ObjectMapper mapper = new ObjectMapper();
            Object json = mapper.readValue(JsonBody.getJsonBodyString(), Object.class);
            String prettyJson = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(json);
            stepDefinitions.Hooks.scenario.write(prettyJson);
        } catch (Exception e) {
            Hooks.scenario.write(JsonBody.getJsonBodyString());
        }
    }

    @Then("^The response JSON must \"([^\"]*)\" have as the string \"([^\"]*)\"$")
    public void theResponseMustHaveAsString(String key, String value) throws Throwable {
        JsonPath jsonPathEvaluator = response.jsonPath();
        String message = jsonPathEvaluator.getString(key);
        Assert.assertEquals(message, value);
        Hooks.scenario.write(message);
    }

    @Then("^The variable \"([^\"]*)\" is not empty$")
    public void variableIsNotEmpty(String value) throws Throwable {
        JsonPath jsonPathEvaluator = response.jsonPath();
        String message = jsonPathEvaluator.getString(value);
        Hooks.scenario.write(String.valueOf(message.isEmpty()));
    }

    @Given("^I print the response$")
    public void iPrintTheResponse() throws Throwable {
        ResponseBody body = response.getBody();
        Hooks.scenario.write(body.asPrettyString());
    }
}
