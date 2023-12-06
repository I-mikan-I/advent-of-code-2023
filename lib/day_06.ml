open Containers

let millis = [ 48; 98; 90; 83 ]
let records = [ 390; 1103; 1112; 1360 ]
let millis2 = [ 48989083 ]
let records2 = [ 390110311121360 ]

let winnables millis records =
  List.map2
    (fun i record ->
      let downpress = List.init i Fun.id in
      let results = List.map (fun dp -> (i - dp) * dp) downpress in
      let filtered = List.filter (fun score -> score > record) results in
      List.length filtered)
    millis records

let ex01 () =
  print_endline @@ [%show: int] @@ List.fold_left ( * ) 1
  @@ winnables millis records

let ex02 () =
  print_endline @@ [%show: int] @@ List.fold_left ( * ) 1
  @@ winnables millis2 records2

let exec () =
  ex01 ();
  ex02 ()
