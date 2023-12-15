open Containers

let input = Utils.read_day "resources/day14.txt"
let arr = input |> String.lines |> List.map String.to_array |> Array.of_list

let move_one m (offset_r, offset_c) =
  let rec get_farthest_dot r c =
    match
      Array.get_safe m r |> Option.flat_map (fun r -> Array.get_safe r c)
    with
    | Some '.' ->
        Some
          (Option.get_or ~default:(r, c)
          @@ get_farthest_dot (r + offset_r) (c + offset_c))
    | _ -> None
  in
  let rec f r c =
    if r >= Array.length m then (None, None)
    else if c >= Array.length m.(0) then f (r + 1) 0
    else if Char.equal m.(r).(c) 'O' then
      let pot_dest = get_farthest_dot (r + offset_r) (c + offset_c) in
      match pot_dest with
      | Some (r', c') -> (Some (r, c), Some (r', c'))
      | None -> f r (c + 1)
    else f r (c + 1)
  in
  let from, dest = f 0 0 in
  match (from, dest) with
  | None, None -> false
  | Some (r, c), Some (r', c') ->
      m.(r').(c') <- 'O';
      m.(r).(c) <- '.';
      true
  | _ -> assert false

let move_one_north m = move_one m (-1, 0)
let move_one_south m = move_one m (1, 0)
let move_one_west m = move_one m (0, -1)
let move_one_east m = move_one m (0, 1)

let move_fix fn m =
  let rec f flag = if not flag then () else f (fn m) in
  f true

let get_weight m =
  Array.fold_left
    (fun (idx, sum) row ->
      let sum' =
        sum
        + idx
          * Array.fold_left
              (fun acc c -> acc + if Char.equal c 'O' then 1 else 0)
              0 row
      in
      (idx - 1, sum'))
    (Array.length m, 0)
    m
  |> snd

let cycle m =
  move_fix move_one_north m;
  move_fix move_one_west m;
  move_fix move_one_south m;
  move_fix move_one_east m

module IntWords :
  CCTrie.WORD with type char_ = int with type t = int CCFQueue.t = struct
  include CCFQueue
  include Int

  type t = int CCFQueue.t
  type char_ = int

  let of_list = CCFQueue.of_list
end

module IntTrie = CCTrie.Make (IntWords)

let find_higher_order_cycle m =
  let copy = m |> Array.map Array.copy in
  (* skip 100 *)
  List.range' 0 100 |> List.iter (fun _ -> cycle copy);
  let queue = CCFQueue.empty in
  let trie = IntTrie.empty in
  let rec f trie fq running_prefix offset =
    cycle copy;
    let weight = get_weight copy in
    let fq' = CCFQueue.snoc fq weight in
    let running_prefix' = CCFQueue.snoc running_prefix weight in
    let prefix_match = IntTrie.longest_prefix running_prefix' trie in
    let trie' = IntTrie.add fq' () trie in
    if CCFQueue.size prefix_match < CCFQueue.size running_prefix' then
      f trie' fq' CCFQueue.empty (CCFQueue.size fq')
    else if CCFQueue.size running_prefix' > 20 then offset
    else f trie' fq' running_prefix' offset
  in
  f trie queue queue 0

let ex01 () =
  let m = Array.map Array.copy arr in
  move_fix move_one_north m;
  let weight = get_weight m in
  Format.printf "Ex01 weight: %d\n" weight

let ex02 () =
  let m = Array.map Array.copy arr in
  let cycle_len = find_higher_order_cycle m in
  let cycle_prefix = 100 in
  let rest = (1000000000 - cycle_prefix) mod cycle_len in
  List.range' 0 (cycle_prefix + rest) |> List.iter (fun _ -> cycle m);
  Format.printf "found cycle len: %d\n" cycle_len;
  Format.printf "total weight: %d\n" (get_weight m)

let exec () =
  ex01 ();
  ex02 ()

let%expect_test "it_works" =
  ex01 ();
  ex02 ()
