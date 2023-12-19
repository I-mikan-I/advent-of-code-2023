open Containers

let input = Utils.read_day "resources/day17.txt"

type index = int * int

type node = {
  mutable l : int * int * int;
  mutable r : int * int * int;
  mutable u : int * int * int;
  mutable d : int * int * int;
}
[@@deriving show, eq, ord]

type node2 = {
  mutable l' : int list;
  mutable r' : int list;
  mutable u' : int list;
  mutable d' : int list;
}
[@@deriving show, eq, ord]

let weight =
  input |> String.lines |> List.map String.to_array
  |> List.map (Array.map (fun c -> int_of_string @@ String.of_char c))
  |> Array.of_list

let maxval = 999999

let nodes =
  Array.init (Array.length weight) (fun _ ->
      Array.init
        (Array.length weight.(0))
        (fun _ ->
          {
            l = (maxval, maxval, maxval);
            r = (maxval, maxval, maxval);
            u = (maxval, maxval, maxval);
            d = (maxval, maxval, maxval);
          }))

let nodes' =
  Array.init (Array.length weight) (fun _ ->
      Array.init
        (Array.length weight.(0))
        (fun _ ->
          {
            l' = List.init 10 (fun _ -> maxval);
            r' = List.init 10 (fun _ -> maxval);
            u' = List.init 10 (fun _ -> maxval);
            d' = List.init 10 (fun _ -> maxval);
          }))

let pair3_to_list (a, b, c) = [ a; b; c ]

let relax nodes (r, c) (r', c') =
  let from = nodes.(r).(c) in
  let dest = nodes.(r').(c') in
  let weight = weight.(r').(c') in
  match (r - r', c - c') with
  | -1, 0 ->
      (*down*)
      let d, dd, ddd = dest.d in
      let f, ff, fff = from.d in
      let d' =
        ([ from.r; from.l ] |> List.map pair3_to_list |> List.flatten
       |> List.fold_left min maxval)
        + weight
      in
      let dd' = f + weight in
      let ddd' = ff + weight in
      let updated = (min d d', min dd dd', min ddd ddd') in
      if not @@ [%eq: int * int * int] dest.d updated then (
        dest.d <- updated;
        true)
      else false
  | 1, 0 ->
      (*up*)
      let d, dd, ddd = dest.u in
      let f, ff, fff = from.u in
      let d' =
        ([ from.r; from.l ] |> List.map pair3_to_list |> List.flatten
       |> List.fold_left min maxval)
        + weight
      in
      let dd' = f + weight in
      let ddd' = ff + weight in
      let updated = (min d d', min dd dd', min ddd ddd') in
      if not @@ [%eq: int * int * int] dest.u updated then (
        dest.u <- updated;
        true)
      else false
  | 0, -1 ->
      (*right*)
      let d, dd, ddd = dest.r in
      let f, ff, fff = from.r in
      let d' =
        ([ from.u; from.d ] |> List.map pair3_to_list |> List.flatten
       |> List.fold_left min maxval)
        + weight
      in
      let dd' = f + weight in
      let ddd' = ff + weight in
      let updated = (min d d', min dd dd', min ddd ddd') in
      if not @@ [%eq: int * int * int] dest.r updated then (
        dest.r <- updated;
        true)
      else false
  | 0, 1 ->
      (*left*)
      let d, dd, ddd = dest.l in
      let f, ff, fff = from.l in
      let d' =
        ([ from.u; from.d ] |> List.map pair3_to_list |> List.flatten
       |> List.fold_left min maxval)
        + weight
      in
      let dd' = f + weight in
      let ddd' = ff + weight in
      let updated = (min d d', min dd dd', min ddd ddd') in
      if not @@ [%eq: int * int * int] dest.l updated then (
        dest.l <- updated;
        true)
      else false
  | _ -> assert false

let relax' nodes (r, c) (r', c') =
  let from = nodes.(r).(c) in
  let dest = nodes.(r').(c') in
  let weight = weight.(r').(c') in
  match (r - r', c - c') with
  | -1, 0 ->
      (*down*)
      let fl = dest.d' in
      let dl = from.d' in
      let d' =
        ([ List.drop 3 from.r'; List.drop 3 from.l' ]
        |> List.flatten |> List.fold_left min maxval)
        + weight
      in
      let updated =
        (min d' @@ List.nth fl 0)
        :: List.map2 min
             (List.take 9 dl |> List.map (( + ) weight))
             (List.drop 1 fl)
      in
      if not @@ [%eq: int list] dest.d' updated then (
        dest.d' <- updated;
        true)
      else false
  | 1, 0 ->
      (*up*)
      let fl = dest.u' in
      let dl = from.u' in
      let d' =
        ([ List.drop 3 from.r'; List.drop 3 from.l' ]
        |> List.flatten |> List.fold_left min maxval)
        + weight
      in
      let updated =
        (min d' @@ List.nth fl 0)
        :: List.map2 min
             (List.take 9 dl |> List.map (( + ) weight))
             (List.drop 1 fl)
      in
      if not @@ [%eq: int list] dest.u' updated then (
        dest.u' <- updated;
        true)
      else false
  | 0, -1 ->
      (*right*)
      let fl = dest.r' in
      let dl = from.r' in
      let d' =
        ([ List.drop 3 from.u'; List.drop 3 from.d' ]
        |> List.flatten |> List.fold_left min maxval)
        + weight
      in
      let updated =
        (min d' @@ List.nth fl 0)
        :: List.map2 min
             (List.take 9 dl |> List.map (( + ) weight))
             (List.drop 1 fl)
      in
      if not @@ [%eq: int list] dest.r' updated then (
        dest.r' <- updated;
        true)
      else false
  | 0, 1 ->
      (*left*)
      let fl = dest.l' in
      let dl = from.l' in
      let d' =
        ([ List.drop 3 from.u'; List.drop 3 from.d' ]
        |> List.flatten |> List.fold_left min maxval)
        + weight
      in
      let updated =
        (min d' @@ List.nth fl 0)
        :: List.map2 min
             (List.take 9 dl |> List.map (( + ) weight))
             (List.drop 1 fl)
      in
      if not @@ [%eq: int list] dest.l' updated then (
        dest.l' <- updated;
        true)
      else false
  | _ -> assert false

let relax_all relax nodes =
  let indices =
    List.product Pair.make
      (List.range' 0 @@ Array.length nodes)
      (List.range' 0 @@ Array.length nodes.(0))
  in
  let edges =
    List.product Pair.make indices [ (-1, 0); (1, 0); (0, -1); (0, 1) ]
    |> List.filter_map (fun ((r, c), (r', c')) ->
           let dest = (r + r', c + c') in
           if
             (Option.is_some @@ Array.get_safe nodes (fst dest))
             && (Option.is_some @@ Array.get_safe nodes.(r) (snd dest))
           then Some ((r, c), dest)
           else None)
  in
  List.fold_left
    (fun acc (from, dest) -> relax nodes from dest || acc)
    false edges

let fix relax_all nodes =
  let rec f b = b && relax_all nodes && f b in
  f true

(* let ex01 () =
   nodes.(0).(0) <-
     { l = (0, 0, 0); r = (0, 0, 0); u = (0, 0, 0); d = (0, 0, 0) };
   let _ = relax_all nodes in
   let _ = relax_all nodes in
   let _ = relax_all nodes in
   let _ = fix nodes in
   print_endline @@ [%show: node array array] nodes *)

let ex02 () =
  nodes'.(0).(0) <-
    {
      l' =
        [
          maxval;
          maxval;
          maxval;
          maxval;
          maxval;
          maxval;
          maxval;
          maxval;
          maxval;
          0;
        ];
      r' =
        [
          maxval;
          maxval;
          maxval;
          maxval;
          maxval;
          maxval;
          maxval;
          maxval;
          maxval;
          0;
        ];
      u' =
        [
          maxval;
          maxval;
          maxval;
          maxval;
          maxval;
          maxval;
          maxval;
          maxval;
          maxval;
          0;
        ];
      d' =
        [
          maxval;
          maxval;
          maxval;
          maxval;
          maxval;
          maxval;
          maxval;
          maxval;
          maxval;
          0;
        ];
    };
  let _ = relax_all relax' nodes' in
  let _ = relax_all relax' nodes' in
  let _ = fix (relax_all relax') nodes' in
  print_endline @@ [%show: node2 array array] nodes'

let exec () = ex02 ()
