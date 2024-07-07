function mermaid
  if test $argv[1]
    set output_type $argv[1] 
    for f in (ls *.mmd)
      mmdc $f -e $output_type
    end
  else
    for f in (ls *.mmd)
      mmdc $f -e svg
    end
  end
end
