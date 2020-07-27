ruby -ne 'puts $_.encode("UTF-8", "binary", invalid: :replace, undef: :replace, replace: "")'
