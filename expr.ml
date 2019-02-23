open Core;;
open Printf

type expr =
    | Val of int
    | Add of expr * expr
    | Sub of expr * expr
    | Mul of expr * expr
    | Div of expr * expr
    ;;

let rec to_sexpr e = match e with
    | Val x -> string_of_int x
    | Add (left, right) ->
        sprintf "(add %s %s)" (to_sexpr left) (to_sexpr right)
    | Sub (left, right) ->
        sprintf "(sub %s %s)" (to_sexpr left) (to_sexpr right)
    | Mul (left, right) ->
        sprintf "(mul %s %s)" (to_sexpr left) (to_sexpr right)
    | Div (left, right) ->
        sprintf "(div %s %s)" (to_sexpr left) (to_sexpr right)
    ;;

let rec eval e = match e with
    | Val x -> Some x
    | Add (left, right) -> binOp (fun l r -> Some (l + r)) left right
    | Sub (left, right) -> binOp (fun l r -> Some (l - r)) left right
    | Mul (left, right) -> binOp (fun l r -> Some (l * r)) left right
    | Div (left, right) -> binOp (fun l r ->
                            if r = 0
                            then None
                            else Some (l / r)) left right
and binOp f left right =
    Option.bind
        (eval left)
        (fun l -> Option.bind (eval right) (fun r -> f l r))
        ;;

let string_of_int_option o = match o with
    | None -> "None"
    | Some x -> sprintf "Some %d" x

(* Divide by 2 *)
let e = Div (Mul (Val 2, Add (Val 3, Val 4)), Val 2);;
print_endline (to_sexpr e);
print_endline (string_of_int_option (eval e));
;;

(* Divide by 0 *)
let e = Div (Mul (Val 2, Add (Val 3, Val 4)), Val 0);;
print_endline (to_sexpr e);
print_endline (string_of_int_option (eval e));
;;
