open Containers

let input =
  List.map String.to_list @@ Utils.split_lines
  @@ Utils.read_day "resources/day3.txt"
  |> List.map (List.cons '.')
  |> List.map (Fun.flip List.append [ '.' ])
  |> (fun l ->
       List.cons (List.init (List.length (List.nth l 0)) (fun _ -> '.')) l)
  |> (fun l -> List.append l [ List.nth l 0 ])
  |> List.map Array.of_list

let arr = Array.of_list input
let is_symbol c = match c with '0' .. '9' | '.' -> false | _ -> true

type rc = { mutable row : int; mutable col : int }

let is_num c = match c with '0' .. '9' -> true | _ -> false

let start_idx arr (r, c) =
  let rc = { row = r; col = c } in
  while is_num arr.(rc.row).(rc.col - 1) do
    rc.col <- rc.col - 1
  done;
  (rc.row, rc.col)

let extract_num arr (r, c) =
  let rec f (r', c') =
    if is_num arr.(r').(c') then arr.(r').(c') :: f (r', c' + 1) else []
  in
  int_of_string (String.of_list @@ f @@ start_idx arr (r, c))

module TupleTable = Hashtbl.Make (struct
  type t = int * int [@@deriving eq]

  let hash = Hash.pair Hash.int Hash.int
end)

let ex01 () =
  let tbl = TupleTable.create 10000 in
  for r = 1 to Array.length arr - 2 do
    for c = 1 to Array.length arr.(0) - 2 do
      if is_symbol arr.(r).(c) then
        List.iter
          (fun (or', oc') ->
            if is_num arr.(r + or').(c + oc') then (
              let start = start_idx arr (r + or', c + oc') in
              let num = extract_num arr (r + or', c + oc') in
              TupleTable.replace tbl start num;
              ())
            else ())
          [
            (-1, -1); (-1, 0); (-1, 1); (0, -1); (0, 1); (1, -1); (1, 0); (1, 1);
          ]
      else ()
    done
  done;
  let vals = List.of_seq @@ TupleTable.to_seq_values tbl in
  print_endline @@ [%show: int] @@ List.fold_left ( + ) 0 vals

let ex02 () =
  let tbl = TupleTable.create 10000 in
  for r = 1 to Array.length arr - 2 do
    for c = 1 to Array.length arr.(0) - 2 do
      if Equal.poly arr.(r).(c) '*' then
        let l =
          List.filter_map
            (fun (or', oc') ->
              if is_num arr.(r + or').(c + oc') then
                Some (start_idx arr (r + or', c + oc'))
              else None)
            [
              (-1, -1);
              (-1, 0);
              (-1, 1);
              (0, -1);
              (0, 1);
              (1, -1);
              (1, 0);
              (1, 1);
            ]
        in
        let uniq = List.uniq ~eq:[%eq: int * int] l in
        if List.length uniq = 2 then
          TupleTable.replace tbl (r, c)
          @@ List.fold_left ( * ) 1
          @@ List.map (extract_num arr) uniq
        else ()
      else ()
    done
  done;
  let vals = List.of_seq @@ TupleTable.to_seq_values tbl in
  print_endline @@ [%show: int] @@ List.fold_left ( + ) 0 vals

let exec () =
  ex01 ();
  ex02 ()

let%expect_test "it_works" =
  ex01 ();
  ex02 ();
  [%expect {|
    532445
    79842967 |}]
