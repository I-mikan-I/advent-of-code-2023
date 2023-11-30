let read_day file = let ic = open_in file in
  Fun.protect ~finally:(fun () -> close_in_noerr ic) (fun () -> really_input_string ic (in_channel_length ic))

let split_lines str = String.split_on_char '\n' str