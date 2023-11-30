open Aoc23
let () =
  let _contents = Utils.read_day "resources/day1.txt" in
  let _split = (List.map String.(fun s -> split_on_char '\n' (trim s)) (Str.split (Str.regexp "\n\n") _contents)
    |> List.map (fun l -> List.fold_left ( + ) 0 (List.map int_of_string l))) in
  Printf.printf "%d\n" (List.fold_left max 0 _split)