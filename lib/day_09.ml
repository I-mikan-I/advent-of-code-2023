open Containers

let input = Utils.read_day "resources/day9.txt"

let sequences =
  input |> String.lines
  |> List.map (String.split_on_char ' ')
  |> List.map (List.map int_of_string)

let next_sequence seq =
  let rec f l r =
    match l with
    | h1 :: h2 :: t -> f (h2 :: t) @@ ((h2 - h1) :: r)
    | [] -> List.rev r
    | [ _ ] -> List.rev r
  in
  f seq []

let get_newval seq =
  let rec tonull last r =
    if List.for_all (( = ) 0) last then last :: r
    else tonull (next_sequence last) @@ (last :: r)
  in
  let nulls = tonull seq [] in
  let rec extrapolate seqs =
    match seqs with
    | last :: next :: r ->
        let next' =
          List.nth next 0
          :: List.init (List.length next) (fun idx ->
                 List.nth next idx + List.nth last idx)
        in
        extrapolate @@ (next' :: r)
    | [ next' ] -> next'
    | _ -> assert false
  in
  let extrapolated =
    match nulls with
    | nulls :: rest -> extrapolate @@ ((0 :: nulls) :: rest)
    | _ -> assert false
  in
  List.get_at_idx_exn (-1) extrapolated

let result = List.fold_left ( + ) 0 (List.map get_newval sequences)
let ex01 () = Format.printf "%a\n" Format.pp_print_int result

let get_newval' seq =
  let rec tonull last r =
    if List.for_all (( = ) 0) last then last :: r
    else tonull (next_sequence last) @@ (last :: r)
  in
  let nulls = tonull seq [] in
  let rec extrapolate seqs =
    match seqs with
    | last :: next :: r ->
        let next = List.rev next in
        let next' =
          List.nth next 0
          :: List.init (List.length next) (fun idx ->
                 List.nth next idx - List.nth last idx)
        in
        extrapolate @@ (next' :: r)
    | [ next' ] -> next'
    | _ -> assert false
  in
  let extrapolated =
    match nulls with
    | nulls :: rest -> extrapolate @@ ((0 :: nulls) :: rest)
    | _ -> assert false
  in
  List.get_at_idx_exn (-1) extrapolated

let result' = List.fold_left ( + ) 0 (List.map get_newval' sequences)
let ex02 () = Format.printf "%a\n" Format.pp_print_int result'

let exec () =
  ex01 ();
  ex02 ()
