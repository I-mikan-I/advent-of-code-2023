open Containers

let input = Utils.read_day "resources/day8.txt"

let instructions =
  input |> String.lines |> Fun.flip List.nth 0 |> String.to_list

let map = input |> String.lines |> List.drop 2
let maptbl = Hashtbl.create 1000

let parse_node line =
  let from, l, r =
    Scanf.sscanf line "%s = (%s@, %s@) " (fun from l r -> (from, l, r))
  in
  Hashtbl.replace maptbl from (l, r)

let () = List.iter parse_node map

let calculate_steps ~f nodes =
  let rec step ~(f : string -> bool) node acc instrs =
    if f node then acc
    else
      match instrs with
      | 'L' :: t ->
          step ~f
            (fst @@ Option.get_exn_or "" (Hashtbl.get maptbl node))
            (acc + 1) t
      | 'R' :: t ->
          step ~f
            (snd @@ Option.get_exn_or "" (Hashtbl.get maptbl node))
            (acc + 1) t
      | [] -> step ~f node acc instructions
      | _ -> assert false
  in
  List.map (fun node -> step ~f node 0 instructions) nodes

let ex01 () =
  match calculate_steps ~f:(fun node -> String.equal node "ZZZ") [ "AAA" ] with
  | result :: [] -> print_endline @@ [%show: int] result
  | _ -> assert false

let ex02 () =
  let begin_nodes =
    Hashtbl.keys_list maptbl
    |> List.filter (fun s -> Char.equal (String.get s 2) 'A')
  in
  let cycles =
    calculate_steps
      ~f:(fun node -> Char.equal (String.get node 2) 'Z')
      begin_nodes
  in
  let result =
    List.fold_left
      (fun last cycle -> last * cycle / Utils.gcd last cycle)
      1 cycles
  in
  print_endline @@ [%show: int] result

let exec () =
  ex01 ();
  ex02 ()

let%expect_test "it_works" =
  ex01 ();
  ex02 ();
  [%expect {|
    13301
    7309459565207 |}]
