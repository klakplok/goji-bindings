(* Published under the MIT license.
   Binding (c) 2013 Benjamin Canou
   Library (c) 2008 Dmitry Baranovskiy *)

open Goji

let raphael_package =
  register_package 
    ~doc:"JavaScript Vector Library"
    ~version:"2.1.0-0"
    "raphael"

let raphael_component =
  register_component 
    ~version:"2.1.0"
    ~author:"Dmitry Baranovskiy"
    ~license:License.mit
    ~depends:[ "browser" ]
    ~grabber:Grab.(sequence [
      http_get
	"http://github.com/DmitryBaranovskiy/raphael/raw/master/raphael-min.js"
	"goji_entry.js"
    ])
    ~doc:"JavaScript Vector Library"
    raphael_package "Raphael"
    [ section "Main Types" [
      def_type 
        ~doc:"the type of transformation matices"
        "matrix" (abstract any) ;
      def_type 
        ~doc:"the type of graphical elements"
        "element" (abstract any) ;
      def_type
        ~doc:"the type of animations"
        "animation" (abstract any) ;
      def_type
        ~doc:"the main canvas type"
        "paper" (abstract any) ;
      def_type 
        ~doc:"rectangular boundaries ((left, top), (right, bottom))"
        "boundaries" (public (tuple [ (tuple_fields [ "x", float ;
                                                      "y", float ]) ;
                                      (tuple_fields [ "x2", float ;
                                                      "y2", float ]) ])) ;
    ] ;
    section "Main features" [
      structure "Set"
        ~doc:"Raphael's internal representation of sets"
        [ def_type 
            ~doc:"the type of sets"
            ~tparams:[ "'elt" ] "t" (abstract any) ;
          map_method  ~tparams:[ (param "elt") ]"t" "clear"
            ~doc:"Removes all elements from the set."
            [] void ;
          map_method  ~tparams:[ (param "elt") ]"t" "exclude"
            ~doc:"Removes a given element from the set."
            [ labeled_arg "element"
                ~doc:"element to remove"
                ((param "elt") @@ arg 0) ] 
            bool ;
          map_method  ~tparams:[ (param "elt") ]"t" "forEach" ~rename:"for_each" 
            ~doc:"Executes given function for each element in the set.\n\
                  \n\
                  If function returns [false] it will stop loop running."
            [ labeled_arg "callback"
                ~doc:"function to run"
                ((callback [ curry_arg "elt" ((param "elt") @@ arg 0) ] bool) @@ arg 0) ] void ;
          map_method  ~tparams:[ (param "elt") ]"t" "pop"
            ~doc:"Removes last element and returns it."
            [] 
            (param "elt") ;
          map_method  ~tparams:[ (param "elt") ]"t" "push"
            ~doc:"Adds each argument to the current set."
            [] void ;
          map_method  ~tparams:[ (param "elt") ]"t" "splice"
            ~doc:"Removes given element from the set."
            [ labeled_arg "index"
                ~doc:"position of the deletion"
                (int @@ arg 0) ;
              labeled_arg "count"
                ~doc:"number of element to remove"
                (int @@ arg 1) ] 
            (abbrv ~tparams:[ (param "elt") ] "t") ;
        ] ;
      structure "Matrix"
        ~doc:"Operations on transformation matrices"
        [
          def_type 
            ~doc:"the type of transformation matices"
            "t" (public (abbrv "matrix")) ;
          section "Matrix Management" [
            map_function "make"
              ~doc:"Returns matrix based on given parameters."

              [ labeled_arg "a" (float @@ arg 0) ;
                labeled_arg "b" (float @@ arg 1) ;
                labeled_arg "c" (float @@ arg 2) ;
                labeled_arg "d" (float @@ arg 3) ;
                labeled_arg "e" (float @@ arg 4) ;
                labeled_arg "f" (float @@ arg 5) ]
              "Raphael.matrix" 
              (abbrv "t") ;
            map_function "identity"
              ~doc:"Returns identity matrix."

              []
              "Raphael.matrix" 
              (abbrv "t") ;
            map_method "t" "clone"
              ~doc:"Returns copy of the matrix"
              [] 
              (abbrv "t") ;
            map_method "t" "add" ~rename:"add_components" 
              ~doc:"Adds given values to existing matrix' components."
              [ labeled_arg "a" (float @@ arg 0) ;
                labeled_arg "b" (float @@ arg 1) ;
                labeled_arg "c" (float @@ arg 2) ;
                labeled_arg "d" (float @@ arg 3) ;
                labeled_arg "e" (float @@ arg 4) ;
                labeled_arg "f" (float @@ arg 5) ] void ;
            map_method "t" "add"
              ~doc:"Adds given matrix to existing one."
              [ labeled_arg "matrix" ((abbrv "t") @@ arg 0) ] void ;
          ] ;
          section "Conversions" [
            map_method "t" "toTransformString" ~rename:"to_transform_string" 
              ~doc:"Return transform string that represents given matrix"
              [] 
              string ;
            def_type  "decomposed" (public (record [ row "translation"
                                                       ~doc:"translation"
                                                       (tuple_fields [ "dx", float ;
                                                                       "dy", float ]) ;
                                                     row "scale"
                                                       ~doc:"scale factors"
                                                       (tuple_fields [ "scalex", float ;
                                                                       "scaley", float ]) ;
                                                     row "shear"
                                                       ~doc:"shear"
                                                       (float @@ field root "shear") ;
                                                     row "rotation"
                                                       ~doc:"rotation in deg"
                                                       (float @@ field root "rotate") ;
                                                     row "is_simple"
                                                       ~doc:"could it be represented via simple transformations"
                                                       (bool @@ field root "isSimple") ])) ;
            map_method "t" "split"
              ~doc:"Splits matrix into primitive transformations"
              [] 
              (abbrv "decomposed") ;
          ] ;
          section "Transformations" [
            map_method "t" "invert"
              ~doc:"Returns inverted version of the matrix"
              [] 
              (abbrv "t") ;
            map_method "t" "rotate"
              ~doc:"Rotates the matrix"
              [ curry_arg "a"
                  ~doc:"angle in degrees"
                  (float @@ arg 0) ;
                opt_arg "center"
                  ~doc:"center of the rotation"
                  (tuple [ (float @@ arg 1) ;
                           (float @@ arg 2) ]) ] void ;
            map_method "t" "scale"
              ~doc:"Scales the matrix"
              [ curry_arg "x" (float @@ arg 0) ;
                curry_arg "y" (float @@ arg 1) ;
                opt_arg "center" (tuple [ (float @@ arg 2) ;
                                          (float @@ arg 3) ]) ] void ;
            map_method "t" "translate"
              ~doc:"Translate the matrix"
              [ labeled_arg "x" (float @@ arg 0) ;
                labeled_arg "y" (float @@ arg 1) ] void ;
            map_method "t" "x" ~rename:"get_x" 
              ~doc:"Return x coordinate for given point after transformation \
                    described by the matrix. See also {!get_y}"
              [ labeled_arg "x" (float @@ arg 0) ;
                labeled_arg "y" (float @@ arg 1) ] 
              float ;
            map_method "t" "y" ~rename:"get_y" 
              ~doc:"Return y coordinate for given point after transformation \
                    described by the matrix. See also {!get_x}"
              [ labeled_arg "x" (float @@ arg 0) ;
                labeled_arg "y" (float @@ arg 1) ] 
              float ;
          ] ;
        ] ;
      structure "Element"
        ~doc:"Operations on graphical elements"
        [
          def_type 
            ~doc:"the type of graphical elements"
            "t" (public (abbrv "element")) ;
          def_type 
            ~doc:"Describes both a set and an element, see {!set_as_set} and \
                  {!set_as_element}"
            "set" (abstract any) ;
          inherits ([], "set") ([], "t")
            ~doc:"See an element set as an element"
            "set_as_element" ;
          inherits ([], "set") ([ (abbrv "t") ], "Set.t")
            ~doc:"See an element set as a set of elements"
            "set_as_set" ;
          section "Operations on the element tree" [
            map_attribute "t" "node"
              ~doc:"Gives you a reference to the DOM object, so you can assign \
                    event handlers or just mess around.\n\
                    Note: Don't mess with it."
              ~read_only:true (abbrv "Document.node") ;
            map_attribute "t" "id"
              ~doc:"Unique id of the element. Especially usesful when you want \
                    to listen to events of the element, because all events are \
                    fired in format [<module>.<action>.<id>]. Also useful for \
                    {!Paper.get_by_id} method."
              ~read_only:true int ;
            map_attribute "t" "paper"
              ~doc:"Internal reference to paper where object drawn. Mainly for \
                    use in plugins and element extensions."
              ~read_only:true any ;
            map_method "t" "clone" [] 
              (abbrv "t") ;
            map_attribute "t" "next"
              ~doc:"Reference to the next element in the hierarchy."
              ~read_only:true (option_null (abbrv "t")) ;
            map_attribute "t" "prev"
              ~doc:"Reference to the previous element in the hierarchy."
              ~read_only:true (option_null (abbrv "t")) ;
            map_method "t" "insertAfter" ~rename:"insert_after" 
              ~doc:"Inserts current object after the given one."
              [] void ;
            map_method "t" "insertBefore" ~rename:"insert_before" 
              ~doc:"Inserts current object before the given one."
              [] void ;
            map_method "t" "remove"
              ~doc:"Removes element from the paper."
              [] void ;
            structure "Data"
              ~doc:"Attach data to elements for later retrieval"
              [
                def_type 
                  ~doc:"the type of keys to associate data to"
                  ~tparams:[ "'ty" ] "key" gen_sym ;
                map_method "t" "data" ~rename:"get" 
                  ~doc:"Retrieves value asociated with given key."
                  [ curry_arg "key"
                      ~doc:"key to which data is associated to"
                      ((abbrv ~tparams:[ (param "ty") ] "key") @@ arg 0) ] 
                  (option_null (param "ty")) ;
                map_method "t" "data" ~rename:"set" 
                  ~doc:"Adds or retrieves given value asociated with given key"
                  [ curry_arg "key"
                      ~doc:"key to associate data to"
                      ((abbrv ~tparams:[ (param "ty") ] "key") @@ arg 0) ;
                    curry_arg "value"
                      ~doc:"data to store"
                      ((param "ty") @@ arg 1) ] void ;
                map_method "t" "removeData" ~rename:"remove" 
                  ~doc:"Removes value associated with an element by given key"
                  [ curry_arg "key"
                      ~doc:"key to remove associated data from"
                      ((abbrv ~tparams:[ (param "ty") ] "key") @@ arg 0) ] void ;
                map_method "t" "removeData" ~rename:"remove_all" 
                  ~doc:"Removes all the data of the element."
                  [] void ;
              ] ;
          ] ;
          section "Changing the appearance of objects" [
            structure "Attrs"
              ~doc:"Attribute stores of graphical elements"
              [
                def_type 
                  ~doc:"the type of attribute stores"
                  "t" (abstract any) ;
                map_constructor "t" "make"
                  ~doc:"Builds an empty attribute store"
                  [] "Object" ;
                map_attribute "t" "font-family" ~rename:"font_family" 
                  ~doc:"Font family name"
                  (option_null string) ;
                map_attribute "t" "font-size" ~rename:"font_size" 
                  ~doc:"font size in pixels"
                  (option_null float) ;
                map_attribute "t" "font-weight" ~rename:"font_weight" 
                  ~doc:"Font weight"
                  (option_null string) ;
                map_attribute "t" "y"
                  ~doc:"horizontal coordinate"
                  (option_null float) ;
                map_attribute "t" "x"
                  ~doc:"vertical coordinate"
                  (option_null float) ;
                map_attribute "t" "transform"
                  ~doc:"transform string, see {!Element.transform} and \
                        {!Matrix.to_transform_string}"
                  (option_null string) ;
                map_attribute "t" "fill"
                  ~doc:"Colour (see {!Color}), gradient or image"
                  (option_null string) ;
                map_attribute "t" "stroke"
                  ~doc:"Stroke colour (see {!Color})"
                  (option_null string) ;
                map_attribute "t" "opacity"
                  ~doc:"Opacity (0. - 1.)"
                  (option_null float) ;
                map_attribute "t" "stroke-opacity" ~rename:"stroke_opacity" 
                  ~doc:"Stroke opacity (0. - 1.)"
                  (option_null float) ;
                map_attribute "t" "stroke-width" ~rename:"stroke_width" 
                  ~doc:"Stroke width in pixels, default is 1."
                  (option_null float) ;
              ] ;
            map_method "t" "attr" ~rename:"get_attrs" 
              ~doc:"Gets the attributes of the element."
              [] 
              (abbrv "Attrs.t") ;
            map_method "t" "attr" ~rename:"set_attrs" 
              ~doc:"Sets the attributes of the element."
              [ curry_arg "attrs"
                  ~doc:"the attributes of the element, see {!Attrs}"
                  ((abbrv "Attrs.t") @@ arg 0) ] void ;
            map_method "t" "hide"
              ~doc:"Makes element invisible. See {!Element.show}"
              [] void ;
            map_method "t" "show"
              ~doc:"Makes element visible. See {!Element.hide}"
              [] void ;
            map_method "t" "toBack" ~rename:"to_back" 
              ~doc:"Moves the element so it is the furthest from the viewer's \
                    eyes, behind other elements."
              [] void ;
            map_method "t" "toFront" ~rename:"to_front" 
              ~doc:"Moves the element so it is the closest to the viewer's \
                    eyes, on top of other elements."
              [] void ;
          ] ;
          section "Reacting to events" [
            map_method "t" "click" ~rename:"on_click" 
              ~doc:"Adds event handler for click for the element."
              [ labeled_arg "handler"
                  ~doc:"handler for the event"
                  ((callback [ curry_arg "event" (any @@ arg 0) ] void) @@ arg 0) ] void ;
            map_method "t" "dblclick" ~rename:"on_double_click" 
              ~doc:"Adds event handler for double click for the element."
              [ labeled_arg "handler"
                  ~doc:"handler for the event"
                  ((callback [ curry_arg "event" (any @@ arg 0) ] void) @@ arg 0) ] void ;
            map_method "t" "drag" ~rename:"on_drag" 
              ~doc:"Adds event handlers for drag of the element."
              [ labeled_arg "onmove"
                  ~doc:"handler for moving"
                  ((callback [ labeled_arg "position"
                                 ~doc:"cursor position (x, y)"
                                 (tuple [ (float @@ arg 0) ;
                                          (float @@ arg 1) ]) ;
                               curry_arg "event"
                                 ~doc:"DOM event"
                                 (any @@ arg 2) ] void) @@ arg 0) ;
                labeled_arg "onstart"
                  ~doc:"handler for drag start"
                  ((callback [ labeled_arg "position"
                                 ~doc:"cursor position (x, y)"
                                 (tuple [ (float @@ arg 2) ;
                                          (float @@ arg 3) ]) ;
                               labeled_arg "offset"
                                 ~doc:"offset (dx, dy) from start position"
                                 (tuple [ (float @@ arg 0) ;
                                          (float @@ arg 1) ]) ;
                               curry_arg "event"
                                 ~doc:"DOM event"
                                 (any @@ arg 4) ] void) @@ arg 1) ;
                labeled_arg "onend"
                  ~doc:"handler for drag end"
                  ((callback [ curry_arg "event"
                                 ~doc:"DOM event"
                                 (any @@ arg 0) ] void) @@ arg 2) ] void ;
            map_method "t" "mousedown" ~rename:"on_mouse_down" 
              ~doc:"Adds event handler for mousedown for the element."
              [ labeled_arg "handler"
                  ~doc:"handler for the event"
                  ((callback [ curry_arg "event" (any @@ arg 0) ] void) @@ arg 0) ] void ;
            map_method "t" "mousemove" ~rename:"on_mouse_move" 
              ~doc:"Adds event handler for mousemove for the element."
              [ labeled_arg "handler"
                  ~doc:"handler for the event"
                  ((callback [ curry_arg "event" (any @@ arg 0) ] void) @@ arg 0) ] void ;
            map_method "t" "mouseout" ~rename:"on_mouse_out" 
              ~doc:"Adds event handler for mouseout for the element."
              [ labeled_arg "handler"
                  ~doc:"handler for the event"
                  ((callback [ curry_arg "event" (any @@ arg 0) ] void) @@ arg 0) ] void ;
            map_method "t" "mouseover" ~rename:"on_mouse_over" 
              ~doc:"Adds event handler for mouseover for the element."
              [ labeled_arg "handler"
                  ~doc:"handler for the event"
                  ((callback [ curry_arg "event" (any @@ arg 0) ] void) @@ arg 0) ] void ;
            map_method "t" "mouseup" ~rename:"on_mouse_up" 
              ~doc:"Adds event handler for mouseup for the element."
              [ labeled_arg "handler"
                  ~doc:"handler for the event"
                  ((callback [ curry_arg "event" (any @@ arg 0) ] void) @@ arg 0) ] void ;
            map_method "t" "onDragOver" ~rename:"on_drag_over" 
              ~doc:"Shortcut for assigning event handler for [drag.over.<id>] \
                    event, where id is id of the element (see {!Element.id})."
              [ labeled_arg "f"
                  ~doc:"handler for event, first argument would be the element you \
                        are dragging over"
                  ((callback [ curry_arg "event" ((abbrv "t") @@ arg 0) ] void) @@ arg 0) ] void ;
            map_method "t" "hover" ~rename:"on_hover" 
              ~doc:"Adds event handlers for hover for the element."
              [ labeled_arg "f_in"
                  ~doc:"handler for hover in"
                  ((event [ curry_arg "pos" (tuple_fields [ "x", int ; "y", int ] @@ arg 0) ] void) @@ arg 0) ;
                labeled_arg "f_out"
                  ~doc:"handler for hover out"
                  ((event [ curry_arg "event" (tuple_fields [ "x", int ; "y", int ] @@ arg 0) ] void) @@ arg 1) ]
	      void ;
            map_method "t" "touchcancel" ~rename:"on_touch_cancel" 
              ~doc:"Adds event handler for touchcancel for the element."
              [ labeled_arg "handler"
                  ~doc:"handler for the event"
                  ((callback [ curry_arg "event" (any @@ arg 0) ] void) @@ arg 0) ] void ;
            map_method "t" "touchend" ~rename:"on_touch_end" 
              ~doc:"Adds event handler for touchend for the element."
              [ labeled_arg "handler"
                  ~doc:"handler for the event"
                  ((callback [ curry_arg "event" (any @@ arg 0) ] void) @@ arg 0) ] void ;
            map_method "t" "touchmove" ~rename:"on_touch_move" 
              ~doc:"Adds event handler for touchmove for the element."
              [ labeled_arg "handler"
                  ~doc:"handler for the event"
                  ((callback [ curry_arg "event" (any @@ arg 0) ] void) @@ arg 0) ] void ;
            map_method "t" "touchstart" ~rename:"on_touch_start" 
              ~doc:"Adds event handler for touchstart for the element."
              [ labeled_arg "handler"
                  ~doc:"handler for the event"
                  ((callback [ curry_arg "event" (any @@ arg 0) ] void) @@ arg 0) ] void ;
          ] ;
          section "Not reacting to events anymore" [
            map_method "t" "unclick" ~rename:"un_click" 
              ~doc:"Removes event handler for click for the element."
              [ labeled_arg "handler"
                  ~doc:"handler for the event"
                  ((callback [ curry_arg "event" (any @@ arg 0) ] void) @@ arg 0) ] void ;
            map_method "t" "undblclick" ~rename:"un_dblclick" 
              ~doc:"Removes event handler for double click for the element."
              [ labeled_arg "handler"
                  ~doc:"handler for the event"
                  ((callback [ curry_arg "event" (any @@ arg 0) ] void) @@ arg 0) ] void ;
            map_method "t" "undrag" ~rename:"un_drag" 
              ~doc:"Removes all drag event handlers from given element."
              [] void ;
            map_method "t" "unhover" ~rename:"un_hover" 
              ~doc:"Removes event handlers for hover for the element."
              [ labeled_arg "f_in"
                  ~doc:"handler for hover in"
                  ((callback [ curry_arg "event" (any @@ arg 0) ] void) @@ arg 0) ;
                labeled_arg "f_out"
                  ~doc:"handler for hover out"
                  ((callback [ curry_arg "event" (any @@ arg 0) ] void) @@ arg 1) ] void ;
            map_method "t" "unmousedown" ~rename:"un_mouse_down" 
              ~doc:"Removes event handler for mousedown for the element."
              [ labeled_arg "handler"
                  ~doc:"handler for the event"
                  ((callback [ curry_arg "event" (any @@ arg 0) ] void) @@ arg 0) ] void ;
            map_method "t" "unmousemove" ~rename:"un_mouse_move" 
              ~doc:"Removes event handler for mousemove for the element."
              [ labeled_arg "handler"
                  ~doc:"handler for the event"
                  ((callback [ curry_arg "event" (any @@ arg 0) ] void) @@ arg 0) ] void ;
            map_method "t" "unmouseout" ~rename:"un_mouse_out" 
              ~doc:"Removes event handler for mouseout for the element."
              [ labeled_arg "handler"
                  ~doc:"handler for the event"
                  ((callback [ curry_arg "event" (any @@ arg 0) ] void) @@ arg 0) ] void ;
            map_method "t" "unmouseover" ~rename:"un_mouse_over" 
              ~doc:"Removes event handler for mouseover for the element."
              [ labeled_arg "handler"
                  ~doc:"handler for the event"
                  ((callback [ curry_arg "event" (any @@ arg 0) ] void) @@ arg 0) ] void ;
            map_method "t" "unmouseup" ~rename:"un_mouse_up" 
              ~doc:"Removes event handler for mouseup for the element."
              [ labeled_arg "handler"
                  ~doc:"handler for the event"
                  ((callback [ curry_arg "event" (any @@ arg 0) ] void) @@ arg 0) ] void ;
            map_method "t" "untouchcancel" ~rename:"un_touch_cancel" 
              ~doc:"Removes event handler for touchcancel for the element."
              [ labeled_arg "handler"
                  ~doc:"handler for the event"
                  ((callback [ curry_arg "event" (any @@ arg 0) ] void) @@ arg 0) ] void ;
            map_method "t" "untouchend" ~rename:"un_touch_end" 
              ~doc:"Removes event handler for touchend for the element."
              [ labeled_arg "handler"
                  ~doc:"handler for the event"
                  ((callback [ curry_arg "event" (any @@ arg 0) ] void) @@ arg 0) ] void ;
            map_method "t" "untouchmove" ~rename:"un_touch_move" 
              ~doc:"Removes event handler for touchmove for the element."
              [ labeled_arg "handler"
                  ~doc:"handler for the event"
                  ((callback [ curry_arg "event" (any @@ arg 0) ] void) @@ arg 0) ] void ;
            map_method "t" "untouchstart" ~rename:"un_touch_start" 
              ~doc:"Removes event handler for touchstart for the element."
              [ labeled_arg "handler"
                  ~doc:"handler for the event"
                  ((callback [ curry_arg "event" (any @@ arg 0) ] void) @@ arg 0) ] void ;
          ] ;
          section "Geometry" [
            map_attribute "t" "matrix"
              ~doc:"Keeps {!Matrix.t} object, which represents element \
                    transformation"
              ~read_only:true (abbrv "Matrix.t") ;
            map_method "t" "getBBox" ~rename:"get_boundaries" 
              ~doc:"Computes bounding box for a given element"
              [ opt_arg "is_without_transform"
                  ~doc:"flag, [ true ] if you want to have bounding box before \
                        transformations. Default is [false]."
                  (bool @@ arg 0) ] 
              (abbrv "boundaries") ;
            map_method "t" "getBBox" ~rename:"get_size" 
              ~doc:"Computes size for a given element"
              [ opt_arg "is_without_transform"
                  ~doc:"flag, [ true ] if you want to have size before \
                        transformations. Default is [false]."
                  (bool @@ arg 0) ] 
              (tuple_fields [ "width", float ;
                              "height", float ]) ;
            map_method "t" "getPointAtLength" ~rename:"get_point_at_length" 
              ~doc:"Return coordinates of the point located at the given length \
                    on the given path. Only works for element of path type."
              [ labeled_arg "length" (float @@ arg 0) ] 
              (tuple_fields [ "x", float ;
                              "y", float ;
                              "alpha", float ]) ;
            map_method "t" "getSubpath" ~rename:"get_subpath" 
              ~doc:"Return subpath of a given element from given length to \
                    given length. Only works for element of path type."
              [ labeled_arg "start"
                  ~doc:"position of the start of the segment"
                  (float @@ arg 0) ;
                labeled_arg "stop"
                  ~doc:"position of the end of the segment"
                  (float @@ arg 1) ] 
              string ;
            map_method "t" "getTotalLength" ~rename:"get_total_length" 
              ~doc:"Returns length of the path in pixels. Only works for \
                    element of path type."
              [] 
              float ;
            map_method "t" "glow"
              ~doc:"Return set of elements that create glow-like effect around \
                    given element.See {!Paper.set}\n\
                    \n\
                    Note: Glow is not connected to the element. If you change \
                    element attributes it won't adjust itself."
              [ opt_arg "width"
                  ~doc:"size of the glow, default is 10"
                  (int @@ field (arg 0) "width") ;
                opt_arg "fill"
                  ~doc:"will it be filled, default is [false]"
                  (bool @@ field (arg 0) "fill") ;
                opt_arg "opacity"
                  ~doc:"opacity, default is 0.5"
                  (float @@ field (arg 0) "opacity") ;
                opt_arg "offset_x"
                  ~doc:"horizontal offset, default is 0"
                  (float @@ field (arg 0) "offsetx") ;
                opt_arg "offset_y"
                  ~doc:"vertical offset, default is 0"
                  (float @@ field (arg 0) "offsety") ;
                opt_arg "color"
                  ~doc:"glow colour, default is black "
                  (string @@ field (arg 0) "color") ] 
              (option_null (abbrv "set")) ;
            map_method "t" "isPointInside" ~rename:"is_point_inside" 
              ~doc:"Determine if given point is inside this element's shape"
              [ labeled_arg "x"
                  ~doc:"x coordinate of the point"
                  (float @@ arg 0) ;
                labeled_arg "y"
                  ~doc:"y coordinate of the point"
                  (float @@ arg 1) ] 
              bool ;
            map_method "t" "transform"
              ~doc:"Adds transformation to the element which is separate to \
                    other attributes,\n\
                    i.e. translation doesn't change [x] or [y] of the \
                    rectange. The format\n\
                    of transformation string is similar to the path string \
                    syntax: [\"t100,100r30,100,100s2,2,100,100r45s1.5\"]\n\
                    Each letter is a command. There are \
                    four commands: t is for translate, r is for rotate, s is \
                    for scale and m is for matrix.\n\
                    \n\
                    There are also alternative “absolute” translation, \
                    rotation and scale: [T], [R] and [S].\n\
                    They will not take previous transformation into account.\n\
                    For example, [...T100,0] will always move element 100 px \
                    horisontally, while [...t100,0] could move it vertically if \
                    there is r90 before.\n\
                    Just compare results of [r90t100,0] and [r90T100,0].\n\
                    \n So, the example line above could be read like \
                    “translate by 100, 100; rotate 30° around 100, 100;\n\
                    scale twice around 100, 100; rotate 45° around centre; \
                    scale 1.5 times relative to centre”.\n\
                    As you can see rotate and scale commands have origin \
                    coordinates as optional parameters,\n\
                    the default is the centre point of the element. Matrix \
                    accepts six parameters. \n\
                   "
              [ curry_arg "tstr"
                  ~doc:"transformation string"
                  (string @@ arg 0) ] void ;
            map_method "t" "transform" ~rename:"get_transform" 
              ~doc:"Accesses the current transform string of the element."
              [] 
              string ;
            map_method "t" "translate"
              ~doc:"Deprecated! Use {!Element.transform} instead.\n\
                    Adds translation by given amount to the list of \
                    transformations of the element."
              [ labeled_arg "dx"
                  ~doc:"horisontal shift"
                  (float @@ arg 0) ;
                labeled_arg "dy"
                  ~doc:"vertical shift"
                  (float @@ arg 1) ] void ;
            map_method "t" "rotate"
              ~doc:"Deprecated! Use {!Element.transform} instead.\n\
                    Adds rotation by given angle around given point to the list \
                    of\n\
                    transformations of the element."
              [ labeled_arg "deg"
                  ~doc:"angle in degrees"
                  (float @@ arg 0) ;
                opt_arg "center"
                  ~doc:"centre of rotation"
                  (tuple [ (float @@ arg 1) ;
                           (float @@ arg 2) ]) ] void ;
            map_method "t" "scale"
              ~doc:"Deprecated! Use {!Element.transform} instead.\n\
                    Adds scale by given amount relative to given point to the \
                    list of\n\
                    transformations of the element."
              [ labeled_arg "sx"
                  ~doc:"horisontal scale amount"
                  (float @@ arg 0) ;
                labeled_arg "sy"
                  ~doc:"vertical scale amount"
                  (float @@ arg 1) ;
                opt_arg "center"
                  ~doc:"centre of rotation"
                  (tuple [ (float @@ arg 1) ;
                           (float @@ arg 2) ]) ] void ;
          ] ;
        ] ;
      structure "Animation"
        ~doc:"Operations on animations"
        [
          def_type 
            ~doc:"the type of animations"
            "t" (public (abbrv "animation")) ;
          section "Constructing animations" [
            structure "Easing"
              ~doc:"easing formulas"
              [
                def_type 
                  ~doc:"the abstract type of easing formulas"
                  "t" (abstract any) ;
                map_global "linear"
                  ~doc:"constant speed"
                  ~read_only:true ((abbrv "t") @@ field (field (global "Raphael") "easing_formulas") "linear") ;
                map_global "ease_in"
                  ~doc:"increasing speed"
                  ~read_only:true ((abbrv "t") @@ field (field (global "Raphael") "easing_formulas") "<") ;
                map_global "ease_out"
                  ~doc:"decreasing speed"
                  ~read_only:true ((abbrv "t") @@ field (field (global "Raphael") "easing_formulas") ">") ;
                map_global "ease_in_out"
                  ~doc:"increasing then decreasing speed"
                  ~read_only:true ((abbrv "t") @@ field (field (global "Raphael") "easing_formulas") "<>") ;
                map_global "back_in"
                  ~doc:"spin around the start point and then much as {!ease_in}"
                  ~read_only:true ((abbrv "t") @@ field (field (global "Raphael") "easing_formulas") "backIn") ;
                map_global "back_out"
                  ~doc:"much as {!ease_out} and then spin around the end point"
                  ~read_only:true ((abbrv "t") @@ field (field (global "Raphael") "easing_formulas") "backOut") ;
                map_global "elastic"
                  ~doc:"boing boing"
                  ~read_only:true ((abbrv "t") @@ field (field (global "Raphael") "easing_formulas") "elastic") ;
                map_global "bounce"
                  ~doc:"bong bong bong bong bong"
                  ~read_only:true ((abbrv "t") @@ field (field (global "Raphael") "easing_formulas") "bounce") ;
              ] ;
            map_function "make"
              ~doc:"Creates an animation object that can be passed to the \
                    {!animate} or {!animate_with} methods.\n\
                    See also {!Animation.delay} and {!Animation.repeat} methods."

              [ labeled_arg "params"
                  ~doc:"final attributes for the element, see also {!Element.Attrs}"
                  ((abbrv "Element.Attrs.t") @@ arg 0) ;
                labeled_arg "ms"
                  ~doc:"number of milliseconds for animation to run"
                  (float @@ arg 1) ;
                opt_arg "easing"
                  ~doc:"see {!Easing}"
                  ((abbrv "Easing.t") @@ rest ()) ;
                opt_arg "callback"
                  ~doc:"callback function. Will be called at the end of animation."
                  ((callback [] void) @@ rest ()) ]
              "Raphael.animation" 
              (abbrv "t") ;
            map_method "t" "delay"
              ~doc:"Creates a copy of existing animation object with given \
                    delay."
              [ labeled_arg "delay"
                  ~doc:"number of ms to pass between animation start and actual \
                        animation"
                  (float @@ arg 0) ] 
              (abbrv "t") ;
            map_method "t" "repeat"
              ~doc:"Creates a copy of existing animation object with given \
                    repetition."
              [ labeled_arg "repeat"
                  ~doc:"number iterations of animation. For infinite animation pass \
                        infinity"
                  (float @@ arg 0) ] 
              (abbrv "t") ;
          ] ;
          section "Animating elements" [
            map_method "Element.t" "animate" ~rename:"run" 
              ~doc:"Creates and starts animation for given element."
              [ labeled_arg "animation"
                  ~doc:"animation object, see {!Raphael.animation}"
                  ((abbrv "t") @@ arg 0) ] void ;
            map_method "Element.t" "animate"
              ~doc:"Creates and starts animation for given element."
              [ curry_arg "params"
                  ~doc:"final attributes for the element, see also {!Element.Attrs}"
                  ((abbrv "Element.Attrs.t") @@ arg 0) ;
                curry_arg "ms"
                  ~doc:"number of milliseconds for animation to run"
                  (float @@ arg 1) ;
                opt_arg "easing"
                  ~doc:"see {!Easing}"
                  ((abbrv "Easing.t") @@ rest ()) ;
                opt_arg "callback"
                  ~doc:"callback function. Will be called at the end of animation."
                  ((callback [] void) @@ rest ()) ] void ;
            map_method "Element.t" "animateWith" ~rename:"run_with" 
              ~doc:"Acts similar to {!run}, but ensure that given animation \
                    runs in sync with another given element."
              [ labeled_arg "element"
                  ~doc:"element to sync with"
                  ((abbrv "Element.t") @@ arg 0) ;
                labeled_arg "animation"
                  ~doc:"animation object, see {!Raphael.animation}"
                  ((abbrv "t") @@ arg 1) ] void ;
            map_method "Element.t" "animateWith" ~rename:"animate_with" 
              ~doc:"Acts similar to {!animate}, but ensure that given animation \
                    runs in sync with another given element."
              [ labeled_arg "element"
                  ~doc:"element to sync with"
                  ((abbrv "Element.t") @@ arg 0) ;
                labeled_arg "params"
                  ~doc:"final attributes for the element, see also {!Element.Attrs}"
                  ((abbrv "Element.Attrs.t") @@ arg 1) ;
                labeled_arg "ms"
                  ~doc:"number of milliseconds for animation to run"
                  (float @@ arg 2) ;
                opt_arg "easing"
                  ~doc:"see {!Easing}"
                  ((abbrv "Easing.t") @@ rest ()) ;
                opt_arg "callback"
                  ~doc:"callback function. Will be called at the end of animation."
                  ((callback [] void) @@ rest ()) ] void ;
            map_method "Element.t" "pause"
              ~doc:"Stops animation of the element with ability to resume it \
                    later on."
              [ opt_arg "anim"
                  ~doc:"animation object"
                  ((abbrv "t") @@ rest ()) ] void ;
            map_method "Element.t" "resume"
              ~doc:"Resumes animation if it was paused with {!pause} method."
              [ opt_arg "anim"
                  ~doc:"animation object"
                  ((abbrv "t") @@ rest ()) ] void ;
            map_method "Element.t" "status" ~rename:"get_status" 
              ~doc:"Gets the status of animation of the element."
              [ labeled_arg "anim"
                  ~doc:"animation object"
                  ((abbrv "t") @@ arg 0) ] 
              float ;
            map_method "Element.t" "status" ~rename:"set_status" 
              ~doc:"Sets the status of animation of the element. This will \
                    cause animation to jump to the given position."
              [ labeled_arg "anim"
                  ~doc:"animation object"
                  ((abbrv "t") @@ arg 0) ;
                labeled_arg "value"
                  ~doc:"position between 0 and 1"
                  (float @@ arg 1) ] void ;
            map_method "Element.t" "stop"
              ~doc:"Stops animation of the element."
              [ opt_arg "anim"
                  ~doc:"animation object"
                  ((abbrv "t") @@ arg 0) ] void ;
            map_method "Element.t" "setTime" ~rename:"set_time" 
              ~doc:"Sets the status of animation of the element in \
                    milliseconds. Similar to {!set_status} method."
              [ labeled_arg "anim"
                  ~doc:"animation object"
                  ((abbrv "t") @@ arg 0) ;
                labeled_arg "value"
                  ~doc:"number of milliseconds from the beginning of the animation"
                  (float @@ arg 1) ] void ;
          ] ;
        ] ;
      structure "Paper"
        ~doc:"Main canvas operations"
        [
          def_type 
            ~doc:"the main canvas type"
            "t" (public (abbrv "paper")) ;
          section "Constructors and Destructors" [
            map_function "make_at_node"
              ~doc:"Creates a canvas object on which to draw.\n\
                    You must do this first, as all future calls to drawing \
                    methods from this instance will be bound to this canvas."

              [ labeled_arg "node"
                  ~doc:"the parent DOM node"
                  ((abbrv "Document.node") @@ arg 0) ;
                labeled_arg "width"
                  ~doc:"the width in pixels"
                  (int @@ arg 1) ;
                labeled_arg "height"
                  ~doc:"the height in pixels"
                  (int @@ arg 2) ]
              "Raphael" 
              (abbrv "t") ;
            map_function "make_at_id"
              ~doc:"Creates a canvas object on which to draw.\n\
                    You must do this first, as all future calls to drawing \
                    methods from this instance will be bound to this canvas."

              [ labeled_arg "node"
                  ~doc:"the parent DOM node"
                  (string @@ arg 0) ;
                labeled_arg "width"
                  ~doc:"the width in pixels"
                  (int @@ arg 1) ;
                labeled_arg "height"
                  ~doc:"the height in pixels"
                  (int @@ arg 2) ]
              "Raphael" 
              (abbrv "t") ;
            map_function "make_at_xy"
              ~doc:"Creates a canvas object on which to draw.\n\
                    You must do this first, as all future calls to drawing \
                    methods from this instance will be bound to this canvas."

              [ labeled_arg "position"
                  ~doc:"the parent DOM node"
                  (tuple [ (int @@ arg 0) ;
                           (int @@ arg 1) ]) ;
                labeled_arg "width"
                  ~doc:"the width in pixels"
                  (int @@ arg 2) ;
                labeled_arg "height"
                  ~doc:"the height in pixels"
                  (int @@ arg 3) ]
              "Raphael" 
              (abbrv "t") ;
            map_method "t" "remove"
              ~doc:"Removes the paper from the DOM."
              [] void ;
          ] ;
          section "Element accessors" [
            map_method "t" "clear"
              ~doc:"Clears the paper, i.e. removes all the elements."
              [] void ;
            map_attribute "t" "bottom"
              ~doc:"Points to the bottom element on the paper"
              ~read_only:true (abbrv "Element.t") ;
            map_attribute "t" "top"
              ~doc:"Points to the topmost element on the paper"
              ~read_only:true (abbrv "Element.t") ;
            map_method "t" "forEach" ~rename:"for_each" 
              ~doc:"Executes given function for each element on the paper\n\
                    \n\
                    If callback function returns [false] it will stop loop \
                    running."
              [ labeled_arg "callback"
                  ~doc:"function to run"
                  ((callback [ curry_arg "element" ((abbrv "Element.t") @@ arg 0) ] bool) @@ arg 0) ] void ;
            map_method "t" "getById" ~rename:"get_by_id" 
              ~doc:"Returns you element by its internal ID."
              [ labeled_arg "id"
                  ~doc:"id"
                  (int @@ arg 0) ] 
              (abbrv "Element.t") ;
            map_method "t" "getElementByPoint" ~rename:"get_element_by_point" 
              ~doc:"Returns you topmost element under given point."
              [ labeled_arg "x"
                  ~doc:"x coordinate from the top left corner of the window"
                  (float @@ arg 0) ;
                labeled_arg "y"
                  ~doc:"y coordinate from the top left corner of the window"
                  (float @@ arg 1) ] 
              (abbrv "Element.t") ;
            map_method "t" "getElementsByBBox" ~rename:"get_elements_by_bbox" 
              ~doc:"Returns set of elements that have an intersecting bounding \
                    box"
              [ labeled_arg "bbox"
                  ~doc:"bbox to check with"
                  ((abbrv "boundaries") @@ arg 0) ] 
              (abbrv ~tparams:[ (abbrv "Element.t") ] "Set.t") ;
            map_method "t" "getElementsByPoint" ~rename:"get_elements_by_point" 
              ~doc:"Returns set of elements that have common point inside"
              [ labeled_arg "x"
                  ~doc:"x coordinate of the point"
                  (float @@ arg 0) ;
                labeled_arg "y"
                  ~doc:"y coordinate of the point"
                  (float @@ arg 1) ] 
              (abbrv ~tparams:[ (abbrv "Element.t") ] "Set.t") ;
          ] ;
          section "Font Management" [
            def_type 
              ~doc:"the type of fonts"
              "font" (abstract any) ;
            map_method "t" "getFont" ~rename:"get_font" 
              ~doc:"Finds font object in the registered fonts by given \
                    parameters. You could specify only one word from the font \
                    name, like Myriad for Myriad Pro."
              [ labeled_arg "family"
                  ~doc:"font family name or any word from it"
                  (string @@ arg 0) ;
                opt_arg "weight"
                  ~doc:"font weight"
                  (string @@ arg 1) ;
                opt_arg "style"
                  ~doc:"font style"
                  (string @@ arg 2) ;
                opt_arg "stretch"
                  ~doc:"font stretch"
                  (string @@ arg 3) ] 
              (abbrv "font") ;
          ] ;
          section "Element builders" [
            map_method "t" "add" ~rename:"json" 
              ~doc:"Imports elements in JSON array in format [{type: type, \
                    <attributes>}]"
              [ labeled_arg "json" ((array any) @@ arg 0) ] 
              (abbrv ~tparams:[ (abbrv "Element.t") ] "Set.t") ;
            map_method "t" "circle"
              ~doc:"Draws a circle."
              [ labeled_arg "x"
                  ~doc:"x coordinate of the centre"
                  (float @@ arg 0) ;
                labeled_arg "y"
                  ~doc:"y coordinate of the centre"
                  (float @@ arg 1) ;
                labeled_arg "r"
                  ~doc:"radius"
                  (float @@ arg 2) ] 
              (abbrv "Element.t") ;
            map_method "t" "ellipse"
              ~doc:"Draws an ellipse."
              [ labeled_arg "x"
                  ~doc:"x coordinate of the centre"
                  (float @@ arg 0) ;
                labeled_arg "y"
                  ~doc:"y coordinate of the centre"
                  (float @@ arg 1) ;
                labeled_arg "rx"
                  ~doc:"horizontal radius"
                  (float @@ arg 2) ;
                labeled_arg "ry"
                  ~doc:"vertical radius"
                  (float @@ arg 3) ] 
              (abbrv "Element.t") ;
            map_method "t" "image"
              ~doc:"Embeds an image into the surface."
              [ labeled_arg "src"
                  ~doc:"URI of the source image"
                  (string @@ arg 0) ;
                labeled_arg "x"
                  ~doc:"x coordinate position"
                  (float @@ arg 1) ;
                labeled_arg "y"
                  ~doc:"y coordinate position"
                  (float @@ arg 2) ;
                labeled_arg "width"
                  ~doc:"width of the image"
                  (float @@ arg 3) ;
                labeled_arg "height"
                  ~doc:"height of the image"
                  (float @@ arg 4) ] 
              (abbrv "Element.t") ;
            map_method "t" "path"
              ~doc:"Creates a path element by given path data string."
              [ opt_arg "path_string"
                  ~doc:"path string in SVG format."
                  (string @@ arg 0) ] void ;
            map_method "t" "print"
              ~doc:"Creates path that represent given text written using given \
                    font at given position with given size.\n\
                    Result of the method is path element that contains whole \
                    text as a separate path."
              [ labeled_arg "x"
                  ~doc:"x position of the text"
                  (float @@ arg 0) ;
                labeled_arg "y"
                  ~doc:"y position of the text"
                  (float @@ arg 1) ;
                labeled_arg "string"
                  ~doc:"text to print"
                  (string @@ arg 2) ;
                labeled_arg "font"
                  ~doc:"font object, see {!Paper.get_font}"
                  ((abbrv "font") @@ arg 3) ;
                opt_arg "size"
                  ~doc:"size of the font, default is [16]"
                  (float @@ arg 4) ;
                opt_arg "origin"
                  ~doc:"could be [\"baseline\"] or [\"middle\"], default is \
                        [\"middle\"]"
                  (string @@ arg 5) ;
                opt_arg "letter_spacing"
                  ~doc:"number in range [-1..1], default is [0]"
                  (float @@ arg 6) ] 
              (abbrv "Element.t") ;
            map_method "t" "text"
              ~doc:"Draws a text string. If you need line breaks, put \n in the \
                    string."
              [ labeled_arg "x"
                  ~doc:"x coordinate position"
                  (float @@ arg 0) ;
                labeled_arg "y"
                  ~doc:"y coordinate position"
                  (float @@ arg 1) ;
                labeled_arg "text"
                  ~doc:"The text string to draw"
                  (string @@ arg 2) ] 
              (abbrv "Element.t") ;
            map_method "t" "rect"
              ~doc:"Draws a rectangle."
              [ labeled_arg "x"
                  ~doc:"x coordinate of the top left corner"
                  (float @@ arg 0) ;
                labeled_arg "y"
                  ~doc:"y coordinate of the top left corner"
                  (float @@ arg 1) ;
                labeled_arg "width"
                  ~doc:"width"
                  (float @@ arg 2) ;
                labeled_arg "height"
                  ~doc:"height"
                  (float @@ arg 3) ;
                opt_arg "r"
                  ~doc:"radius for rounded corners, default is 0"
                  (float @@ arg 4) ] 
              (abbrv "Element.t") ;
          ] ;
          section "Grouping" [
            map_method "t" "set"
              ~doc:"Creates an initially empty set to keep and operate several \
                    elements at once.\n\
                    It doesn't create any elements for itself in the page, it \
                    just groups existing elements."
              [] 
              (abbrv "Element.set") ;
            map_method "t" "setFinish" ~rename:"set_finish" 
              ~doc:"See {!Paper.set_start.} This method finishes catching and \
                    returns resulting set."
              [] 
              (abbrv "Element.set") ;
            map_method "t" "setStart" ~rename:"set_start" 
              ~doc:"Creates {!Paper.set.} All elements that will be created \
                    after calling this method and before calling\n\
                    {!Paper.set_finish} will be added to the set."
              [] void ;
          ] ;
          section "Rendering Primitives" [
            map_method "t" "setSize" ~rename:"set_size" 
              ~doc:"If you need to change dimensions of the canvas call this \
                    method"
              [ labeled_arg "width"
                  ~doc:"new width of the canvas"
                  (float @@ arg 0) ;
                labeled_arg "height"
                  ~doc:"new height of the canvas"
                  (float @@ arg 1) ] void ;
            map_method "t" "setViewBox" ~rename:"set_view_box" 
              ~doc:"Sets the view box of the paper. Practically it gives you \
                    ability to zoom and pan whole paper surface by\n\
                    specifying new boundaries."
              [ labeled_arg "x"
                  ~doc:"new x position, default is [0]"
                  (float @@ arg 0) ;
                labeled_arg "y"
                  ~doc:"new y position, default is [0]"
                  (float @@ arg 1) ;
                labeled_arg "w"
                  ~doc:"new width of the canvas"
                  (float @@ arg 2) ;
                labeled_arg "h"
                  ~doc:"new height of the canvas"
                  (float @@ arg 3) ;
                labeled_arg "fit"
                  ~doc:"[true] if you want graphics to fit into new boundary box"
                  (bool @@ arg 4) ] void ;
            map_method "t" "renderfix"
              ~doc:"Fixes the issue of Firefox and IE9 regarding subpixel \
                    rendering. If paper is dependant\n\
                    on other elements after reflow it could shift half pixel \
                    which cause for lines to lost their crispness.\n\
                    This method fixes the issue."
              [] void ;
            map_method "t" "safari"
              ~doc:"There is an inconvenient rendering bug in Safari (WebKit):\n\
                    sometimes the rendering should be forced.\n\
                    This method should help with dealing with this bug."
              [] void ;
          ] ;
        ] ;
      structure "Color"
        ~doc:"Color related operations and conversions"
        [
          section "Spectrum based generation" [
            map_function "get_color"
              ~doc:"On each call returns next colour in the spectrum. To reset \
                    it back to red call {!get_color_reset}"

              [ opt_arg "value"
                  ~doc:"brightness, default is [0.75]"
                  (float @@ arg 0) ]
              "Raphael.getColor" 
              string ;
            map_function "get_color_reset"
              ~doc:"Resets spectrum position for {!get_color} back to red."

              []
              "Raphael.getColor.reset" void ;
          ] ;
          section "Parsing and printing" [
            def_type 
              ~doc:"the result of a parse operation"
              "parse_result" (public (variant [ constr "Error"
                                                  Guard.(field root "error" = int 1)
                                                  ~doc:"unparsable string"
                                                  [] ;
                                                constr "Color"
						  Guard.tt
                                                  ~doc:"parsed RGB color (red, green, blue)"
                                                  [ (float @@ field root "r") ;
                                                    (float @@ field root "g") ;
                                                    (float @@ field root "b") ] ])) ;
            map_function "hsb_to_hex"
              ~doc:"Converts HSB values to hex representation of the colour."

              [ labeled_arg "color"
                  ~doc:"(hue, saturation, value of brightness)"
                  (tuple [ (float @@ arg 0) ;
                           (float @@ arg 1) ;
                           (float @@ arg 2) ]) ]
              "Raphael.hsb" 
              string ;
            map_function "hsl_to_hex"
              ~doc:"Converts HSL values to hex representation of the colour."

              [ labeled_arg "color"
                  ~doc:"(hue, saturation, luminosity)"
                  (tuple [ (float @@ arg 0) ;
                           (float @@ arg 1) ;
                           (float @@ arg 2) ]) ]
              "Raphael.hsl" 
              string ;
            map_function "rgb_to_hex"
              ~doc:"Converts RGB values to hex representation of the colour."

              [ labeled_arg "color"
                  ~doc:"(red, green, blue)"
                  (tuple [ (float @@ arg 0) ;
                           (float @@ arg 1) ;
                           (float @@ arg 2) ]) ]
              "Raphael.rgb" 
              string ;
          ] ;
          section "Conversions between models" [
            map_function "hsb_to_rgb"
              ~doc:"Converts HSB values to RGB object."

              [ labeled_arg "color"
                  ~doc:"(hue, saturation, value of brightness)"
                  (tuple [ (float @@ arg 0) ;
                           (float @@ arg 1) ;
                           (float @@ arg 2) ]) ]
              "Raphael.hsb2rgb" 
              (tuple_fields [ "r", float ;
                              "g", float ;
                              "b", float ]) ;
            map_function "hsl_to_rgb"
              ~doc:"Converts HSL values to RGB object."

              [ labeled_arg "color"
                  ~doc:"(hue, saturation, luminosity)"
                  (tuple [ (float @@ arg 0) ;
                           (float @@ arg 1) ;
                           (float @@ arg 2) ]) ]
              "Raphael.hsl2rgb" 
              (tuple_fields [ "r", float ;
                              "g", float ;
                              "b", float ]) ;
            map_function "rgb_to_hsb"
              ~doc:"Converts RGB values to HSB."

              [ labeled_arg "color"
                  ~doc:"(red, green, blue)"
                  (tuple [ (float @@ arg 0) ;
                           (float @@ arg 1) ;
                           (float @@ arg 2) ]) ]
              "Raphael.rgb2hsb" 
              (tuple_fields [ "h", float ;
                              "s", float ;
                              "b", float ]) ;
            map_function "rgb_to_hsl"
              ~doc:"Converts RGB values to HSL."

              [ labeled_arg "color"
                  ~doc:"(red, green, blue)"
                  (tuple [ (float @@ arg 0) ;
                           (float @@ arg 1) ;
                           (float @@ arg 2) ]) ]
              "Raphael.rgb2hsl" 
              (tuple_fields [ "h", float ;
                              "s", float ;
                              "l", float ]) ;
          ] ;
        ] ;
      structure "Geometry"
        ~doc:"Geometry operations and conversions"
        [
          map_function "angle"
            ~doc:"Returns angle between two or three points"

            [ labeled_arg "p1"
                ~doc:"first point"
                (tuple [ (float @@ arg 0) ;
                         (float @@ arg 1) ]) ;
              labeled_arg "p2"
                ~doc:"seconf point"
                (tuple [ (float @@ arg 2) ;
                         (float @@ arg 3) ]) ;
              labeled_arg "p3"
                ~doc:"third point"
                (tuple [ (float @@ arg 4) ;
                         (float @@ arg 5) ]) ]
            "Raphael.angle" 
            float ;
          map_function "rad_to_deg"
            ~doc:"Transform angle to degrees"

            [ labeled_arg "deg"
                ~doc:"angle in radians"
                (float @@ arg 0) ]
            "Raphael.deg" 
            float ;
          map_function "deg_to_rad"
            ~doc:"Transform angle to radians"

            [ labeled_arg "deg"
                ~doc:"angle in degrees"
                (float @@ arg 0) ]
            "Raphael.rad" 
            float ;
          def_type  "dot_coords" (public (record [ row "point"
                                                     ~doc:"coordinates of the point"
                                                     (tuple_fields [ "x", float ;
                                                                     "y", float ]) ;
                                                   row "alpha"
                                                     ~doc:"angle of the curve derivative at the point "
                                                     (float @@ field root "alpha") ;
                                                   row "left"
                                                     ~doc:"coordinates of the left anchor"
                                                     (tuple [ (float @@ field (field root "m") "x") ;
                                                              (float @@ field (field root "m") "y") ]) ;
                                                   row "right"
                                                     ~doc:"coordinates of the right anchor"
                                                     (tuple [ (float @@ field (field root "n") "x") ;
                                                              (float @@ field (field root "n") "y") ]) ;
                                                   row "start"
                                                     ~doc:"coordinates of the start of the curve"
                                                     (tuple [ (float @@ field (field root "start") "x") ;
                                                              (float @@ field (field root "start") "y") ]) ;
                                                   row "stop"
                                                     ~doc:"coordinates of the end of the curve"
                                                     (tuple [ (float @@ field (field root "end") "x") ;
                                                              (float @@ field (field root "end") "y") ]) ])) ;
          map_function "find_dots_at_segment"
            ~doc:"Utility method\n\
                  Find dot coordinates on the given cubic bezier curve at the \
                  given t."

            [ labeled_arg "p1"
                ~doc:"first point of the curve"
                (tuple [ (float @@ arg 0) ;
                         (float @@ arg 1) ]) ;
              labeled_arg "c1"
                ~doc:"first control point of the curve"
                (tuple [ (float @@ arg 2) ;
                         (float @@ arg 3) ]) ;
              labeled_arg "c2"
                ~doc:"second control point of the curve"
                (tuple [ (float @@ arg 4) ;
                         (float @@ arg 5) ]) ;
              labeled_arg "p2"
                ~doc:"second point of the curve"
                (tuple [ (float @@ arg 6) ;
                         (float @@ arg 7) ]) ;
              labeled_arg "t"
                ~doc:"position on the curve (0..1)"
                (float @@ arg 8) ]
            "Raphael.findDotsAtSegment" 
            (abbrv "dot_coords") ;
          map_function "bezier_bbox"
            ~doc:"Utility method\n\
                  Return bounding box of a given cubic bezier curve"

            [ labeled_arg "p1"
                ~doc:"first point of the curve"
                (tuple [ (float @@ arg 0) ;
                         (float @@ arg 1) ]) ;
              labeled_arg "c1"
                ~doc:"first control point of the curve"
                (tuple [ (float @@ arg 2) ;
                         (float @@ arg 3) ]) ;
              labeled_arg "c2"
                ~doc:"second control point of the curve"
                (tuple [ (float @@ arg 4) ;
                         (float @@ arg 5) ]) ;
              labeled_arg "p2"
                ~doc:"second point of the curve"
                (tuple [ (float @@ arg 6) ;
                         (float @@ arg 7) ]) ]
            "Raphael.bezierBBox" 
            (tuple [ (tuple [ (float @@ field (field root "min") "x") ;
                              (float @@ field (field root "min") "y") ]) ;
                     (tuple [ (float @@ field (field root "max") "x") ;
                              (float @@ field (field root "max") "y") ]) ]) ;
          map_function "bbox_intersect"
            ~doc:"Utility method\n\
                  Returns [true] if two bounding boxes intersect"

            [ labeled_arg "bbox1"
                ~doc:"first bounding box"
                ((abbrv "boundaries") @@ arg 0) ;
              labeled_arg "bbox2"
                ~doc:"second bounding box"
                ((abbrv "boundaries") @@ arg 1) ]
            "Raphael.isBBoxIntersect" 
            bool ;
          map_function "is_point_inside_bbox"
            ~doc:"Utility method\n\
                  Returns [true] if given point is inside bounding boxes."

            [ labeled_arg "bbox"
                ~doc:"bounding box"
                ((abbrv "boundaries") @@ arg 0) ;
              labeled_arg "x"
                ~doc:"x coordinate of the point"
                (string @@ arg 1) ;
              labeled_arg "y"
                ~doc:"y coordinate of the point"
                (string @@ arg 2) ]
            "Raphael.isPointInsideBBox" 
            bool ;
          map_function "snap_to"
            ~doc:"Snaps given value to given grid."

            [ labeled_arg "values"
                ~doc:"given array of values or step of the grid"
                (any @@ arg 0) ;
              labeled_arg "value"
                ~doc:"value to adjust"
                (float @@ arg 1) ;
              opt_arg "tolerance"
                ~doc:"tolerance for snapping. Default is [10]."
                (float @@ arg 2) ]
            "Raphael.snapTo" 
            float ;
        ] ;
      structure "Path"
        ~doc:"Operations on path strings"
        [
          map_function "get_point_at_length"
            ~doc:"Return coordinates of the point located at the given length \
                  on the given path."

            [ labeled_arg "path"
                ~doc:"SVG path string"
                (string @@ arg 0) ;
              labeled_arg "length" (float @@ arg 1) ]
            "Raphael.getPointAtLength" 
            (tuple_fields [ "x", float ;
                            "y", float ;
                            "alpha", float ]) ;
          map_function "get_subpath"
            ~doc:"Return subpath of a given path from given length to given \
                  length."

            [ labeled_arg "path"
                ~doc:"SVG path string"
                (string @@ arg 0) ;
              labeled_arg "from"
                ~doc:"position of the start of the segment"
                (float @@ arg 1) ;
              labeled_arg "_to"
                ~doc:"position of the end of the segment"
                (float @@ arg 2) ]
            "Raphael.getSubpath" 
            string ;
          map_function "get_total_length"
            ~doc:"Returns length of the given path in pixels."

            [ labeled_arg "path"
                ~doc:"SVG path string."
                (string @@ arg 0) ]
            "Raphael.getTotalLength" 
            float ;
          map_function "is_point_inside_path"
            ~doc:"Utility method\n\
                  Returns [true] if given point is inside a given closed path."

            [ labeled_arg "path"
                ~doc:"path string"
                (string @@ arg 0) ;
              labeled_arg "x"
                ~doc:"x of the point"
                (float @@ arg 1) ;
              labeled_arg "y"
                ~doc:"y of the point"
                (float @@ arg 2) ]
            "Raphael.isPointInsidePath" 
            bool ;
          map_function "map_path"
            ~doc:"Transform the path string with given matrix."

            [ labeled_arg "path"
                ~doc:"path string"
                (string @@ arg 0) ;
              labeled_arg "matrix"
                ~doc:"see {!Matrix}"
                (any @@ arg 1) ]
            "Raphael.mapPath" 
            string ;
          map_function "parse_path_string"
            ~doc:"Utility method\n\
                  Parses given path string into an array of arrays of path \
                  segments."

            [ labeled_arg "path_string"
                ~doc:"path string or array of segments (in the last case it will \
                      be returned straight away)"
                (any @@ arg 0) ]
            "Raphael.parsePathString" 
            (array any) ;
          map_function "parse_transform_string"
            ~doc:"Utility method\n\
                  Parses given path string into an array of transformations."

            [ labeled_arg "tstring"
                ~doc:"transform string or array of transformations (in the last \
                      case it will be returned straight away)"
                (any @@ arg 0) ]
            "Raphael.parseTransformString" 
            (array any) ;
          map_function "path2curve"
            ~doc:"Utility method\n\
                  Converts path to a new path where all segments are cubic \
                  bezier curves."

            [ labeled_arg "path_string"
                ~doc:"path string or array of segments"
                (any @@ arg 0) ]
            "Raphael.path2curve" 
            (array any) ;
          map_function "path_bbox"
            ~doc:"Utility method\n\
                  Return bounding box of a given path"

            [ labeled_arg "path"
                ~doc:"path string"
                (string @@ arg 0) ]
            "Raphael.pathBBox" 
            (abbrv "boundaries") ;
          map_function "path_intersection"
            ~doc:"Utility method\n\
                  Finds intersections of two paths"

            [ labeled_arg "path1"
                ~doc:"path string"
                (string @@ arg 0) ;
              labeled_arg "path2"
                ~doc:"path string"
                (string @@ arg 1) ]
            "Raphael.pathIntersection" 
            (array any) ;
          map_function "path_to_relative"
            ~doc:"Utility method\n\
                  Converts path to relative form"

            [ labeled_arg "path_string"
                ~doc:"path string or array of segments"
                (any @@ arg 0) ]
            "Raphael.pathToRelative" 
            (array any) ;
          map_function "to_matrix"
            ~doc:"Utility method\n\
                  Returns matrix of transformations applied to a given path"

            [ labeled_arg "path"
                ~doc:"path string"
                (string @@ arg 0) ;
              labeled_arg "transform"
                ~doc:"transformation string"
                (any @@ arg 1) ]
            "Raphael.toMatrix" 
            (abbrv "Matrix.t") ;
          map_function "transform_path"
            ~doc:"Utility method\n\
                  Returns path transformed by a given transformation"

            [ labeled_arg "path"
                ~doc:"path string"
                (string @@ arg 0) ;
              labeled_arg "transform"
                ~doc:"transformation string"
                (any @@ arg 1) ]
            "Raphael.transformPath" 
            string ;
        ] ;
      map_function "raphael_at_node"
        ~doc:"Creates a canvas object on which to draw.\n\
              You must do this first, as all future calls to drawing \
              methods from this instance will be bound to this canvas."

        [ labeled_arg "node"
            ~doc:"the parent DOM node"
            ((abbrv "Document.node") @@ arg 0) ;
          labeled_arg "width"
            ~doc:"the width in pixels"
            (int @@ arg 1) ;
          labeled_arg "height"
            ~doc:"the height in pixels"
            (int @@ arg 2) ]
        "Raphael" 
        (abbrv "Paper.t") ;
      map_function "raphael_at_id"
        ~doc:"Creates a canvas object on which to draw.\n\
              You must do this first, as all future calls to drawing \
              methods from this instance will be bound to this canvas."

        [ labeled_arg "node"
            ~doc:"the parent DOM node"
            (string @@ arg 0) ;
          labeled_arg "width"
            ~doc:"the width in pixels"
            (int @@ arg 1) ;
          labeled_arg "height"
            ~doc:"the height in pixels"
            (int @@ arg 2) ]
        "Raphael" 
        (abbrv "Paper.t") ;
      map_function "raphael_at_xy"
        ~doc:"Creates a canvas object on which to draw.\n\
              You must do this first, as all future calls to drawing \
              methods from this instance will be bound to this canvas."

        [ labeled_arg "position"
            ~doc:"the parent DOM node"
            (tuple [ (int @@ arg 0) ;
                     (int @@ arg 1) ]) ;
          labeled_arg "width"
            ~doc:"the width in pixels"
            (int @@ arg 2) ;
          labeled_arg "height"
            ~doc:"the height in pixels"
            (int @@ arg 3) ]
        "Raphael" 
        (abbrv "Paper.t") ;
    ] ;
    section "Utilities" [
      map_function "create_uuid"
        ~doc:"Creates a UUID"

        []
        "Raphael.createUUID" 
        float ;
      map_function "set_window"
        ~doc:"Used when you need to draw in an iframe. Switched window to \
              the iframe one."

        [ labeled_arg "newwin"
            ~doc:"new window object"
            (any @@ arg 0) ]
        "Raphael.setWindow" void ;
    ] ;
    section "Capabilities" [
      map_global "supports_svg"
        ~doc:"[true] if browser supports SVG."
        ~read_only:true (bool @@ field (global "Raphael") "svg") ;
      map_global "supports_vml"
        ~doc:"[true] if browser supports VML."
        ~read_only:true (bool @@ field (global "Raphael") "vml") ;
      def_type "backend" ~doc:"The type of supported back-ends."
	(public (string_enum [ "SVG", "SVG" ; "VML", "VML" ; "NONE", "" ])) ;
      map_global "backend"
        ~doc:"Can be SVG, VML or empty, depending on browser support."
        ~read_only:true (abbrv "backend" @@ field (global "Raphael") "type") ;
      map_global "backend_name"
        ~doc:"Can be SVG, VML or empty, depending on browser support."
        ~read_only:true (string @@ field (global "Raphael") "type") ;
    ] ;
  ]
