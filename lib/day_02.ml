open Containers

let input = Utils.read_day "resources/day2.txt"

type color = Red | Green | Blue [@@deriving show]

let read_color str =
  let matched =
    Str.string_partial_match (Str.regexp "\\([0-9]+\\) red") str 0
  in
  if matched then Some (int_of_string @@ Str.matched_group 1 str, Red)
  else
    let matched =
      Str.string_partial_match (Str.regexp "\\([0-9]+\\) green") str 0
    in
    if matched then Some (int_of_string @@ Str.matched_group 1 str, Green)
    else
      let matched =
        Str.string_partial_match (Str.regexp "\\([0-9]+\\) blue") str 0
      in
      if matched then Some (int_of_string @@ Str.matched_group 1 str, Blue)
      else None

let totals lst' =
  List.fold_left
    (fun (r, g, b) (n, c) ->
      match c with
      | Red -> (r + n, g, b)
      | Green -> (r, g + n, b)
      | Blue -> (r, g, b + n))
    (0, 0, 0) lst'

let power_cubes (lst : (int * color) list list) =
  let summedl = List.map totals lst in
  let mr, mg, mb =
    List.fold_left
      (fun (mr, mg, mb) (r, g, b) -> (max mr r, max mg g, max mb b))
      (0, 0, 0) summedl
  in
  mr * mg * mb

let is_id_valid id (lst : (int * color) list list) =
  let summedl = List.map totals lst in
  if List.exists (fun (rs, gs, bs) -> rs > 12 || gs > 13 || bs > 14) summedl
  then 0
  else id

let ex01 () =
  let parsed =
    Utils.split_lines input
    |> List.map (String.split ~by:": ")
    |> List.map (Fun.flip List.nth 1)
    |> List.map (String.split ~by:"; ")
    |> List.map (List.map (String.split ~by:", "))
    |> List.map
       @@ List.map (List.map (fun s -> Option.get_exn_or "" (read_color s)))
    |> List.scan_left (fun (n, _) l -> (n + 1, l)) (0, [])
  in
  let filtered = List.map (fun (id, l) -> is_id_valid id l) parsed in
  let sum = List.fold_left ( + ) 0 filtered in
  Format.print_int sum

let ex02 () =
  let parsed =
    Utils.split_lines input
    |> List.map (String.split ~by:": ")
    |> List.map (Fun.flip List.nth 1)
    |> List.map (String.split ~by:"; ")
    |> List.map (List.map (String.split ~by:", "))
    |> List.map
       @@ List.map (List.map (fun s -> Option.get_exn_or "" (read_color s)))
  in
  let powers = List.map power_cubes parsed in
  let sum = List.fold_left ( + ) 0 powers in
  Format.print_int sum

let exec () = ex01 (); Format.print_newline (); ex02 ()

let%expect_test "it_works" =
  ex01 ();
  ex02 ();
  [%expect {| 233171585 |}]
