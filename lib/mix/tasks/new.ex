
defmodule Mix.Tasks.Nimler.New do
  use Mix.Task
  import Mix.Generator

  @files [
    "nif.nim",
    "nim.cfg"
  ]

  def run(_) do
    app = Mix.Project.config() |> Keyword.get(:app)
    app_name = app |> Atom.to_string |> String.capitalize

    root = Path.join(:code.priv_dir(:nimler), "templates")
    outroot = Path.join(File.cwd!(), "lib/native")

    Enum.each(@files, fn file ->
      temp = File.read!(Path.join(root, file))
      rendered = EEx.eval_string(temp, [module_name: "#{app_name}.Nif"])
      create_file(Path.join(outroot, file), rendered)
      end)
  end
end

