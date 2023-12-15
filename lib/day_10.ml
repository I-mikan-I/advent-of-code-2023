open Containers

let input = Utils.read_day "resources/day10.txt"
let map = Hashtbl.create 10000

let insert_adjacents r c matrix =
  match
    match matrix.(r).(c) with
    | '|' ->
        Some
          ( (r - 1, c, [| '|'; '7'; 'F'; 'S' |]),
            (r + 1, c, [| '|'; 'L'; 'J'; 'S' |]) )
    | '-' ->
        Some
          ( (r, c - 1, [| '-'; 'L'; 'F'; 'S' |]),
            (r, c + 1, [| '-'; 'J'; '7'; 'S' |]) )
    | 'L' ->
        Some
          ( (r - 1, c, [| '|'; '7'; 'F'; 'S' |]),
            (r, c + 1, [| '-'; 'J'; '7'; 'S' |]) )
    | 'J' ->
        Some
          ( (r - 1, c, [| '|'; '7'; 'F'; 'S' |]),
            (r, c - 1, [| '-'; 'L'; 'F'; 'S' |]) )
    | '7' ->
        Some
          ( (r + 1, c, [| '|'; 'L'; 'J'; 'S' |]),
            (r, c - 1, [| '-'; 'L'; 'F'; 'S' |]) )
    | 'F' ->
        Some
          ( (r + 1, c, [| '|'; 'L'; 'J'; 'S' |]),
            (r, c + 1, [| '-'; 'J'; '7'; 'S' |]) )
    | _ -> None
  with
  | Some ((r', c', check), (r'', c'', check')) ->
      if Array.mem matrix.(r').(c') check then
        Hashtbl.add_list map (r, c) (r', c')
      else ();
      if Array.mem matrix.(r'').(c'') check' then
        Hashtbl.add_list map (r, c) (r'', c'')
      else ()
  | None -> ()

let len = input |> String.lines |> List.get_at_idx_exn 0 |> String.length

let matrix =
  input |> String.lines_seq
  |> Seq.cons (String.of_list (List.init len (fun _ -> '.')))
  |> Fun.flip Seq.append
       (Seq.singleton @@ String.of_list (List.init len (fun _ -> '.')))
  |> Seq.map String.to_seq
  |> Seq.map (Seq.cons '.')
  |> Seq.map (Fun.flip Seq.append (Seq.singleton '.'))
  |> Seq.map Array.of_seq |> Array.of_seq

let () =
  for r = 0 to Array.length matrix - 1 do
    for c = 0 to Array.length matrix.(0) - 1 do
      insert_adjacents r c matrix
    done
  done

type covered = {
  mutable left : int;
  mutable right : int;
  mutable top : int;
  mutable bottom : int;
}
[@@deriving eq, ord, show]

let coveredfields =
  Hashtbl.of_seq
    (Seq.product
       (Seq.init (Array.length matrix) Fun.id)
       (Seq.init (Array.length matrix.(0)) Fun.id)
    |> Seq.map (fun cord ->
           (cord, { left = 0; right = 0; top = 0; bottom = 0 })))

let pipefields = Hashtbl.create 1000

let rec cycle_len acc (rs, cs) (rl, cl) r c =
  if [%eq: int * int] (rs, cs) (r, c) then acc
  else
    let res =
      match Hashtbl.get map (r, c) with
      | Some l -> (
          match
            List.find_opt
              (fun (r', c') -> not @@ [%eq: int * int] (r', c') (rl, cl))
              l
          with
          | Some (r', c') -> cycle_len (acc + 1) (rs, cs) (r, c) r' c'
          | None -> -1)
      | None -> -1
    in
    if not Int.(res = -1) then (
      let _ = Hashtbl.replace pipefields (r, c) true in
      if List.mem matrix.(r).(c) [ 'L'; '-'; 'F' ] then (
        for r' = r - 1 downto 0 do
          let record = Hashtbl.find coveredfields (r', c) in
          record.bottom <- record.bottom + 1
        done;
        for r' = r + 1 to Array.length matrix - 1 do
          let record = Hashtbl.find coveredfields (r', c) in
          record.top <- record.top + 1
        done)
      else ();
      if List.mem matrix.(r).(c) [ 'L'; '|'; 'J' ] then (
        for c' = c - 1 downto 0 do
          let record = Hashtbl.find coveredfields (r, c') in
          record.right <- record.right + 1
        done;
        for c' = c + 1 to Array.length matrix.(0) - 1 do
          let record = Hashtbl.find coveredfields (r, c') in
          record.left <- record.left + 1
        done)
      else ();
      res)
    else res

let is_inside { left; right; top; bottom } =
  left mod 2 = 1 && right mod 2 = 1 && top mod 2 = 1 && bottom mod 2 = 1

let sx, sy =
  let rec search r c =
    if c >= Array.length matrix.(0) then search (r + 1) 0
    else if Char.equal matrix.(r).(c) 'S' then (r, c)
    else search r (c + 1)
  in
  search 0 0

let cycle_len =
  [
    (sx - 1, sy, [ '|'; '7'; 'F' ]);
    (sx + 1, sy, [ '|'; 'L'; 'J' ]);
    (sx, sy + 1, [ '-'; 'J'; '7' ]);
    (sx, sy - 1, [ '-'; 'L'; 'F' ]);
  ]
  |> List.find_map (fun (r, c, valid) ->
         if List.mem matrix.(r).(c) valid then
           match cycle_len 1 (sx, sy) (sx, sy) r c with
           | -1 -> None
           | res -> Some res
         else None)
  |> Option.get_exn_or ""

let inside =
  Hashtbl.fold
    (fun k v acc ->
      acc + if is_inside v && (not @@ Hashtbl.mem pipefields k) then 1 else 0)
    coveredfields 0

let ex01 () = Format.printf "cycle_len: %d\n" (cycle_len / 2)
let ex02 () = Format.printf "inside fields: %d\n" inside

let exec () =
  ex01 ();
  ex02 ()

let%expect_test "it_works" =
  ex01 ();
  ex02 ();
  [%expect {|
    cycle_len: 6897
    inside fields: 367 |}]
