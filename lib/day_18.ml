open Containers

let input = Utils.read_day "resources/day18.txt"
let arr = Array.init 2000 (fun _ -> Array.init 2000 (fun _ -> '.'))

let commands =
  input |> String.lines
  |> List.map (fun s ->
         Scanf.sscanf s "%s@ %d (%s@)" (fun s num s' -> (s, num, s')))

let count directions =
  let rec f directions rightshift acc =
    match directions with
    | ("R", n) :: t -> f t (rightshift + n) (acc + n)
    | ("L", n) :: t -> f t (rightshift - n) acc
    | ("D", n) :: t -> f t rightshift (acc + (n * rightshift))
    | ("U", n) :: t -> f t rightshift (acc - (n * (rightshift - 1)))
    | [] -> acc
    | _ -> assert false
  in
  f directions 1 1

let decoded =
  commands
  |> List.map (fun (_, _, hex) ->
         let hex = Scanf.sscanf hex "#%x" Fun.id in
         let num = hex / 16 in
         let dir =
           match hex mod 16 with
           | 0 -> "R"
           | 1 -> "D"
           | 2 -> "L"
           | 3 -> "U"
           | _ -> assert false
         in
         (dir, num))

let ex01 () =
  let inside = count (commands |> List.map (fun (r, n, _) -> (r, n))) in
  Format.printf "%d\n" inside

let ex02 () =
  let inside = count decoded in
  Format.printf "%d\n" inside

let exec () =
  ex01 ();
  ex02 ()

let%expect_test "it_works" =
  ex01 ();
  ex02 ();
  [%expect {|
    46334
    102000662718092 |}]
