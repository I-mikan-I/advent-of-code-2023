open Containers

let input = Utils.read_day "resources/day5.txt"

let seeds =
  "4088478806 114805397 289354458 164506173 1415635989 166087295 1652880954 \
   340945548 3561206012 483360452 35205517 252097746 1117825174 279314434 \
   3227452369 145640027 2160384960 149488635 2637152665 236791935"
  |> String.split_on_char ' ' |> List.map int_of_string

let tbl1 =
  "4088478806 114805397 289354458 164506173 1415635989 166087295 1652880954 \
   340945548 3561206012 483360452 35205517 252097746 1117825174 279314434 \
   3227452369 145640027 2160384960 149488635 2637152665 236791935"

let tables = input |> Str.split (Str.regexp "\n\n[^0-9]+\n")

let map table input =
  let mappings =
    Utils.split_lines table
    |> List.map (String.split ~by:" ")
    |> List.map (List.map int_of_string)
  in
  List.map
    (fun num ->
      let found =
        List.find_opt
          (fun l ->
            if List.nth l 1 <= num && List.nth l 1 + List.nth l 2 >= num then
              true
            else false)
          mappings
      in
      match found with Some (h :: h2 :: h3 :: t) -> num - h2 + h | _ -> num)
    input

let rec mapr (start1, len1) (start2, len2) goal =
  print_endline @@ [%show: int * int * int * int] (start1, len1, start2, len2);
  if start2 <= start1 && start2 + len2 >= start1 + len1 then
    let _ = print_endline "case1" in
    ([ (goal + start1 - start2, len1) ], [])
  else if start2 <= start1 && start1 < start2 + len2 then
    let _ = print_endline "case2" in
    let mapped, rest =
      mapr (len2 + start2, len1 - len2 + start1 - start2) (start2, len2) goal
    in
    ((goal + start1 - start2, len2 - start1 + start2) :: mapped, rest)
  else if start2 < start1 + len1 && start2 > start1 then
    let _ = print_endline "case3" in
    let mapped, rest =
      mapr (start2, len1 - (start2 - start1)) (start2, len2) goal
    in
    (mapped, (start1, start2 - start1) :: rest)
  else ([], [ (start1, len1) ])

let maps table ranges =
  let mappings =
    Utils.split_lines table
    |> List.map (String.split ~by:" ")
    |> List.map (List.map int_of_string)
  in
  let rec iter in_ranges out_ranges =
    print_endline
    @@ [%show: (int * int) list * (int * int) list] (in_ranges, out_ranges);
    match in_ranges with
    | (start, len) :: t -> (
        let found =
          List.find_map
            (fun l ->
              let t, f, r = (List.nth l 0, List.nth l 1, List.nth l 2) in
              let mapped, rest = mapr (start, len) (f, r) t in
              if List.is_empty mapped then None else Some (mapped, rest))
            mappings
        in
        match found with
        | Some (mapped, rest) -> iter (rest @ t) (mapped @ out_ranges)
        | None -> iter t @@ ((start, len) :: out_ranges))
    | [] -> out_ranges
  in
  iter ranges []

let seeds =
  "4088478806,114805397 289354458,164506173 1415635989,166087295 \
   1652880954,340945548 3561206012,483360452 35205517,252097746 \
   1117825174,279314434 3227452369,145640027 2160384960,149488635 \
   2637152665,236791935" |> String.split_on_char ' '
  |> List.map (fun pair ->
         let o, t = Scanf.sscanf pair "%d,%d" (fun a b -> (a, b)) in
         (o, t))

let seedsmini =
  "79,14 55,13" |> String.split_on_char ' '
  |> List.map (fun pair ->
         let o, t = Scanf.sscanf pair "%d,%d" (fun a b -> (a, b)) in
         (o, t))

let exec () =
  let mapped =
    List.fold_left (fun seeds table -> maps table seeds) seeds tables
  in
  print_endline @@ [%show: (int * int) list] @@ mapped;
  let min = List.fold_left (Fun.flip @@ Fun.compose fst min) 100000000 mapped in
  print_endline @@ [%show: int] min

