import "@typespec/http";
import "@azure-tools/cadl-ranch-expect";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using Azure.Core;

@scenarioService("/lro/basic")
@doc("All the basic lro test shall be added in this file")
namespace Azure.Lro;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "For testing"
@scenario
@scenarioDoc("The polling url is in operation-location of response headers. Mock api finally return 'Test for polling succeed'")
@route("/put")
interface PollingSuccess {
  @doc("Test for basic lro of put")
  @pollingOperation(PollingSuccess.polling)
  @put
  create(): string;

  @doc("The polling url")
  @route("/polling")
  @get
  polling(): string;

  @doc("The final url")
  @get
  get(): string;
}
