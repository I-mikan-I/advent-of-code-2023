open Containers

let millis = [ 48; 98; 90; 83 ]
let records = [ 390; 1103; 1112; 1360 ]
let millis2 = [ 48989083 ]
let records2 = [ 390110311121360 ]

let optimized milli record =
  (* distance traveled = x*2
     x(t - x) - d = 0
     -x^2 + tx -d = 0
     x = -t +- sqrt(t^2 - 4d) / 2
  *)
  let rt =
    int_of_float @@ sqrt (float_of_int @@ (Int.pow milli 2 - (4 * record)))
  in
  let left, right =
    (Int.div ((-1 * milli) - rt) 2, Int.div ((-1 * milli) + rt) 2)
  in
  right - left + 1

let winnables millis records =
  List.map2 (fun i record -> optimized i record) millis records

let ex01 () =
  print_endline @@ [%show: int] @@ List.fold_left ( * ) 1
  @@ winnables millis records

let ex02 () =
  print_endline @@ [%show: int] @@ List.fold_left ( * ) 1
  @@ winnables millis2 records2

let exec () =
  ex01 ();
  ex02 ()

let%expect_test "it_works" =
  ex01 ();
  ex02 ();
  [%expect {|
    4862676
    28973937 |}]
