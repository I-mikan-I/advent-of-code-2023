open Containers

let input = Utils.read_day "resources/day7.txt"

let cards =
  String.lines input
  |> List.map (fun s -> String.split_on_char ' ' s)
  |> List.map (fun l ->
         (String.to_list @@ List.nth l 0, int_of_string @@ List.nth l 1))

let choices =
  [ '2'; '3'; '4'; '5'; '6'; '7'; '8'; '9'; 'T'; 'J'; 'Q'; 'K'; 'A' ]

let get_rank (hand : char list) =
  let tbl = Hashtbl.create 100 in
  List.iter
    (fun c ->
      let count = Hashtbl.get_or_add tbl ~f:(fun _ -> 0) ~k:c in
      Hashtbl.replace tbl c (count + 1))
    hand;
  let sorted = List.sort (Fun.flip Int.compare) @@ Hashtbl.values_list tbl in
  match sorted with
  | 5 :: _ -> 6
  | 4 :: _ -> 5
  | 3 :: 2 :: _ -> 4
  | 3 :: _ -> 3
  | 2 :: 2 :: _ -> 2
  | 2 :: _ -> 1
  | _ -> 0

let strength c =
  match c with
  | '2' -> 0
  | '3' -> 1
  | '4' -> 2
  | '5' -> 3
  | '6' -> 4
  | '7' -> 5
  | '8' -> 6
  | '9' -> 7
  | 'T' -> 8
  | 'J' -> 9
  | 'Q' -> 10
  | 'K' -> 11
  | 'A' -> 12
  | _ -> assert false

let strength2 c = match c with 'J' -> -1 | _ -> strength c
let prios = List.map (fun (hand, bid) -> (hand, bid, get_rank hand)) cards

let sorted =
  List.sort
    (fun (hand, _, rank) (hand2, _, rank2) ->
      if rank = rank2 then
        List.compare Int.compare (List.map strength hand)
          (List.map strength hand2)
      else Int.compare rank rank2)
    prios

let sum =
  snd
  @@ List.fold_left
       (fun (e, sum) (_, bid, _) -> (e + 1, sum + (bid * e)))
       (1, 0) sorted

let prios2 =
  List.map
    (fun (hand, bid) ->
      let replacements = List.product Pair.make [ hand ] choices in
      let replaced =
        List.map
          (fun (hand, r) ->
            List.map (fun c -> if Char.equal c 'J' then r else c) hand)
          replacements
      in
      let rank =
        List.fold_left (Fun.flip @@ Fun.compose get_rank max) 0 replaced
      in
      (hand, bid, rank))
    cards

let sorted2 =
  List.sort
    (fun (hand, _, rank) (hand2, _, rank2) ->
      if rank = rank2 then
        List.compare Int.compare (List.map strength2 hand)
          (List.map strength2 hand2)
      else Int.compare rank rank2)
    prios2

let sum2 =
  snd
  @@ List.fold_left
       (fun (e, sum) (_, bid, _) -> (e + 1, sum + (bid * e)))
       (1, 0) sorted2

let ex01 () = print_endline @@ [%show: int] sum
let ex02 () = print_endline @@ [%show: int] sum2

let exec () =
  ex01 ();
  ex02 ()

let%expect_test "it_works" =
  ex01 ();
  ex02 ();
  [%expect {|
    250120186
    250665248 |}]
