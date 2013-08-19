(* Published under the WTF Public License.
   (c) 2013 Benjamin Canou *)

(** An example using Goji bindings for Raphael and Howler. *)

open JavaScript
open Raphael
open Howler

let looping_rotation ?(center = 0., 0.) ?(start = 0.) element duration =
  let rec loop deg =
    let matrix = Matrix.identity () in
    Matrix.(translate matrix 250. 250. ;
	    rotate matrix ~center deg ;
	    scale matrix 5. 5.) ;
    let attrs = Element.Attrs.make () in
    Element.Attrs.set_transform attrs (Some (Matrix.to_transform_string matrix)) ;
    Animation.animate
      ~easing:(Animation.Easing.bounce ())
      ~callback:(fun () -> loop (Random.float 360.))
      element attrs duration
  in loop start

(** A major scale of 10 tones. *)
let scale =
  let scale = Array.make 16 0 in
  let j = ref 0 and i = ref 0 in
  while !j < 16 do
    scale.(!j) <- !i + 28 + 1 ;
     i := !i + (if !i mod 12 = 4 || !i mod 12 = 11 then 1 else 2) ;
    incr j
  done ;
  fun i -> scale.(i)

let _ =
  let canvas = Node.create "div" in
  Node.append_child (Node.body ()) canvas ;
  let paper = raphael_at_node canvas 500 500 in
  Paper.set_start paper ;
  for i = 15 downto 0 do
    let color = Element.Data.make_key () in
    let circle = Paper.circle paper 0. 0. (20. +. float (i * 3)) in
    Element.Data.set circle color (Color.rgb_to_hex (float (i * 17), 0., 0.)) ;
    let attrs = Element.Attrs.make () in
    Element.Attrs.(set_fill attrs (Some "white") ;
		   set_stroke attrs (Some (Color.rgb_to_hex (float (i * 17), 0., 0.))) ;
		   set_stroke_width attrs (Some (float (20 - i) /. 5.))) ;
    Element.set_attrs circle attrs ;
    if i <> 0 then (
      let loop_base = Printf.sprintf "sounds/loops/%02d" (i mod 7) in
      let loop = Howler.make ~loop:true [| loop_base ^ ".mp3" ; loop_base ^ ".wav" |] in
      let piano_base = Printf.sprintf "sounds/piano/%03d" (scale (i - 1)) in
      let piano = Howler.make [| piano_base ^ ".mp3" ; piano_base ^ ".wav" |] in
      Element.on_hover circle
	~f_in:(fun _ ->
	  let color = match Element.Data.get circle color with None -> assert false | Some c -> c in
          Howler.play piano ;
	  Element.Attrs.(set_fill attrs (Some color) ;
			 set_stroke_width attrs (Some (float (30 - i) /. 5.))) ;
	  Animation.animate circle attrs 50.)
	~f_out:(fun _ ->
	  Element.Attrs.(set_fill attrs (Some "white") ;
			 set_stroke_width attrs (Some (float (20 - i) /. 5.))) ;
	  Animation.animate circle attrs 500.) ;
      let loop_playing = ref false in
      Element.on_click circle
	(fun _ ->
	  if !loop_playing then (
	    loop_playing := false ;
	    Howler.fade_out loop 0. 100.
	  ) else (
	    loop_playing := true ;
	    Howler.fade_in loop 1. 1000.
	  ))
    )
  done ;
  let text = Paper.text paper 0. 0. (backend ()) in
  let text_attrs = Element.Attrs.make () in
  Element.Attrs.set_font_size text_attrs (Some 16.) ;
  Element.Attrs.set_font_family text_attrs (Some "serif") ;
  Element.set_attrs text text_attrs ;
  let group = Element.set_as_element (Paper.set_finish paper) in
  Element.scale group 3.5 2.5 ;
  let start_matrix = Matrix.identity () in
  Matrix.translate start_matrix 250. 250. ;
  Matrix.rotate start_matrix 45. ;
  let start_attrs = Element.Attrs.make () in
  Element.Attrs.set_transform start_attrs (Some (Matrix.to_transform_string start_matrix)) ;
  let end_matrix = Matrix.identity () in
  Matrix.translate end_matrix 250. 250. ;
  Matrix.rotate end_matrix (-45.) ;
  Matrix.scale end_matrix 5. 5. ;
  let end_attrs = Element.Attrs.make () in
  Element.Attrs.set_transform end_attrs (Some (Matrix.to_transform_string end_matrix)) ;
  Element.set_attrs group start_attrs ;
  Element.on_hover text
    ~f_in:(fun _ -> Animation.pause text)
    ~f_out:(fun _ -> Animation.resume text) ;
  Animation.animate
    ~callback:(fun () -> looping_rotation ~start:(-45.) text 500.)
    group end_attrs 500.
