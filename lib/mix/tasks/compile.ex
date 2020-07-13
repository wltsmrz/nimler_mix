
defmodule Mix.Tasks.Compile.Nim do
  use Mix.Task.Compiler

  @default_nim_root "lib/native"
  @default_nim_compile_mode :release
  @default_nim_compile_flags []
  @default_nim_nif_filename "nif.nim"

  @shortdoc "Compile nim nifs"
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

  def compile_nim(cmd) do
    nimler_config = Mix.Project.get!().nimler_config()
    nim_root = Keyword.get(nimler_config, :path, @default_nim_root_relative)
    nim_mode = Keyword.get(nimler_config, :mode, @default_nim_compile_mode)
    nim_flags = Keyword.get(nimler_config, :compile_flags, @default_nim_compile_flags)

    nim_mode_flag = "-d:" <> to_string(nim_mode)

    compile_root = Path.join(File.cwd!, nim_root)
    compile_args = ["c", nim_mode_flag] ++ nim_flags ++ [@default_nim_nif_filename]

    case System.cmd(cmd, compile_args, cd: compile_root) do
      {_, 0} -> 
        :ok
      _ ->
        Mix.Shell.IO.error("Failed to compile nimler module")
    end
  end
end
