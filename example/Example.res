module FormWithRegister = {
  @react.component
  let make = () => {
    let {handleSubmit, register} = Hooks.Form.use(.
      ~config=Hooks.Form.config(~mode=#onSubmit, ()),
      (),
    )
    let (result, setResult) = React.Uncurried.useState(_ => "")

    let onSubmit = (data: Js.Json.t, _event) => {
      setResult(._ => data->Js.Json.stringifyAny->Option.getWithDefault(""))
    }

    let firstName = register(. "firstName")
    let category = register(. "category")
    let aboutYou = register(. "aboutYou")

    <form onSubmit={handleSubmit(. onSubmit)}>
      <h2 className="h2"> {"useForm with register"->React.string} </h2>
      <input
        placeholder="First name"
        onChange=firstName.onChange
        onBlur=firstName.onBlur
        ref=firstName.ref
        name=firstName.name
      />
      <select onChange=category.onChange onBlur=category.onBlur ref=category.ref name=category.name>
        <option value=""> {"Select"->React.string} </option>
        <option value="A"> {"Option A"->React.string} </option>
        <option value="B"> {"Option B"->React.string} </option>
      </select>
      <textarea
        placeholder="Abount you"
        onChange=aboutYou.onChange
        onBlur=aboutYou.onBlur
        ref=aboutYou.ref
        name=aboutYou.name
      />
      <p> {result->React.string} </p>
      <input type_="submit" />
    </form>
  }
}

module FormWithController = {
  @react.component
  let make = () => {
    <form> <h2 className="h2"> {"useForm with control"->React.string} </h2> </form>
  }
}

module Forms = {
  @react.component
  let make = () => {
    <div> <Header /> <FormWithRegister /> <FormWithController /> </div>
  }
}

switch ReactDOM.querySelector("#root") {
| None => Js.Exn.raiseError("#root node not found")
| Some(root) => ReactDOM.render(<Forms />, root)
}
