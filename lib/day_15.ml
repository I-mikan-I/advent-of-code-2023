open Containers

let input = Utils.read_day "resources/day15.txt"

let hash s =
  s |> String.to_seq
  |> Seq.fold_left
       (fun acc c ->
         int_of_char c |> ( + ) acc |> ( * ) 17 |> Fun.flip ( mod ) 256)
       0

let hashes =
  input |> String.split_on_char ',' |> List.map hash |> List.fold_left ( + ) 0

let boxes = Array.init 256 (fun _ -> CCDeque.create ())

let subtract label =
  let h = hash label in
  CCDeque.filter_in_place boxes.(h) (fun (label', _) ->
      not @@ String.equal label label')

let replace label (focal : int) =
  let h = hash label in
  let replaced = ref false in
  boxes.(h) <-
    CCDeque.filter_map
      (fun (label', f) ->
        if String.equal label' label then (
          replaced := true;
          Some (label, focal))
        else Some (label', f))
      boxes.(h);
  if not !replaced then CCDeque.push_back boxes.(h) (label, focal) else ()

let ex01 () = print_endline @@ [%show: int] hashes

let ex02 () =
  let commands = input |> String.split_on_char ',' in
  List.iter
    (fun c ->
      let maybe_assign = Scanf.sscanf_opt c "%s@=%d" (fun s d -> (s, d)) in
      match maybe_assign with
      | Some (lbl, focal) -> replace lbl focal
      | None -> (
          let maybe_subtact = Scanf.sscanf_opt c "%s@-" Fun.id in
          match maybe_subtact with
          | Some lbl -> subtract lbl
          | _ -> assert false))
    commands;
  let boxpowers =
    Array.mapi
      (fun idx dq ->
        (1 + idx)
        * (CCDeque.to_list dq
          |> List.mapi (fun idx (_, focal) -> (idx + 1) * focal)
          |> List.fold_left ( + ) 0))
      boxes
    |> Array.fold_left ( + ) 0
  in
  print_newline ();
  print_int boxpowers

let exec () =
  ex01 ();
  ex02 ()

let%expect_test "it_works" =
  ex01 ();
  ex02 ();
  [%expect {|
    504449

    262044 |}]
