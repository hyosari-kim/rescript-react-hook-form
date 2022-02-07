type t = {
  onChange: ReactEvent.Form.t => unit,
  onBlur: ReactEvent.Focus.t => unit,
  ref: ReactDOM.domRef,
  name: string,
}
