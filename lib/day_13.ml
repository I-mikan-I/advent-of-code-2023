open Containers

let input = Utils.read_day "resources/day13.txt"

let pictures =
  input |> String.split ~by:"\n\n"
  |> List.map (Fun.compose String.lines (List.map String.to_array))
  |> List.map Array.of_list

let find_row m ignored =
  let rec f matched stack r =
    if r >= Array.length m then
      if not @@ List.is_empty matched then
        Some (List.length matched + List.length stack)
      else None
    else
      match stack with
      | h :: t ->
          if [%eq: char array] h m.(r) then f (h :: matched) t (r + 1)
          else if List.length matched = 0 then
            f []
              (m.(r)
              :: List.append matched (List.append (List.rev matched) (h :: t)))
              (r + 1)
          else
            f []
              (List.append matched (List.append (List.rev matched) (h :: t)))
              r
      | [] -> (
          match matched with
          | [] -> f [] [ m.(r) ] (r + 1)
          | _ ->
              if r / 2 = ignored then
                f [] (List.append matched (List.rev matched)) r
              else Some (r / 2))
  in
  f [] [] 0

let find_smudged m =
  let original = find_row m (-1) |> Option.get_or ~default:(-1) in
  let row' =
    Seq.product
      (Seq.init (Array.length m) Fun.id)
      (Seq.init (Array.length m.(0)) Fun.id)
    |> Seq.map (fun (r, c) ->
           let m' = m |> Array.map Array.copy in
           m'.(r).(c) <- (match m.(r).(c) with '.' -> '#' | _ -> '.');
           m')
    |> Seq.map (fun a -> find_row a original)
    |> Seq.find_map (fun o ->
           if not @@ [%eq: int option] o @@ Some original then o else None)
  in
  row'

let ex01 () =
  let rows = List.map (fun a -> find_row a (-1)) pictures in
  let cols =
    List.map (fun a -> find_row a (-1)) (List.map Utils.transpose pictures)
  in
  let rows_total =
    rows |> List.filter_map Fun.id
    |> List.map (Int.mul 100)
    |> List.fold_left ( + ) 0
  in
  let cols_total = cols |> List.filter_map Fun.id |> List.fold_left ( + ) 0 in
  Format.printf "%d\n" (rows_total + cols_total)

let ex02 () =
  let rows = List.map (fun a -> find_smudged a) pictures in
  let cols =
    List.map (fun a -> find_smudged a) (List.map Utils.transpose pictures)
  in
  let rows_total =
    rows |> List.filter_map Fun.id
    |> List.map (Int.mul 100)
    |> List.fold_left ( + ) 0
  in
  let cols_total = cols |> List.filter_map Fun.id |> List.fold_left ( + ) 0 in
  Format.printf "%d\n" (rows_total + cols_total)

let exec () =
  ex01 ();
  ex02 ()

let%expect_test "it_works" =
  ex01 ();
  ex02 ();
  [%expect {|
    32371
    37416 |}]
