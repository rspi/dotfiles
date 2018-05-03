Application.put_env(:elixir, :ansi_enabled, true)

IEx.configure(
  colors: [
    syntax_colors: [
      number: :green,
      atom: :green,
      string: :green,
      boolean: :green,
      nil: [:white, :bright]
    ],
    ls_directory: :blue,
    ls_device: :yellow,
    doc_code: [:magenta, :bright],
    doc_inline_code: :magenta,
    doc_headings: [:blue, :underline],
    doc_title: [:blue, :bright, :underline]
  ],
  default_prompt:
    [
      # ANSI CHA, move cursor to column 1
      "\e[G",
      :magenta,
      # IEx prompt variable
      "%prefix",
      # plain string
      ">",
      :reset
    ]
    |> IO.ANSI.format()
    |> IO.chardata_to_string()
)
