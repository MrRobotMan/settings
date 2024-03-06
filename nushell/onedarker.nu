export def main [] {
  let yellow = "#D5B06B"
  let blue = "#519FDF"
  let red = "#D05C65"
  let purple = "#B668CD"
  let green = "#7DA869"
  let gold = "#D19A66"
  let cyan = "#46A6B2"
  let white = "#ABB2BF"
  let black = "#16181A"
  let light_black = "#2C323C"
  let gray = "#252D30"
  let faint_gray = "#ABB2BF"
  let light_gray = "#636C6E"
  let linenr = "#282C34"

    {
        # color for nushell primitives
        separator: white
        leading_trailing_space_bg: { attr: n } # no fg, no bg, attr none effectively turns this off
        header: light_black
        empty: blue
        # Closures can be used to choose colors for specific values.
        # The value (in this case, a bool) is piped into the closure.
        # eg) {|| if $in { 'light_cyan' } else { 'light_gray' } }
        bool: gold
        int: gold
        filesize: cyan
        duration: white
        date: purple
        range: gold
        float: gold
        string: green
        nothing: white
        binary: white
        cell-path: white
        row_index: light_black
        record: gold
        list: white
        block: white
        hints: dark_gray
        search_result: {bg: red fg: white}
        shape_and: {fg: purple, attr: b}
        shape_binary: {fg: purple, attr: b}
        shape_block: {fg: light_gray, attr: b}
        shape_bool: gold
        shape_closure: green
        shape_custom: green
        shape_datetime: {fg: cyan, attr: b}
        shape_directory: cyan
        shape_external: cyan
        shape_externalarg: green
        shape_external_resolved: {fg: yellow_bold, attr: b}
        shape_filepath: cyan
        shape_flag: blue
        shape_float: yellow
        # shapes are used to change the cli syntax highlighting
        shape_garbage: { fg: white bg: red attr: b}
        shape_globpattern: {fg: cyan, attr: b}
        shape_int: yellow
        shape_internalcall: {fg: cyan, attr: b}
        shape_keyword: {fg: cyan, attr: b}
        shape_list: {fg: cyan, attr: b}
        shape_literal: blue
        shape_match_pattern: green
        shape_matching_brackets: {fg: blue,  attr: u }
        shape_nothing: cyan
        shape_operator: yellow
        shape_or: {fg: purple, attr: b}
        shape_pipe: {fg: purple, attr: b}
        shape_range: gold
        shape_record: {fg: cyan, attr: b}
        shape_redirection: {fg: purple, attr: b}
        shape_signature: light_black
        shape_string: green
        shape_string_interpolation: {fg: green, attr: b}
        shape_table: cyan
        shape_variable: gold
        shape_vardecl: while
    }
}
