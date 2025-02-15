import "@typespec/http";
import "@azure-tools/cadl-ranch-expect";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Http;
using Azure.ClientGenerator.Core;

@doc("Illustrates models with optional properties.")
@scenarioService("/models/properties/optional")
namespace Models.Property.Optional;

@doc("Template type for testing models with optional property. Pass in the type of the property you are looking for")
model ModelTemplate<TProperty> {
  @doc("Property")
  property?: TProperty;
}

@doc("Operations associated with getting and putting models with optional properties.")
interface OperationsTemplate<TModel, TDoc extends string, TDefaultDoc extends string = "{}"> {
  @doc("Get models that will return all properties in the model")
  @scenario
  @scenarioDoc(
    """
  Expected response body:
  ```json
  {"property": {doc}}
  ```
  """,
    {
      allDoc: TDoc,
    }
  )
  @route("/all")
  @get
  getAll(): TModel;

  @doc("Get models that will return the default object")
  @scenario
  @scenarioDoc(
    """
  Expected response body:
  ```json
  {defaultDoc}
  ```
  """,
    {
      defaultDoc: TDefaultDoc,
    }
  )
  @route("/default")
  @get
  getDefault(): TModel;

  @doc("Put a body with all properties present.")
  @scenario
  @scenarioDoc(
    """
  Expected request body:
  ```json
  {allDoc}
  ```
  """,
    {
      allDoc: TDoc,
    }
  )
  @route("/all")
  @put
  putAll(@body body: TModel): void;

  @doc("Put a body with default properties.")
  @scenario
  @scenarioDoc(
    """
  Expected request body:
  ```json
  {defaultDoc}
  ```
  """,
    {
      defaultDoc: TDefaultDoc,
    }
  )
  @route("/default")
  @put
  putDefault(@body body: TModel): void;
}

// Model with optional string property
model StringProperty is ModelTemplate<string>;
@route("/string")
@operationGroup
interface String extends OperationsTemplate<StringProperty, "hello"> {}

// Model with optional bytes property
model BytesProperty is ModelTemplate<bytes>;
@route("/bytes")
@operationGroup
interface Bytes extends OperationsTemplate<BytesProperty, "aGVsbG8sIHdvcmxkIQ=="> {}

// Model with optional datetime property
@doc("Model with a datetime property")
model DatetimeProperty is ModelTemplate<zonedDateTime>;
@route("/datetime")
@operationGroup
interface Datetime extends OperationsTemplate<DatetimeProperty, "2022-08-26T18:38:00Z"> {}

// Model with optional duration property
@doc("Model with a duration property")
model DurationProperty is ModelTemplate<duration>;
@route("/duration")
@operationGroup
interface Duration extends OperationsTemplate<DurationProperty, "P123DT22H14M12.011S"> {}

// Model with optional collection bytes property
@doc("Model with collection bytes properties")
model CollectionsByteProperty is ModelTemplate<bytes[]>;
@route("/collections/bytes")
@operationGroup
interface CollectionsByte
  extends OperationsTemplate<CollectionsByteProperty, "[aGVsbG8sIHdvcmxkIQ==, aGVsbG8sIHdvcmxkIQ==]"> {}

// Model with optional collection models property
@doc("Model with collection models properties")
model CollectionsModelProperty is ModelTemplate<StringProperty[]>;
@route("/collections/model")
@operationGroup
interface CollectionsModel
  extends OperationsTemplate<CollectionsModelProperty, "[{'property': 'hello'}, {'property': 'world'}]"> {}

@doc("Model with required and optional properties")
model RequiredAndOptionalProperty {
  @doc("optional string property")
  optionalProperty?: string;

  @doc("required int property")
  requiredProperty: int32;
}
@doc("Test optional and required properties")
@route("/requiredAndOptional")
@operationGroup
interface RequiredAndOptional {
  @doc("Get models that will return all properties in the model")
  @scenario
  @scenarioDoc("""
  Expected response body:
  ```json
  {"optionalProperty": "hello", "requiredProperty": 42}
  ```
  """)
  @route("/all")
  @get
  getAll(): RequiredAndOptionalProperty;

  @doc("Get models that will return only the required properties")
  @scenario
  @scenarioDoc("""
  Expected response body:
  ```json
  {"requiredProperty": 42}
  ```
  """)
  @route("/requiredOnly")
  @get
  getRequiredOnly(): RequiredAndOptionalProperty;

  @doc("Put a body with all properties present.")
  @scenario
  @scenarioDoc("""
  Expected request body:
  ```json
  {"optionalProperty": "hello", "requiredProperty": 42}
  ```
  """)
  @route("/all")
  @put
  putAll(@body body: RequiredAndOptionalProperty): void;

  @doc("Put a body with only required properties.")
  @scenario
  @scenarioDoc("""
  Expected request body:
  ```json
  {"requiredProperty": 42}
  ```
  """)
  @route("/requiredOnly")
  @put
  putRequiredOnly(@body body: RequiredAndOptionalProperty): void;
}
