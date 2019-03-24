import io.gatling.core.Predef._
import io.gatling.http.Predef._
import scala.concurrent.duration._

class CalculatorSimulation extends Simulation {

    val httpProtocol = http.baseUrl("http://localhost:8080/")
    
    val scn = scenario("Stress calculator operations history")
            .exec(http("Sum")
                .get("/calc/sum/1/2")
                .check(status.is(200)))
            .exec(http("Sub")
                .get("/calc/sub/1/2")
                .check(status.is(200)))
            .exec(http("Mul")
                .get("/calc/mul/10/5")
                .check(status.is(200)))
            .exec(http("Div")
                .get("/calc/div/5/0")
                .check(status.is(200)))
            .exec(http("History")
                .get("/calc/history")
                .check(status.is(200)))
    
    setUp(scn.inject(constantUsersPerSec(100).during(60 seconds)))
            .protocols(httpProtocol)

}