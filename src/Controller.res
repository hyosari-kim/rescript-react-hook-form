module OnChangeArg: {
  type rec t

  type kind = Event(ReactEvent.Form.t) | Value(Js.Json.t)

  let event: ReactEvent.Form.t => t
  let value: Js.Json.t => t

  let classify: t => kind
} = {
  @unboxed
  type rec t = Any('a): t

  type kind = Event(ReactEvent.Form.t) | Value(Js.Json.t)

  let event = eventHandler => Any(eventHandler)
  let value = valueHandler => Any(valueHandler)

  let classify = (Any(unknown)) =>
    unknown->Js.typeof == "object" &&
    unknown->Js.Nullable.return->Js.Nullable.isNullable->not &&
    Obj.magic(unknown)["_reactName"] == "onChange"
      ? Event(Obj.magic(unknown))
      : Value(Obj.magic(unknown))
}

type field = {
  name: string,
  onBlur: unit => unit,
  onChange: OnChangeArg.t => unit,
  value: Js.Json.t,
  ref: ReactDOM.domRef,
}

type fieldState = {invalid: bool, isTouched: bool, isDirty: bool, error: option<Error.t>}

type render = {field: field, fieldState: fieldState}

@module("react-hook-form") @react.component
external make: (
  ~name: string,
  ~control: Control.t=?,
  ~render: render => React.element,
  ~defaultValue: Js.Json.t=?,
  ~rules: Rules.t=?,
  ~shouldUnregister: bool=?,
) => React.element = "Controller"
