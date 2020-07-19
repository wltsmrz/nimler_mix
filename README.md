Nimler helpers for Elixir

## Installation

1. Install nim

2. Install nimler using nimble. `nimble install nimler`

3. Add `nimler` to mix.exs and run `mix deps.get` to install nimler from hex.pm

```mix.exs
  def deps() do
    [{:nimler, "~> 0.1.1"}]
  end
```

4. `mix nimler.new` to generate scaffold NIF project

5. `mix compile.nimler` to compile NIF with nimler

## mix nimler.new

Generate basic nimler NIF

**Defaults**

`lib/native` is default NIF root

`lib/native/nif.nim` is default NIF file

`lib/native/nim.cfg` is default NIF nim configuration. This will be used during compilation. See [priv/templates/nim.cfg](priv/templates/nim.cfg) for current nim.cfg template

## mix compile.nimler

Compile NIFs in `lib/native` using [nimler](https://github.com/wltsmrz/nimler)

Nimler generates `lib/native/nif_wrapper.ex` by default

**Configuration sample**

```mix.exs
  def project do
    [
      app: :myproject,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(),

      # add the nimler compiler
      compilers: Mix.compilers ++ [:nimler],

      # add optional nimler_config
      nimler_config: nimler_config()
    ]
  end

  def nimler_config() do
    [
      # compile_mode can be one of :debug, :release, :danger
      compile_mode: :debug,

      # compile_flags are passed directly to nim compiler
      # see [priv/templates/nim.cfg](priv/templates/nim.cfg) for default nim cfg
      compile_flags: [
        "--verbosity:2"
      ]
    ]
  end

  def deps() do
    [{:nimler, "~> 0.1.1"}]
  end

```

