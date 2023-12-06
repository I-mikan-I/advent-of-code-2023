open Containers

let input = Utils.read_day "resources/day5.txt"

let seeds =
  Scanf.sscanf input "seeds: %s@\n" Fun.id
  |> String.split_on_char ' ' |> List.map int_of_string

let seedpairs =
  let flip = ref false in
  Fun.uncurry List.combine
    (List.partition
       (fun _ ->
         flip := not !flip;
         !flip)
       seeds)

let tables =
  Str.bounded_split (Str.regexp "\n\n[^0-9]+\n") input 2
  |> Fun.flip List.nth 1
  |> Str.split (Str.regexp "\n\n[^0-9]+\n")

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
      match found with Some (h :: h2 :: _ :: _) -> num - h2 + h | _ -> num)
    input

let rec mapr (start1, len1) (start2, len2) goal =
  if start2 <= start1 && start2 + len2 >= start1 + len1 then
    ([ (goal + start1 - start2, len1) ], [])
  else if start2 <= start1 && start1 < start2 + len2 then
    let mapped, rest =
      mapr (len2 + start2, len1 - len2 + start1 - start2) (start2, len2) goal
    in
    ((goal + start1 - start2, len2 - start1 + start2) :: mapped, rest)
  else if start2 < start1 + len1 && start2 > start1 then
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

let ex01 () =
  let mapped =
    List.fold_left (fun seeds table -> map table seeds) seeds tables
  in
  let min = List.reduce_exn min mapped in
  print_endline @@ [%show: int] min

let ex02 () =
  let mapped =
    List.fold_left (fun seeds table -> maps table seeds) seedpairs tables
  in
  let min =
    List.fold_left (Fun.flip @@ Fun.compose fst min) 0x0fffffffffffffff mapped
  in
  print_endline @@ [%show: int] min

let exec () =
  ex01 ();
  ex02 ()

let%expect_test "it_works" =
  ex01 ();
  ex02 ();
  [%expect {|
    382895070
    17729182 |}]
