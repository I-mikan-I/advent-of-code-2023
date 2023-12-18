let read_day file =
  let ic = open_in file in
  Fun.protect
    ~finally:(fun () -> close_in_noerr ic)
    (fun () -> really_input_string ic (in_channel_length ic))

let split_lines str = String.split_on_char '\n' str

let fix (fn : ('a -> 'b) -> 'a -> 'b) x : 'b =
  let rec f' x' = fn f' x' in
  fn f' x

let rec gcd a b = if b == 0 then a else gcd b @@ (a mod b)

let transpose a =
  let m = ref [||] in
  for c = 0 to Array.length a.(0) - 1 do
    let row = ref [||] in
    for r = 0 to Array.length a - 1 do
      row := Array.append !row [| a.(r).(c) |]
    done;
    m := Array.append !m [| !row |]
  done;
  !m

let xor a b = (a || b) && not (a && b)
