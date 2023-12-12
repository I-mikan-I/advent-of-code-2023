open Containers

let input = Utils.read_day "resources/day12.txt"

let parse s =
  match s with
  | [ springs; nums ] ->
      ( springs |> String.to_array,
        nums |> String.split_on_char ',' |> List.map int_of_string )
  | _ -> assert false

let lines =
  input |> String.lines |> List.map (String.split_on_char ' ') |> List.map parse

let check_array s nums =
  let split =
    String.split_on_char '.' s
    |> List.filter (Fun.compose String.is_empty not)
    |> List.map String.length
  in
  [%eq: int list] split nums
(* let rec match' idx nums =
     match nums with
     | num :: t when not (idx = -1) ->
         let next_idx =
           let sub = List.repeat num [ '#' ] |> String.of_list in
           Str.search_forward
             (Str.regexp (Format.sprintf "[^#]%s[^#]" sub))
             s idx
         in
         match' next_idx t
     | _ -> if idx = -1 then false else true
   in
   match' 0 nums *)

let try_combs array nums =
  let array' = Array.copy array in
  let wildcards = List.count (Char.equal '?') (Array.to_list array) in
  let indices =
    List.filter_map
      (fun (idx, c) -> if Char.equal c '?' then Some idx else None)
      (List.mapi Pair.make (Array.to_list array))
  in
  let combs = Int.pow 2 wildcards in
  let rec recurse comb acc =
    if comb >= combs then acc
    else
      let _ =
        List.fold_left
          (fun last idx ->
            let set, next = (last mod 2, last / 2) in
            if set = 1 then (
              array'.(idx) <- '#';
              next)
            else (
              array'.(idx) <- '.';
              next))
          comb indices
      in
      if check_array (String.of_array array') nums then
        recurse (comb + 1) (acc + 1)
      else recurse (comb + 1) acc
  in
  recurse 0 0

let sum = List.fold_left (fun s t -> s + Fun.uncurry try_combs t) 0 lines

let try_combs2 array nums =
  Format.printf "trying array %s\n" (String.of_array array);
  let seps = Int.pow 2 4 in
  let acc' =
    List.fold_left
      (fun acc (idx, carray) ->
        let carray =
          if not (Int.equal idx 0) then Array.append [| '?' |] carray
          else carray
        in
        let carray =
          if not (Int.equal idx 4) then Array.append carray [| '?' |]
          else carray
        in
        Format.printf "trying subarray %s\n" (String.of_array carray);
        let combs = try_combs carray nums in
        acc * combs)
      1
      (List.combine (List.init 5 Fun.id) (List.init 5 (fun _ -> array)))
  in
  let rec recurse comb acc =
    if comb >= seps then acc
    else
      let _, _, acc' =
        List.fold_left
          (fun (lastset, last, acc) (idx, carray) ->
            let set, next = (last mod 2, last / 2) in
            let carray =
              if not (Int.equal idx 0) then
                Array.append
                  (if lastset mod 2 = 0 then [| '#' |] else [|  |])
                  carray
              else carray
            in
            let carray =
              if not (Int.equal idx 4) then
                Array.append carray
                  (if set mod 2 = 0 then [| '#' |] else [|  |])
              else carray
            in
            Format.printf "removing subarray %s\n" (String.of_array carray);
            let combs = try_combs carray nums in
            (set, next, acc * combs))
          (0, comb, 1)
          (List.combine (List.init 5 Fun.id) (List.init 5 (fun _ -> array)))
      in
      Format.printf "ways to combine: %d\n" acc';
      recurse (comb + 1) (acc + acc')
  in
  let to_remove = recurse 0 0 in
  Format.printf "result: %d, remove: %d\n" acc' to_remove;
  acc' - to_remove

let sum2 = List.fold_left (fun sum e -> sum + Fun.uncurry try_combs2 e) 0 lines

let exec () =
  print_endline @@ [%show: (char array * int list) list] lines;
  print_int sum2
