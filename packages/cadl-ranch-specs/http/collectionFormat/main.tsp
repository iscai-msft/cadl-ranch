import "@typespec/http";
import "@azure-tools/cadl-ranch-expect";

using TypeSpec.Http;

@service({
  title: "Collection Format Testing",
  version: "2022-12-16-preview",
})
@doc("Test for collectionFormat.")
@supportedBy("dpg")
@scenarioService("/collectionFormat")
namespace CollectionFormat;

alias MultiCollectionFormatParameter = {
  @doc("Possible values for colors are [blue,red,green]")
  @query({
    format: "multi",
  })
  colors: string[];
};

alias CsvCollectionFormatParameter = {
  @doc("Possible values for colors are [blue,red,green]")
  @query({
    format: "csv",
  })
  colors: string[];
};

alias DefaultCollectionFormatParameter = {
  @doc("Possible values for colors are [blue,red,green]")
  @query
  colors: string[];
};

alias CsvCollectionFormatHeaderParameter = {
  @doc("Possible values for colors are [blue,red,green]")
  @header({
    format: "csv",
  })
  colors: string[];
};

alias DefaultCollectionFormatHeaderParameter = {
  @doc("Possible values for colors are [blue,red,green]")
  @header
  colors: string[];
};

model MessageResponse {
  message: string;
}

@scenario
@scenarioDoc("""
This test is testing sending a multi collection format array query parameters
""")
@route("/multi")
op testMulti(...MultiCollectionFormatParameter): MessageResponse;

@scenario
@scenarioDoc("""
This test is testing sending a csv collection format array query parameters
""")
@route("/csv")
op testCsv(...CsvCollectionFormatParameter): MessageResponse;

// @scenario
// @scenarioDoc("""
// This test is testing sending a default collection format array query parameters
// """)
// @route("/default")
// op testDefault(...DefaultCollectionFormatParameter): string;

@scenario
@scenarioDoc("""
This test is testing sending a csv collection format array header parameters
""")
@route("/csvHeader")
op testCsvHeader(...CsvCollectionFormatHeaderParameter): MessageResponse;

@scenario
@scenarioDoc("""
This test is testing sending a default collection format array header parameters
""")
@route("/defaultHeader")
op testDefaultHeader(...DefaultCollectionFormatHeaderParameter): MessageResponse;
