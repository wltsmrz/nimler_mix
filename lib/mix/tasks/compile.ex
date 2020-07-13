
defmodule Mix.Tasks.Compile.Nimler do
  @moduledoc "Compiles Nim source files"

  use Mix.Task.Compiler

  @default_root "lib/native"
  @default_compile_mode :release
  @default_compile_flags []
  @default_filename "nif.nim"

  def run(_) do
    case System.find_executable("nim") do
      nil ->
        Mix.Shell.IO.error("""
        Nim must be installed.

        See: https://nim-lang.org/install.html
        """)
      cmd ->
        compile_nim(cmd)
    end
  end

  defp compile_nim(cmd) do
    nimler_config = Keyword.get(Mix.Project.config(), :nimler_config, [])
    nim_root = Keyword.get(nimler_config, :root, @default_root)

    nim_mode = Keyword.get(nimler_config, :compile_mode, @default_compile_mode)
    nim_flags = Keyword.get(nimler_config, :compile_flags, @default_compile_flags)

    compile_root = Path.join(File.cwd!, nim_root)
    compile_args = [
      "c",
      "-d:" <> to_string(nim_mode),
      "-d:nimlerGenWrapperForce",
      "-d:nimlerWrapperRoot=" <> compile_root,
      "-d:nimlerWrapperFilename=nif_wrapper.ex"
    ]
    ++ nim_flags
    ++ [@default_filename]

    case System.cmd(cmd, compile_args,
      cd: compile_root, into: IO.stream(:stdio, :line)) do
      {_, 0} ->
        Mix.Shell.IO.info("Compiled nimler NIF")
      _ ->
        Mix.Shell.IO.error("Failed to compile nimler module")
    end
  end
end
