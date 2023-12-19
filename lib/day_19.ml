open Containers

let input = Utils.read_day "resources/day19.txt"

let rules =
  input |> String.split ~by:"\n\n" |> List.get_at_idx_exn 0 |> String.lines

let parts =
  input |> String.split ~by:"\n\n" |> List.get_at_idx_exn 1 |> String.lines

type sympart = {
  mutable x' : int * int;
  mutable m' : int * int;
  mutable a' : int * int;
  mutable s' : int * int;
}
[@@deriving ord, show, eq]

type part = {
  mutable x : int;
  mutable m : int;
  mutable a : int;
  mutable s : int;
}
[@@deriving ord, show, eq]

type rule = { condition : char * (int -> bool); result : string }
[@@deriving show]

type symrule = { condition' : char * char * int; result' : string }
[@@deriving show]

let parse_cond s =
  let cond = String.get s 0 in
  let num = String.sub s 1 (String.length s - 1) |> int_of_string in
  match cond with
  | '>' -> fun a -> a > num
  | '<' -> fun a -> a < num
  | _ -> assert false

let parse_rule_inner s : rule =
  if not @@ String.contains s ':' then
    { condition = ('x', fun _ -> true); result = s }
  else
    let conds = String.split_on_char ':' s in
    match conds with
    | cond :: result :: t ->
        let varname = String.get cond 0 in
        let cond = String.sub cond 1 (String.length cond - 1) |> parse_cond in
        { condition = (varname, cond); result }
    | _ -> assert false

let parse_cond' s =
  let cond = String.get s 0 in
  let num = String.sub s 1 (String.length s - 1) |> int_of_string in
  (cond, num)

let parse_rule_inner' s : symrule =
  if not @@ String.contains s ':' then
    { condition' = ('x', 'D', -1); result' = s }
  else
    let conds = String.split_on_char ':' s in
    match conds with
    | cond :: result' :: t ->
        let varname = String.get cond 0 in
        let c, n = String.sub cond 1 (String.length cond - 1) |> parse_cond' in
        { condition' = (varname, c, n); result' }
    | _ -> assert false

let h = Hashtbl.create 1000
let sh = Hashtbl.create 1000
let accepted = Hashtbl.create 1000

let parse_rule rule =
  let name, s = Scanf.sscanf rule "%s@{%s@}" (fun name s -> (name, s)) in
  let lst = String.split_on_char ',' s |> List.map parse_rule_inner in
  Hashtbl.replace h name lst

let parse_rule' rule =
  let name, s = Scanf.sscanf rule "%s@{%s@}" (fun name s -> (name, s)) in
  let lst = String.split_on_char ',' s |> List.map parse_rule_inner' in
  Hashtbl.replace sh name lst

let parse_part part =
  let x, m, a, s =
    Scanf.sscanf part "{x=%d,m=%d,a=%d,s=%d}" (fun a a' a'' a''' ->
        (a, a', a'', a'''))
  in
  { x; m; a; s }

let simulate part =
  let (rules : rule list) = Hashtbl.find h "in" in
  let rec f (rule : rule list) =
    match rule with
    | { condition = c; result = r } :: t ->
        let v =
          match c with
          | 'x', f -> part.x
          | 'm', f -> part.m
          | 'a', f -> part.a
          | 's', f -> part.s
          | _ -> assert false
        in
        if (snd c) v then
          match r with
          | "A" -> Hashtbl.replace accepted part ()
          | "R" -> ()
          | s ->
              let rules' = Hashtbl.find h s in
              f rules'
        else f t
    | _ -> assert false
  in
  f rules

let rating part = part.x + part.m + part.s + part.a
let () = List.iter parse_rule rules
let () = List.iter parse_rule' rules
let parts = List.map parse_part parts

let count_accept { x' = xl, xu; m' = ml, mu; a' = al, au; s' = sl, su } =
  let x = max (1 + xu - xl) 0 in
  let m = max (1 + mu - ml) 0 in
  let a = max (1 + au - al) 0 in
  let s = max (1 + su - sl) 0 in
  x * m * a * s

let simulate_sym part =
  let rules = Hashtbl.find sh "in" in
  let rec f part (rule : symrule list) =
    match rule with
    | { condition' = ch, cmp, n; result' = r } :: t -> (
        let (lower, upper), copy =
          match ch with
          | 'x' ->
              ( part.x',
                fun r -> { x' = r; m' = part.m'; a' = part.a'; s' = part.s' } )
          | 'm' ->
              ( part.m',
                fun r -> { x' = part.x'; m' = r; a' = part.a'; s' = part.s' } )
          | 'a' ->
              ( part.a',
                fun r -> { x' = part.x'; m' = part.m'; a' = r; s' = part.s' } )
          | 's' ->
              ( part.s',
                fun r -> { x' = part.x'; m' = part.m'; a' = part.a'; s' = r } )
          | _ -> assert false
        in
        match (cmp, r) with
        | 'D', s -> forward part s
        | '>', s ->
            let taken = copy (max lower (n + 1), upper) in
            let not_taken = copy (lower, min upper n) in
            forward taken s + f not_taken t
        | '<', s ->
            let taken = copy (lower, min upper (n - 1)) in
            let not_taken = copy (max lower n, upper) in
            forward taken s + f not_taken t
        | _ -> assert false)
    | _ -> assert false
  and forward part s =
    String.(
      if s = "R" then 0
      else if s = "A" then count_accept part
      else f part (Hashtbl.find sh s))
  in
  f part rules

let ex01 () =
  List.iter simulate parts;
  let result =
    Hashtbl.keys_list accepted |> List.map rating |> List.fold_left ( + ) 0
  in
  Format.printf "result: %d\n" result

let ex02 () =
  let result =
    simulate_sym
      { x' = (1, 4000); m' = (1, 4000); a' = (1, 4000); s' = (1, 4000) }
  in
  Format.printf "result: %d\n" result

let exec () =
  ex01 ();
  ex02 ()

let%expect_test "it_works" =
  ex01 ();
  ex02 ();
  [%expect {|
    result: 401674
    result: 134906204068564 |}]
