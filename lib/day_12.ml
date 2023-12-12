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

let count_options count_options' (arr, to_place, end_last, idx) =
  match to_place with
  | [] ->
      if
        List.range' idx (Array.length arr)
        |> List.for_all (fun i ->
               let c = Array.get_safe arr i |> Option.get_or ~default:'.' in
               Char.(c = '.' || c = '?'))
      then 1
      else 0
  | k :: t ->
      if
        List.range' end_last idx
        |> List.for_all (fun i ->
               let c = Array.get_safe arr i |> Option.get_or ~default:'#' in
               Char.(c = '.' || c = '?'))
        |> not
      then 0
      else if
        List.range' idx (idx + k)
        |> List.for_all (fun i ->
               let c = Array.get_safe arr i |> Option.get_or ~default:'.' in
               Char.(c = '#' || c = '?'))
      then
        if List.is_empty t then count_options' (arr, [], idx + k, idx + k)
        else
          List.fold_left
            (fun sum idx' -> sum + count_options' (arr, t, idx + k, idx'))
            0
            (List.range' (idx + k + 1 (* sep *)) (Array.length arr))
      else 0

let cache array =
  let cached =
    CCCache.with_cache_rec
      (CCCache.unbounded ~eq:[%eq: int list * int * int] 65536)
      (fun fix (a1, a2, a3) ->
        count_options
          (fun (_, a1, a2, a3) -> fix (a1, a2, a3))
          (array, a1, a2, a3))
  in
  cached

let sum elems =
  List.fold_left
    (fun sum (arr, nums) ->
      let fn = cache arr in
      sum
      + List.fold_left
          (fun sum idx -> sum + fn (nums, 0, idx))
          0
          (List.range' 0 (Array.length arr)))
    0
  @@ elems

let times5 =
  lines
  |> List.map (fun (arr, nums) ->
         ( arr |> Array.to_list |> List.replicate 5 |> List.intersperse [ '?' ]
           |> List.flatten |> Array.of_list,
           List.repeat 5 nums ))

let ex01 () = Format.printf "%d\n" @@ sum lines
let ex02 () = Format.printf "%d\n" @@ sum times5

let exec () =
  ex01 ();
  ex02 ()

let%expect_test "it_works" =
  ex01 ();
  ex02 ();
  [%expect {|
    7350
    200097286528151 |}]
