import "@typespec/http";
import "@azure-tools/cadl-ranch-expect";

using TypeSpec.Http;

@doc("Illustrates parameterized @server")
@scenarioService("/server/parameterized")
@server(
  "{endpoint}",
  "Testserver endpoint",
  {
    @doc("Need to be set as 'http://localhost:3000' in client.")
    endpoint: url,
  }
)
namespace Server.Parameterized;

@scenario
@scenarioDoc("An simple operation in a parameterized server.")
@route("/myOp")
@head
op myOp(): OkResponse;
