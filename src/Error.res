type t = {message: string, @as("type") type_: string}

@module("react-hook-form")
external get: (Js.Dict.t<t>, string) => option<t> = "get"
