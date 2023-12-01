open Containers

let extractnum str =
  let open Str in
  global_replace (regexp "one") "one1one" str
  |> global_replace (regexp "two") "two2two"
  |> global_replace (regexp "three") "three3three"
  |> global_replace (regexp "four") "four4four"
  |> global_replace (regexp "five") "five5five"
  |> global_replace (regexp "six") "six6six"
  |> global_replace (regexp "seven") "seven7seven"
  |> global_replace (regexp "eight") "eight8eight"
  |> global_replace (regexp "nine") "nine9nine"

let calculate_maxsum lst : int =
  List.map
    (fun l ->
      List.filter
        (Fun.flip List.mem [ '0'; '1'; '2'; '3'; '4'; '5'; '6'; '7'; '8'; '9' ])
        (List.init (String.length l) (String.get l)))
    lst
  |> List.map (fun l -> [ List.nth l 0; List.nth l (List.length l - 1) ])
  |> fun l ->
  List.map (fun l -> String.of_seq (List.to_seq l)) l |> fun l ->
  List.fold_left ( + ) 0 (List.map int_of_string l)

let ex02 () =
  let contents = Utils.read_day "./resources/day1.txt" in
  let result = contents |> Utils.split_lines |> calculate_maxsum in
  Printf.printf "ex01: %d\n" result

let ex01 () =
  let contents = Utils.read_day "./resources/day1.txt" in
  let result =
    List.map extractnum (Utils.split_lines contents) |> calculate_maxsum
  in
  Printf.printf "ex02: %d\n" result

let exec () =
  ex01 ();
  ex02 ()

let%expect_test "it_works" =
  ex01 ();
  ex02 ();
  [%expect {|
    ex02: 54203
    ex01: 54667 |}]
