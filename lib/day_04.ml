open Containers

let input = Utils.split_lines @@ Utils.read_day "resources/day4.txt"

let input2 =
  List.map (String.split_on_char ':') input
  |> List.map (Fun.flip List.nth 1)
  |> List.map String.trim
  |> List.map (fun l ->
         String.split ~by:" | " l
         |> List.map (Str.split (Str.regexp " +"))
         |> List.map (List.map int_of_string))

let winnings =
  List.map
    (fun l ->
      List.count
        (fun num -> List.mem ~eq:Int.equal num (List.nth l 1))
        (List.nth l 0))
    input2

let scores = List.map (fun i -> if i = 0 then 0 else Int.pow 2 (i - 1)) winnings
let ex01 () = print_endline @@ [%show: int] @@ List.fold_left ( + ) 0 scores

let ex02 () =
  let tbl = Hashtbl.create 1000 in
  for i = 1 to List.length winnings do
    Hashtbl.replace tbl i 1
  done;
  let _, enumerated = List.fold_map (fun e n' -> (e + 1, (e, n'))) 1 winnings in
  List.iter
    (fun (e, n) ->
      let mult = Hashtbl.get_or_add tbl ~f:(fun _ -> 1) ~k:e in
      for i = e + 1 to e + n do
        Hashtbl.update tbl ~f:(fun _ v -> Option.map (( + ) mult) v) ~k:i
      done)
    enumerated;
  print_endline @@ [%show: int]
  @@ List.fold_left (fun acc (_, n) -> acc + n) 0
  @@ Hashtbl.to_list tbl

let exec () =
  ex01 ();
  ex02 ()

let%expect_test "it_works" =
  ex01 ();
  ex02 ();
  [%expect {|
    15205
    6189740 |}]
