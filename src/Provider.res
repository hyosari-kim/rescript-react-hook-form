module P = {
  @module("react-hook-form") @react.component
  external make: (~children: React.element) => React.element = "FormProvider"
}

module F = (Fields: Hooks.FormFields) => {
  module Form = Hooks.Form(Fields)

  @react.component
  let make = (~children, ~methods: Form.t) =>
    <ReactUtil.SpreadProps props={methods}> <P> {children} </P> </ReactUtil.SpreadProps>
}
