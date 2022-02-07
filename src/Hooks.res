module Form = {
  type onSubmit = ReactEvent.Form.t => unit

  type formState = {
    errors: Js.Dict.t<Error.t>,
    isDirty: bool,
    dirtyFields: Js.Dict.t<bool>,
    touchedFields: Js.Dict.t<bool>,
    isSubmitted: bool,
    isSubmitting: bool,
    isSubmitSuccessful: bool,
    isValid: bool,
    isValidating: bool,
    submitCount: int,
  }

  @deriving({abstract: light})
  type config = {
    @optinal
    mode: [#onSubmit | #onBlur | #onChange | #onTouched | #all],
    @optional
    revalidateMode: [#onSubmit | #onBlur | #onChange],
    @optional
    defaultValues: Js.Json.t,
    @optional
    shouldFocusError: bool,
    @optional
    shouldUnregister: bool,
    @optional
    shouldUseNativeValidation: bool,
    @optional
    delayError: int,
    @optional
    criteriaMode: [#firstError | #all],
  }

  type t = {
    clearErrors: (. string) => unit,
    control: Control.t,
    formState: formState,
    getValues: (. array<string>) => Js.Json.t,
    handleSubmit: (. (@uncurry Js.Json.t, ReactEvent.Form.t) => unit) => onSubmit,
    reset: (. option<Js.Json.t>) => unit,
    setError: (. string, Error.t) => unit,
    setFocus: (. string) => unit,
    setValue: (. string, Js.Json.t) => unit,
    register: (. string) => Register.t,
  }

  @module("react-hook-form")
  external use: (. ~config: config=?, unit) => t = "useForm"

  @send
  external setErrorAndFocus: (t, string, Error.t, @as(json`{shouldFocus: true }`) _) => unit =
    "setError"

  @send external trigger: (t, string) => unit = "trigger"

  @send external triggerMultiple: (t, array<string>) => unit = "trigger"

  @send
  external triggerAndFocus: (t, string, @as(json`{shouldFocus: true}`) _) => unit = "trigger"
}

module Controller = {
  open Controller
  type t = {
    field: field,
    fieldState: fieldState,
    formState: Form.formState,
  }

  @deriving({abstract: light})
  type config = {
    name: string,
    @optional
    control: Control.t,
    @optional
    defaultValue: Js.Json.t,
    @optional
    rules: Rules.t,
    @optional
    shouldUnregister: bool,
  }

  @module("react-hook-form")
  external use: (. string, ~config: config=?, unit) => t = "useController"
}

module WatchValues = {
  type rec input<'a, 'b> =
    | Text: input<string, string>
    | Texts: input<array<string>, array<option<string>>>
    | Checkbox: input<string, bool>
    | Checkboxes: input<array<string>, array<option<bool>>>

  @deriving({abstract: light})
  type config<'a> = {
    name: 'a,
    @optional
    control: Control.t,
    @optional
    defaultValue: Js.Json.t,
  }

  @module("react-hook-form")
  external use: (@ignore input<'a, 'b>, ~config: config<'a>=?, unit) => option<'b> = "useWatch"
}

module Context = {
  @module("react-hook-form")
  external use: (. ~config: Form.config=?, unit) => Form.t = "useFormContext"
}
