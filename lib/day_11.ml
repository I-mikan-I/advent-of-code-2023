open Containers

let input = Utils.read_day "resources/day11.txt"
let expanded = input |> String.lines |> List.map String.to_list

let to_expand_c =
  let to_fix : int list ref = ref [] in
  for c = 0 to List.length (List.nth expanded 0) - 1 do
    if
      List.for_all
        (fun r -> Char.equal '.' (List.nth (List.nth expanded r) c))
        (List.range 0 (List.length expanded - 1))
    then to_fix := c :: !to_fix
    else ()
  done;
  !to_fix

let to_expand_r =
  List.filter_map
    (fun (i, l) -> if List.for_all (Char.equal '.') l then Some i else None)
    (List.combine (List.range 0 (List.length expanded - 1)) expanded)

let expanded = expanded |> List.map Array.of_list |> Array.of_list
let h = Hashtbl.create 1000

let () =
  Array.iteri
    (fun r l ->
      Array.iteri
        (fun col c ->
          if Char.equal c '#' then Hashtbl.replace h (r, col) true else ())
        l)
    expanded

let get_dist factor () =
  let lst = Hashtbl.keys_list h in
  let lst = List.product Pair.make lst lst in
  let dists =
    List.map
      (fun ((r, c), (r', c')) ->
        let rl, rm, cl, cm = Int.(min r r', max r r', min c c', max c c') in
        let expand_row = List.count (fun r -> r > rl && r < rm) to_expand_r in
        let expand_col = List.count (fun c -> c > cl && c < cm) to_expand_c in
        rm - rl + cm - cl + (expand_row * factor) + (expand_col * factor))
      lst
  in
  List.fold_left ( + ) 0 dists / 2

let ex01 () = Format.printf "%d\n" @@ get_dist 1 ()
let ex02 () = Format.printf "%d\n" @@ get_dist 999999 ()

let exec () =
  ex01 ();
  ex02 ()
