module P = {
  @module("react-hook-form") @react.component
  external make: (~children: React.element) => React.element = "FormProvider"
}

@react.component
let make = (~children, ~methods: Hooks.Form.t) =>
  <ReactUtil.SpreadProps props={methods}> <P> {children} </P> </ReactUtil.SpreadProps>
