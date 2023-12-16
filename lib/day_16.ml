open Containers

let input = Utils.read_day "resources/day16.txt"
let arr = input |> String.lines |> List.map String.to_array |> Array.of_list

type direction = Left | Right | Down | Up [@@deriving eq, ord, show]

type field = { row : int; col : int; dir : direction }
[@@deriving eq, ord, show]

let beam_step arr (r, c) direction =
  let nr, nc =
    match direction with
    | Left -> (r, c - 1)
    | Right -> (r, c + 1)
    | Down -> (r + 1, c)
    | Up -> (r - 1, c)
  in
  match
    Array.get_safe arr nr |> Option.flat_map (fun r -> Array.get_safe r nc)
  with
  | Some '.' -> [ { row = nr; col = nc; dir = direction } ]
  | Some '/' -> (
      match direction with
      | Up -> [ { row = nr; col = nc; dir = Right } ]
      | Left -> [ { row = nr; col = nc; dir = Down } ]
      | Right -> [ { row = nr; col = nc; dir = Up } ]
      | Down -> [ { row = nr; col = nc; dir = Left } ])
  | Some '\\' -> (
      match direction with
      | Up -> [ { row = nr; col = nc; dir = Left } ]
      | Right -> [ { row = nr; col = nc; dir = Down } ]
      | Left -> [ { row = nr; col = nc; dir = Up } ]
      | Down -> [ { row = nr; col = nc; dir = Right } ])
  | Some '|' -> (
      match direction with
      | Up | Down -> [ { row = nr; col = nc; dir = direction } ]
      | Right | Left ->
          [
            { row = nr; col = nc; dir = Up }; { row = nr; col = nc; dir = Down };
          ])
  | Some '-' -> (
      match direction with
      | Left | Right -> [ { row = nr; col = nc; dir = direction } ]
      | Up | Down ->
          [
            { row = nr; col = nc; dir = Right };
            { row = nr; col = nc; dir = Left };
          ])
  | None -> []
  | _ -> assert false

let rec fix_beam h arr ({ row = startrow; col = startcol; dir = startdir } as r)
    =
  Hashtbl.replace h r ();
  let nextset = beam_step arr (startrow, startcol) startdir in
  let filtered =
    nextset
    |> List.filter (fun { row = r; col = c; _ } ->
           Array.get_safe arr r |> Option.is_some
           && Array.get_safe arr.(r) c |> Option.is_some)
    |> List.filter (fun r -> not @@ Hashtbl.mem h r)
  in
  List.iter (fun r -> fix_beam h arr r) filtered

let ex01 () =
  let h = Hashtbl.create 1000 in
  fix_beam h arr { row = 0; col = -1; dir = Right };
  let h' = Hashtbl.create 1000 in
  Hashtbl.keys_list h
  |> List.iter (fun { row = r; col = c; _ } -> Hashtbl.replace h' (r, c) ());
  let energized = Hashtbl.keys_list h' |> List.count (fun _ -> true) in
  Format.printf "energized: %d\n" energized

let ex02 () =
  let rows = List.range' 0 (Array.length arr) in
  let cols = List.range' 0 (Array.length arr.(0)) in
  let combinationsr =
    List.product Pair.make rows [ (-1, Right); (Array.length arr.(0), Left) ]
  in
  let maxr =
    List.fold_left max 0
      (List.map
         (fun (r, (c, dir)) ->
           let h = Hashtbl.create 1000 in
           fix_beam h arr { row = r; col = c; dir };
           let h' = Hashtbl.create 1000 in
           Hashtbl.keys_list h
           |> List.iter (fun { row = r; col = c; _ } ->
                  Hashtbl.replace h' (r, c) ());
           let energized = Hashtbl.keys_list h' |> List.count (fun _ -> true) in
           energized)
         combinationsr)
  in
  let combinationsl =
    List.product Pair.make cols [ (-1, Down); (Array.length arr, Up) ]
  in
  let maxl =
    List.fold_left max 0
      (List.map
         (fun (c, (r, dir)) ->
           let h = Hashtbl.create 1000 in
           fix_beam h arr { row = r; col = c; dir };
           let h' = Hashtbl.create 1000 in
           Hashtbl.keys_list h
           |> List.iter (fun { row = r; col = c; _ } ->
                  Hashtbl.replace h' (r, c) ());
           let energized = Hashtbl.keys_list h' |> List.count (fun _ -> true) in
           energized)
         combinationsl)
  in
  Format.printf "max: %d\n" (max maxr maxl)

let exec () =
  ex01 ();
  ex02 ()

let%expect_test "it_works" =
  ex01 ();
  ex02 ();
  [%expect {|
    energized: 6362
    max: 6702 |}]
