open Containers

let input = Utils.read_day "resources/day17.txt"

let arr =
  input |> String.lines |> List.map String.to_array
  |> List.map (Array.map (fun c -> int_of_string @@ String.of_char c))
  |> Array.of_list

let weights_fun arr =
  let rec f indices =
    match indices with
    | (r, c) :: t ->
        Format.sprintf "(ite (= x %d00%d) %d\n\t%s)" r c arr.(r).(c) (f t)
    | [] -> "0"
  in
  let indices =
    List.product Pair.make
      (List.range' 0 @@ Array.length arr)
      (List.range' 0 @@ Array.length arr.(0))
  in
  f indices

let distinct arr =
  let indices =
    (888, 888) :: (999, 999)
    :: List.product Pair.make
         (List.range' 0 @@ Array.length arr)
         (List.range' 0 @@ Array.length arr.(0))
  in
  let combinations = List.diagonal indices in
  combinations
  |> List.map (fun ((r, c), (r', c')) ->
         Format.sprintf "(assert (distinct node_%d_%d node_%d_%d))\n" r c r' c')
  |> String.concat ""

let move_fun arr =
  let rec f indices =
    match indices with
    | (direction, (r, c)) :: t ->
        let dest_node =
          match direction with
          | "Left" ->
              if Option.is_some @@ Array.get_safe arr.(r) (c - 1) then
                Format.sprintf "%d00%d" r (c - 1)
              else "(- 1)"
          | "Right" ->
              if Option.is_some @@ Array.get_safe arr.(r) (c + 1) then
                Format.sprintf "%d00%d" r (c + 1)
              else "(- 1)"
          | "Down" ->
              if Option.is_some @@ Array.get_safe arr (r + 1) then
                Format.sprintf "%d00%d" (r + 1) c
              else "(- 1)"
          | "Up" ->
              if Option.is_some @@ Array.get_safe arr (r - 1) then
                Format.sprintf "%d00%d" (r - 1) c
              else "(- 1)"
          | _ -> assert false
        in
        Format.sprintf "(ite (and (= d %s)(= x %d00%d)) %s\n\t%s)" direction r c
          dest_node (f t)
    | [] -> "(- 1)"
  in
  let indices =
    List.product Pair.make
      (List.range' 0 @@ Array.length arr)
      (List.range' 0 @@ Array.length arr.(0))
    |> List.product Pair.make [ "Left"; "Right"; "Down"; "Up" ]
  in
  f indices

let rec sum lst =
  match lst with
  | h :: t -> Format.sprintf "(+ (get_weight position_%d) %s)" h (sum t)
  | [] -> "0"

let exec () =
  let oc = open_out "resources/day17.smt2" |> Format.of_chan in
  Format.fprintf oc "(set-logic ALL)\n(declare-sort N 0)\n";
  Format.fprintf oc
    "(declare-datatype Direction ( (Left) (Right) (Down) (Up) ))\n";
  (* for r = 0 to Array.length arr - 1 do
       for c = 0 to Array.length arr.(r) - 1 do
         Format.fprintf oc "(declare-const node_%d_%d N)\n" r c
       done
     done;
     Format.fprintf oc "(declare-const node_999_999 N)\n";
     (*dest*)
     Format.fprintf oc "(declare-const node_888_888 N)\n";
     unreachable *)
  Format.fprintf oc
    "(define-fun get_weight ((x Real)) Int (ite (= x (- 1)) 9999999 %s))\n"
    (weights_fun arr);
  Format.fprintf oc "(assert (= 0 (get_weight 99900999)))\n";
  Format.fprintf oc
    "(define-fun move ((x Int)(d Direction)) Int (ite (= x 99900999) 99900999 \
     (ite (= x %d00%d) 99900999 %s)))\n"
    (Array.length arr - 1)
    (Array.length arr.(0) - 1)
    (move_fun arr);
  (* Format.fprintf oc "%s\n" (distinct arr); *)
  Format.fprintf oc "(declare-const position_0 Int)\n";
  Format.fprintf oc "(assert (= position_0 0000))\n";
  for m = 1 to 40 do
    Format.fprintf oc "(declare-const move_%d Direction)\n" m;
    Format.fprintf oc "(declare-const position_%d Int)\n" m;
    Format.fprintf oc "(assert (= position_%d (move position_%d move_%d)))\n" m
      (m - 1) m;
    if m >= 4 then
      Format.fprintf oc "(assert (not (= move_%d move_%d move_%d move_%d)))\n" m
        (m - 1) (m - 2) (m - 3)
    else ()
  done;
  Format.fprintf oc "(assert (= position_40 99900999))\n";
  Format.fprintf oc "(assert (<= %s 102))\n" (sum (List.range 0 40));
  Format.fprintf oc "(check-sat)\n"
