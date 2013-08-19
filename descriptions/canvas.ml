(* Published under the WTF Public license.
   Binding (c) 2013 Benjamin Canou *)

open Goji

let canvas_package =
  register_package 
    ~doc:"Browser's native 2D raster drawing library"
    ~version:"0.1"
    "canvas"

let canvas_component =
  register_component 
    ~license:Goji_license.wtfpl
    ~doc:"Browser's native 2D raster drawing library"
    canvas_package "Canvas"
    [ def_type 
	~doc:"Represents a canvas DOM node, see {! as_node}"
	"canvas" (abstract any) ;
      def_type 
	~doc:"A drawing context lets you draw on the canvas"
	"context" (abstract any) ;
      def_type 
	~doc:"A drawing context lets you draw on the canvas"
	"gl_context" (abstract any) ;
      section "Canvas Element Management" [
	inherits ([], "canvas") ([], "JavaScript.node") "as_node" ;
	map_attribute "canvas" "width"
          ~doc:"Reflects the height HTML attribute, specifying the width of \
		the coordinate space in CSS pixels."
          int ;
	map_attribute "canvas" "height"
          ~doc:"Reflects the height HTML attribute, specifying the height \
		of the coordinate space in CSS pixels."
          int ;
	def_method "canvas" "get_context" 
          ~doc:"Obtain a 2D context, should work everywhere"
          [] 
	  (abs "_"
	     (set (arg 0) Const.(string "2d"))
	     (call_method "getContext"))
          (abbrv "context") ;
	def_method "canvas" "get_gl_context" 
          ~doc:"Obtain a 3D context, works only on browsers supporting  \
		WebGL"
          []
	  (abs "_"
	     (set (arg 0) Const.(string "webgl"))
	     (call_method "getContext"))
          (abbrv "gl_context") ;
      ] ;
      section "Graphical Operation on 2D Canvas Context" [
      ] ;
    ]
