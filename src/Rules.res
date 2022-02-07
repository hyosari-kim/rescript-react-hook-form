@deriving({abstract: light})
type t = {
  @optional
  required: bool,
  @optional
  maxLength: int,
  @optional
  minLength: int,
  @optional
  max: int,
  @optional
  min: int,
  @optional
  pattern: Js.Re.t,
  @optional
  validate: Js.Dict.t<Validation.t>,
}

let make = t
