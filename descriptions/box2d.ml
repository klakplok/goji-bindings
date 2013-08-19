(* Published under the zlib license.
   Binding (c) 2013 Benjamin Canou
   Library (c) 2012 Uli Hecht (for the JavaScript port)*)

open Goji

let box2d_package = register_package 
    ~depends:[ "canvas" ]
    ~doc:"Two dimensional Physics Simulation Engine"
    ~version:"2.1a.3-0"
    "box2d"

let box2d_component = register_component 
    ~doc:"Two dimensional Physics Simulation Engine"
    ~author:"Uli Hecht"
    ~version:"2.1a.3"
    ~license:Goji_license.zlib
    ~grabber:Goji_grab.(sequence [
	http_get "http://box2dweb.googlecode.com/files/Box2dWeb-2.1a.3.zip" "tmp.zip" ;
	unzip "tmp.zip Box2dWeb-2.1.a.3.min.js" ;
	rename "Box2dWeb-2.1.a.3.min.js" "goji_entry.js" ;
	remove "tmp.zip"
      ])
    box2d_package "Box2D" [
    structure "Common"
      ~doc:""
      [
        section "This class controls Box2D global settings" [
          def_type 
            ~doc:"This class controls Box2D global settings"
            "settings" (abstract any) ;
          map_function "settings_b2assert"
            ~doc:"b2Assert is used internally to handle assertions. By \
                  default, calls are commented out to save performance, so \
                  they serve more as documentation than anything else."

            [ curry_arg "a" (bool @@ arg 0) ]
            "Box2D.Common.b2Settings.b2Assert" void ;
          map_function "settings_b2mix_friction"
            ~doc:"Friction mixing law. Feel free to customize this."

            [ curry_arg "friction1" (float @@ arg 0) ;
              curry_arg "friction2" (float @@ arg 1) ]
            "Box2D.Common.b2Settings.b2MixFriction" 
            float ;
          map_function "settings_b2mix_restitution"
            ~doc:"Restitution mixing law. Feel free to customize this."

            [ curry_arg "restitution1" (float @@ arg 0) ;
              curry_arg "restitution2" (float @@ arg 1) ]
            "Box2D.Common.b2Settings.b2MixRestitution" 
            float ;
          map_global "settings_b2_aabb_extension"
            ~doc:"This is used to fatten AABBs in the dynamic tree. This \
                  allows proxies to move by a small amount without triggering \
                  a tree adjustment. This is in meters."
            ~read_only:true (float @@ field (field (field (global "Box2D") "Common") "b2Settings") "b2_aabbExtension") ;
          map_global "settings_b2_aabb_multiplier"
            ~doc:"This is used to fatten AABBs in the dynamic tree. This is \
                  used to predict the future position based on the current \
                  displacement. This is a dimensionless multiplier."
            ~read_only:true (float @@ field (field (field (global "Box2D") "Common") "b2Settings") "b2_aabbMultiplier") ;
          map_global "settings_b2_angular_sleep_tolerance"
            ~doc:"A body cannot sleep if its angular velocity is above this \
                  tolerance."
            ~read_only:true (float @@ field (field (field (global "Box2D") "Common") "b2Settings") "b2_angularSleepTolerance") ;
          map_global "settings_b2_angular_slop"
            ~doc:"A small angle used as a collision and constraint tolerance. \
                  Usually it is chosen to be numerically significant, but \
                  visually insignificant."
            ~read_only:true (float @@ field (field (field (global "Box2D") "Common") "b2Settings") "b2_angularSlop") ;
          map_global "settings_b2_contact_baumgarte"
            ~doc:"This scale factor controls how fast overlap is resolved. \
                  Ideally this would be 1 so that overlap is removed in one \
                  time step. However using values close to 1 often lead to \
                  overshoot."
            ~read_only:true (float @@ field (field (field (global "Box2D") "Common") "b2Settings") "b2_contactBaumgarte") ;
          map_global "settings_b2_linear_sleep_tolerance"
            ~doc:"A body cannot sleep if its linear velocity is above this \
                  tolerance."
            ~read_only:true (float @@ field (field (field (global "Box2D") "Common") "b2Settings") "b2_linearSleepTolerance") ;
          map_global "settings_b2_linear_slop"
            ~doc:"A small length used as a collision and constraint \
                  tolerance. Usually it is chosen to be numerically \
                  significant, but visually insignificant."
            ~read_only:true (float @@ field (field (field (global "Box2D") "Common") "b2Settings") "b2_linearSlop") ;
          map_global "settings_b2_max_angular_correction"
            ~doc:"The maximum angular position correction used when solving \
                  constraints. This helps to prevent overshoot."
            ~read_only:true (float @@ field (field (field (global "Box2D") "Common") "b2Settings") "b2_maxAngularCorrection") ;
          map_global "settings_b2_max_linear_correction"
            ~doc:"The maximum linear position correction used when solving \
                  constraints. This helps to prevent overshoot."
            ~read_only:true (float @@ field (field (field (global "Box2D") "Common") "b2Settings") "b2_maxLinearCorrection") ;
          map_global "settings_b2_max_manifold_points"
            ~doc:"Number of manifold points in a b2Manifold. This should \
                  NEVER change."
            ~read_only:true (int @@ field (field (field (global "Box2D") "Common") "b2Settings") "b2_maxManifoldPoints") ;
          map_global "settings_b2_max_rotation"
            ~doc:"The maximum angular velocity of a body. This limit is very \
                  large and is used to prevent numerical problems. You \
                  shouldn't need to adjust this."
            ~read_only:true (float @@ field (field (field (global "Box2D") "Common") "b2Settings") "b2_maxRotation") ;
          map_global "settings_b2_max_rotation_squared" ~read_only:true (float @@ field (field (field (global "Box2D") "Common") "b2Settings") "b2_maxRotationSquared") ;
          map_global "settings_b2_max_toicontacts_per_island"
            ~doc:"Maximum number of contacts to be handled to solve a TOI \
                  island."
            ~read_only:true (int @@ field (field (field (global "Box2D") "Common") "b2Settings") "b2_maxTOIContactsPerIsland") ;
          map_global "settings_b2_max_toijoints_per_island"
            ~doc:"Maximum number of joints to be handled to solve a TOI \
                  island."
            ~read_only:true (int @@ field (field (field (global "Box2D") "Common") "b2Settings") "b2_maxTOIJointsPerIsland") ;
          map_global "settings_b2_max_translation"
            ~doc:"The maximum linear velocity of a body. This limit is very \
                  large and is used to prevent numerical problems. You \
                  shouldn't need to adjust this."
            ~read_only:true (float @@ field (field (field (global "Box2D") "Common") "b2Settings") "b2_maxTranslation") ;
          map_global "settings_b2_max_translation_squared" ~read_only:true (float @@ field (field (field (global "Box2D") "Common") "b2Settings") "b2_maxTranslationSquared") ;
          map_global "settings_b2_pi" ~read_only:true (float @@ field (field (field (global "Box2D") "Common") "b2Settings") "b2_pi") ;
          map_global "settings_b2_polygon_radius"
            ~doc:"The radius of the polygon/edge shape skin. This should not \
                  be modified. Making this smaller means polygons will have \
                  and insufficient for continuous collision. Making it larger \
                  may create artifacts for vertex collision."
            ~read_only:true (float @@ field (field (field (global "Box2D") "Common") "b2Settings") "b2_polygonRadius") ;
          map_global "settings_b2_time_to_sleep"
            ~doc:"The time that a body must be still before it will go to \
                  sleep."
            ~read_only:true (float @@ field (field (field (global "Box2D") "Common") "b2Settings") "b2_timeToSleep") ;
          map_global "settings_b2_toi_slop"
            ~doc:"Continuous collision detection (CCD) works with core, \
                  shrunken shapes. This is the amount by which shapes are \
                  automatically shrunk to work with CCD. This must be larger \
                  than b2_linearSlop."
            ~read_only:true (float @@ field (field (field (global "Box2D") "Common") "b2Settings") "b2_toiSlop") ;
          map_global "settings_b2_velocity_threshold"
            ~doc:"A velocity threshold for elastic collisions. Any collision \
                  with a relative linear velocity below this threshold will \
                  be treated as inelastic."
            ~read_only:true (float @@ field (field (field (global "Box2D") "Common") "b2Settings") "b2_velocityThreshold") ;
          map_global "settings_ushrt_max" ~read_only:true (int @@ field (field (field (global "Box2D") "Common") "b2Settings") "USHRT_MAX") ;
          map_global "settings_version"
            ~doc:"The current version of Box2D"
            ~read_only:true (string @@ field (field (field (global "Box2D") "Common") "b2Settings") "VERSION") ;
        ] ;
        section "Color for debug drawing." [
          def_type 
            ~doc:"Color for debug drawing."
            "color" (abstract any) ;
          map_method "color" "Set" ~rename:"color_set"  [ curry_arg "rr" (float @@ arg 0) ;
                                                          curry_arg "gg" (float @@ arg 1) ;
                                                          curry_arg "bb" (float @@ arg 2) ] void ;
          structure "Math"
            ~doc:""
            [
              section "Types" [
                def_type 
                  ~doc:"A 2D column vector."
                  "vec2" (abstract any) ;
                def_type 
                  ~doc:"A 2D column vector with 3 elements."
                  "vec3" (abstract any) ;
                def_type 
                  ~doc:"A 2-by-2 matrix."
                  "mat22" (abstract any) ;
              ] ;
              section "A 2D column vector." [
                map_attribute "vec2" "x" ~rename:"vec2_x"  float ;
                map_attribute "vec2" "y" ~rename:"vec2_y"  float ;
                map_method "vec2" "Abs" ~rename:"vec2_abs"  [] void ;
                map_method "vec2" "Add" ~rename:"vec2_add"  [ curry_arg "v" ((abbrv "vec2") @@ arg 0) ] void ;
                map_method "vec2" "Copy" ~rename:"vec2_copy"  [] 
                  (abbrv "vec2") ;
                map_method "vec2" "CrossFV" ~rename:"vec2_cross_fv"  [ curry_arg "s" (float @@ arg 0) ] void ;
                map_method "vec2" "CrossVF" ~rename:"vec2_cross_vf"  [ curry_arg "s" (float @@ arg 0) ] void ;
                map_method "vec2" "GetNegative" ~rename:"vec2_get_negative"  [] 
                  (abbrv "vec2") ;
                map_method "vec2" "IsValid" ~rename:"vec2_is_valid"  [] 
                  bool ;
                map_method "vec2" "Length" ~rename:"vec2_length"  [] 
                  float ;
                map_method "vec2" "LengthSquared" ~rename:"vec2_length_squared"  [] 
                  float ;
                map_function "vec2_make"
                  [ curry_arg "x_" (float @@ arg 0) ;
                    curry_arg "y_" (float @@ arg 1) ]
                  "Box2D.Common.Math.b2Vec2.Make" 
                  (abbrv "vec2") ;
                map_method "vec2" "MaxV" ~rename:"vec2_max_v"  [ curry_arg "b" ((abbrv "vec2") @@ arg 0) ] void ;
                map_method "vec2" "MinV" ~rename:"vec2_min_v"  [ curry_arg "b" ((abbrv "vec2") @@ arg 0) ] void ;
                map_method "vec2" "MulM" ~rename:"vec2_mul_m"  [ curry_arg "a" ((abbrv "mat22") @@ arg 0) ] void ;
                map_method "vec2" "Multiply" ~rename:"vec2_multiply"  [ curry_arg "a" (float @@ arg 0) ] void ;
                map_method "vec2" "MulTM" ~rename:"vec2_mul_tm"  [ curry_arg "a" ((abbrv "mat22") @@ arg 0) ] void ;
                map_method "vec2" "NegativeSelf" ~rename:"vec2_negative_self"  [] void ;
                map_method "vec2" "Normalize" ~rename:"vec2_normalize"  [] 
                  float ;
                map_method "vec2" "Set" ~rename:"vec2_set"  [ curry_arg "x_" (float @@ arg 0) ;
                                                              curry_arg "y_" (float @@ arg 1) ] void ;
                map_method "vec2" "SetV" ~rename:"vec2_set_v"  [ curry_arg "v" ((abbrv "vec2") @@ arg 0) ] void ;
                map_method "vec2" "SetZero" ~rename:"vec2_set_zero"  [] void ;
                map_method "vec2" "Subtract" ~rename:"vec2_subtract"  [ curry_arg "v" ((abbrv "vec2") @@ arg 0) ] void ;
              ] ;
              section "A 2D column vector with 3 elements." [
                map_attribute "vec3" "x" ~rename:"vec3_x"  float ;
                map_attribute "vec3" "y" ~rename:"vec3_y"  float ;
                map_attribute "vec3" "z" ~rename:"vec3_z"  float ;
                map_method "vec3" "Add" ~rename:"vec3_add"  [ curry_arg "v" ((abbrv "vec3") @@ arg 0) ] void ;
                map_method "vec3" "Copy" ~rename:"vec3_copy"  [] 
                  (abbrv "vec3") ;
                map_method "vec3" "GetNegative" ~rename:"vec3_get_negative" 
                  ~doc:"Negate this vector"
                  [] 
                  (abbrv "vec3") ;
                map_method "vec3" "Multiply" ~rename:"vec3_multiply"  [ curry_arg "a" (float @@ arg 0) ] void ;
                map_method "vec3" "NegativeSelf" ~rename:"vec3_negative_self"  [] void ;
                map_method "vec3" "Set" ~rename:"vec3_set" 
                  ~doc:"Set this vector to some specified coordinates."
                  [ curry_arg "x" (float @@ arg 0) ;
                    curry_arg "y" (float @@ arg 1) ;
                    curry_arg "z" (float @@ arg 2) ] void ;
                map_method "vec3" "SetV" ~rename:"vec3_set_v"  [ curry_arg "v" ((abbrv "vec3") @@ arg 0) ] void ;
                map_method "vec3" "SetZero" ~rename:"vec3_set_zero" 
                  ~doc:"Sets this vector to all zeros"
                  [] void ;
                map_method "vec3" "Subtract" ~rename:"vec3_subtract"  [ curry_arg "v" ((abbrv "vec3") @@ arg 0) ] void ;
              ] ;
              section "A 2-by-2 matrix." [
                map_attribute "mat22" "col1" ~rename:"mat22_col1"  (abbrv "vec2") ;
                map_attribute "mat22" "col2" ~rename:"mat22_col2"  (abbrv "vec2") ;
                map_method "mat22" "Abs" ~rename:"mat22_abs"  [] void ;
                map_method "mat22" "AddM" ~rename:"mat22_add_m"  [ curry_arg "m" ((abbrv "mat22") @@ arg 0) ] void ;
                map_method "mat22" "Copy" ~rename:"mat22_copy"  [] 
                  (abbrv "mat22") ;
                map_function "mat22_from_angle"
                  [ curry_arg "angle" (float @@ arg 0) ]
                  "Box2D.Common.Math.b2Mat22.FromAngle" 
                  (abbrv "mat22") ;
                map_function "mat22_from_vv"
                  [ curry_arg "c1" ((abbrv "vec2") @@ arg 0) ;
                    curry_arg "c2" ((abbrv "vec2") @@ arg 1) ]
                  "Box2D.Common.Math.b2Mat22.FromVV" 
                  (abbrv "mat22") ;
                map_method "mat22" "GetAngle" ~rename:"mat22_get_angle"  [] 
                  float ;
                map_method "mat22" "GetInverse" ~rename:"mat22_get_inverse" 
                  ~doc:"Compute the inverse of this matrix, such that inv(A) A = \
                        identity."
                  [ curry_arg "out" ((abbrv "mat22") @@ arg 0) ] 
                  (abbrv "mat22") ;
                map_method "mat22" "Set" ~rename:"mat22_set"  [ curry_arg "angle" (float @@ arg 0) ] void ;
                map_method "mat22" "SetIdentity" ~rename:"mat22_set_identity"  [] void ;
                map_method "mat22" "SetM" ~rename:"mat22_set_m"  [ curry_arg "m" ((abbrv "mat22") @@ arg 0) ] void ;
                map_method "mat22" "SetVV" ~rename:"mat22_set_vv"  [ curry_arg "c1" ((abbrv "vec2") @@ arg 0) ;
                                                                     curry_arg "c2" ((abbrv "vec2") @@ arg 1) ] void ;
                map_method "mat22" "SetZero" ~rename:"mat22_set_zero"  [] void ;
                map_method "mat22" "Solve" ~rename:"mat22_solve"  [ curry_arg "out" ((abbrv "vec2") @@ arg 0) ;
                                                                    curry_arg "b_x" (float @@ arg 1) ;
                                                                    curry_arg "b_y" (float @@ arg 2) ] 
                  (abbrv "vec2") ;
              ] ;
              section "A 3-by-3 matrix." [
                def_type 
                  ~doc:"A 3-by-3 matrix."
                  "mat33" (abstract any) ;
                map_attribute "mat33" "col1" ~rename:"mat33_col1"  (abbrv "vec3") ;
                map_attribute "mat33" "col2" ~rename:"mat33_col2"  (abbrv "vec3") ;
                map_attribute "mat33" "col3" ~rename:"mat33_col3"  (abbrv "vec3") ;
                map_method "mat33" "AddM" ~rename:"mat33_add_m"  [ curry_arg "m" ((abbrv "mat33") @@ arg 0) ] void ;
                map_method "mat33" "Copy" ~rename:"mat33_copy"  [] 
                  (abbrv "mat33") ;
                map_method "mat33" "SetIdentity" ~rename:"mat33_set_identity"  [] void ;
                map_method "mat33" "SetM" ~rename:"mat33_set_m"  [ curry_arg "m" ((abbrv "mat33") @@ arg 0) ] void ;
                map_method "mat33" "SetVVV" ~rename:"mat33_set_vvv"  [ curry_arg "c1" ((abbrv "vec3") @@ arg 0) ;
                                                                       curry_arg "c2" ((abbrv "vec3") @@ arg 1) ;
                                                                       curry_arg "c3" ((abbrv "vec3") @@ arg 2) ] void ;
                map_method "mat33" "SetZero" ~rename:"mat33_set_zero"  [] void ;
                map_method "mat33" "Solve22" ~rename:"mat33_solve22"  [ curry_arg "out" ((abbrv "vec2") @@ arg 0) ;
                                                                        curry_arg "b_x" (float @@ arg 1) ;
                                                                        curry_arg "b_y" (float @@ arg 2) ] 
                  (abbrv "vec2") ;
                map_method "mat33" "Solve33" ~rename:"mat33_solve33"  [ curry_arg "out" ((abbrv "vec3") @@ arg 0) ;
                                                                        curry_arg "b_x" (float @@ arg 1) ;
                                                                        curry_arg "b_y" (float @@ arg 2) ;
                                                                        curry_arg "b_z" (float @@ arg 3) ] 
                  (abbrv "vec3") ;
              ] ;
              section "A transform contains translation and rotation." [
                def_type 
                  ~doc:"A transform contains translation and rotation."
                  "transform" (abstract any) ;
                map_attribute "transform" "position" ~rename:"transform_position"  (abbrv "vec2") ;
                map_attribute "transform" "R" ~rename:"transform_r"  (abbrv "mat22") ;
                map_method "transform" "GetAngle" ~rename:"transform_get_angle" 
                  ~doc:"Calculate the angle that the rotation matrix represents."
                  [] 
                  float ;
                map_method "transform" "Initialize" ~rename:"transform_initialize" 
                  ~doc:"Initialize using a position vector and a rotation matrix."
                  [ curry_arg "pos" ((abbrv "vec2") @@ arg 0) ;
                    curry_arg "r" ((abbrv "mat22") @@ arg 1) ] void ;
                map_method "transform" "Set" ~rename:"transform_set"  [ curry_arg "x" ((abbrv "transform") @@ arg 0) ] void ;
                map_method "transform" "SetIdentity" ~rename:"transform_set_identity" 
                  ~doc:"Set this to the identity transform."
                  [] void ;
              ] ;
              section "This describes the motion of a body/shape for TOI computation." [
                def_type 
                  ~doc:"This describes the motion of a body/shape for TOI \
                        computation."
                  "sweep" (abstract any) ;
                map_attribute "sweep" "a" ~rename:"sweep_a" 
                  ~doc:"World angle"
                  float ;
                map_attribute "sweep" "a0" ~rename:"sweep_a0" 
                  ~doc:"World angle"
                  float ;
                map_attribute "sweep" "c" ~rename:"sweep_c" 
                  ~doc:"Center world position"
                  (abbrv "vec2") ;
                map_attribute "sweep" "c0" ~rename:"sweep_c0" 
                  ~doc:"Center world position"
                  (abbrv "vec2") ;
                map_attribute "sweep" "localCenter" ~rename:"sweep_local_center" 
                  ~doc:"Local center of mass position"
                  (abbrv "vec2") ;
                map_attribute "sweep" "t0" ~rename:"sweep_t0" 
                  ~doc:"Time interval = [t0,1], where t0 is in [0,1]"
                  float ;
                map_method "sweep" "Advance" ~rename:"sweep_advance" 
                  ~doc:"Advance the sweep forward, yielding a new initial state."
                  [ curry_arg "t" (float @@ arg 0) ] void ;
                map_method "sweep" "Copy" ~rename:"sweep_copy"  [] 
                  (abbrv "sweep") ;
                map_method "sweep" "GetTransform" ~rename:"sweep_get_transform" 
                  ~doc:"Get the interpolated transform at a specific time."
                  [ curry_arg "xf" ((abbrv "transform") @@ arg 0) ;
                    curry_arg "alpha" (float @@ arg 1) ] void ;
                map_method "sweep" "Set" ~rename:"sweep_set"  [ curry_arg "other" ((abbrv "sweep") @@ arg 0) ] void ;
              ] ;
            ] ;
        ] ;
      ] ;
    structure "Debug_draw"
      ~doc:"Provide debug drawing of physics entities in your game"
      [
        section "Implement and register this class with a b2World to provide debug drawing of physics entities in your game." [
          def_type 
            ~doc:"Implement and register this class with a b2World to provide \
                  debug drawing of physics entities in your game."
            "t" (abstract any) ;
          map_constructor "t" "make"
            ~doc:"Build a new debug drawing zone"
            [] "Box2D.Dynamics.b2DebugDraw" ;
          map_global "debug_draw_e_aabb_bit"
            ~doc:"Draw axis aligned bounding boxes"
            (int @@ field (field (field (global "Box2D") "Dynamics") "b2DebugDraw") "e_aabbBit") ;
          map_global "debug_draw_e_center_of_mass_bit"
            ~doc:"Draw center of mass frame"
            (int @@ field (field (field (global "Box2D") "Dynamics") "b2DebugDraw") "e_centerOfMassBit") ;
          map_global "debug_draw_e_controller_bit"
            ~doc:"Draw controllers"
            (int @@ field (field (field (global "Box2D") "Dynamics") "b2DebugDraw") "e_controllerBit") ;
          map_global "debug_draw_e_joint_bit"
            ~doc:"Draw joint connections"
            (int @@ field (field (field (global "Box2D") "Dynamics") "b2DebugDraw") "e_jointBit") ;
          map_global "debug_draw_e_pair_bit"
            ~doc:"Draw broad-phase pairs"
            (int @@ field (field (field (global "Box2D") "Dynamics") "b2DebugDraw") "e_pairBit") ;
          map_global "debug_draw_e_shape_bit"
            ~doc:"Draw shapes"
            (int @@ field (field (field (global "Box2D") "Dynamics") "b2DebugDraw") "e_shapeBit") ;
          map_method "t" "AppendFlags" ~rename:"debug_draw_append_flags" 
            ~doc:"Append flags to the current flags."
            [ curry_arg "flags" (int @@ arg 0) ] void ;
          map_method "t" "ClearFlags" ~rename:"debug_draw_clear_flags" 
            ~doc:"Clear flags from the current flags."
            [ curry_arg "flags" (int @@ arg 0) ] void ;
          map_method "t" "DrawCircle" ~rename:"debug_draw_draw_circle" 
            ~doc:"Draw a circle."
            [ curry_arg "center" ((abbrv "Common.Math.vec2") @@ arg 0) ;
              curry_arg "radius" (float @@ arg 1) ;
              curry_arg "color" ((abbrv "Common.color") @@ arg 2) ] void ;
          map_method "t" "DrawPolygon" ~rename:"debug_draw_draw_polygon" 
            ~doc:"Draw a closed polygon provided in CCW order."
            [ curry_arg "vertices" ((array any) @@ arg 0) ;
              curry_arg "vertex_count" (int @@ arg 1) ;
              curry_arg "color" ((abbrv "Common.color") @@ arg 2) ] void ;
          map_method "t" "DrawSegment" ~rename:"debug_draw_draw_segment" 
            ~doc:"Draw a line segment."
            [ curry_arg "p1" ((abbrv "Common.Math.vec2") @@ arg 0) ;
              curry_arg "p2" ((abbrv "Common.Math.vec2") @@ arg 1) ;
              curry_arg "color" ((abbrv "Common.color") @@ arg 2) ] void ;
          map_method "t" "DrawSolidCircle" ~rename:"debug_draw_draw_solid_circle" 
            ~doc:"Draw a solid circle."
            [ curry_arg "center" ((abbrv "Common.Math.vec2") @@ arg 0) ;
              curry_arg "radius" (float @@ arg 1) ;
              curry_arg "axis" ((abbrv "Common.Math.vec2") @@ arg 2) ;
              curry_arg "color" ((abbrv "Common.color") @@ arg 3) ] void ;
          map_method "t" "DrawSolidPolygon" ~rename:"debug_draw_draw_solid_polygon" 
            ~doc:"Draw a solid closed polygon provided in CCW order."
            [ curry_arg "vertices" ((array any) @@ arg 0) ;
              curry_arg "vertex_count" (int @@ arg 1) ;
              curry_arg "color" ((abbrv "Common.color") @@ arg 2) ] void ;
          map_method "t" "DrawTransform" ~rename:"debug_draw_draw_transform" 
            ~doc:"Draw a transform. Choose your own length scale."
            [ curry_arg "xf" ((abbrv "Common.Math.transform") @@ arg 0) ] void ;
          map_method "t" "GetAlpha" ~rename:"debug_draw_get_alpha" 
            ~doc:"Get the alpha value used for lines"
            [] 
            float ;
          map_method "t" "GetDrawScale" ~rename:"debug_draw_get_draw_scale" 
            ~doc:"Get the draw"
            [] 
            float ;
          map_method "t" "GetFillAlpha" ~rename:"debug_draw_get_fill_alpha" 
            ~doc:"Get the alpha value used for fills"
            [] 
            float ;
          map_method "t" "GetFlags" ~rename:"debug_draw_get_flags" 
            ~doc:"Get the drawing flags."
            [] 
            int ;
          map_method "t" "GetLineThickness" ~rename:"debug_draw_get_line_thickness" 
            ~doc:"Get the line thickness"
            [] 
            float ;
          map_method "t" "GetXFormScale" ~rename:"debug_draw_get_xform_scale" 
            ~doc:"Get the scale used for drawing XForms"
            [] 
            float ;
          map_method "t" "SetAlpha" ~rename:"debug_draw_set_alpha" 
            ~doc:"Set the alpha value used for lines"
            [ curry_arg "alpha" (float @@ arg 0) ] void ;
          map_method "t" "SetDrawScale" ~rename:"debug_draw_set_draw_scale" 
            ~doc:"Set the draw scale"
            [ curry_arg "draw_scale" (float @@ arg 0) ] void ;
          map_method "t" "SetFillAlpha" ~rename:"debug_draw_set_fill_alpha" 
            ~doc:"Set the alpha value used for fills"
            [ curry_arg "alpha" (float @@ arg 0) ] void ;
          map_method "t" "SetFlags" ~rename:"debug_draw_set_flags" 
            ~doc:"Set the drawing flags."
            [ curry_arg "flags" (int @@ arg 0) ] void ;
          map_method "t" "SetLineThickness" ~rename:"debug_draw_set_line_thickness" 
            ~doc:"Set the line thickness"
            [ curry_arg "line_thickness" (float @@ arg 0) ] void ;
          map_method "t" "SetSprite" ~rename:"debug_draw_assign_canvas" 
            ~doc:"Set the canvas context to draw into"
            [ curry_arg "context" ((abbrv "Canvas.context") @@ arg 0) ] void ;
          map_method "t" "SetXFormScale" ~rename:"debug_draw_set_xform_scale" 
            ~doc:"Set the scale used for drawing XForms"
            [ curry_arg "xform_scale" (float @@ arg 0) ] void ;
        ] ;
      ] ;
    structure "Collision"
      ~doc:""
      [
        section "Helper Types" [
          def_type  "ray_cast_output" (abstract any) ;
          map_attribute "ray_cast_output" "fraction" ~rename:"ray_cast_output_fraction" 
            ~doc:"The fraction between p1 and p2 that the collision occurs at"
            float ;
          map_attribute "ray_cast_output" "normal" ~rename:"ray_cast_output_normal" 
            ~doc:"The normal at the point of collision"
            (abbrv "Common.Math.vec2") ;
          def_type  "ray_cast_input" (abstract any) ;
          map_attribute "ray_cast_input" "maxFraction" ~rename:"ray_cast_input_max_fraction" 
            ~doc:"Truncate the ray to reach up to this fraction from p1 to p2"
            float ;
          map_attribute "ray_cast_input" "p1" ~rename:"ray_cast_input_p1" 
            ~doc:"The start point of the ray"
            (abbrv "Common.Math.vec2") ;
          map_attribute "ray_cast_input" "p2" ~rename:"ray_cast_input_p2" 
            ~doc:"The end point of the ray"
            (abbrv "Common.Math.vec2") ;
        ] ;
        section "An axis aligned bounding box." [
          def_type 
            ~doc:"An axis aligned bounding box."
            "aabb" (abstract any) ;
          map_attribute "aabb" "lowerBound" ~rename:"aabb_lower_bound" 
            ~doc:"The lower vertex"
            (abbrv "Common.Math.vec2") ;
          map_attribute "aabb" "upperBound" ~rename:"aabb_upper_bound" 
            ~doc:"The upper vertex"
            (abbrv "Common.Math.vec2") ;
          map_function "aabb_combine"
            ~doc:"Combine two AABBs into one."

            [ curry_arg "aabb1" ((abbrv "aabb") @@ arg 0) ;
              curry_arg "aabb2" ((abbrv "aabb") @@ arg 1) ]
            "Box2D.Collision.b2AABB.Combine" 
            (abbrv "aabb") ;
          map_method "aabb" "Contains" ~rename:"aabb_contains" 
            ~doc:"Is an AABB contained within this one."
            [ curry_arg "aabb" ((abbrv "aabb") @@ arg 0) ] 
            bool ;
          map_method "aabb" "GetCenter" ~rename:"aabb_get_center" 
            ~doc:"Get the center of the AABB."
            [] 
            (abbrv "Common.Math.vec2") ;
          map_method "aabb" "GetExtents" ~rename:"aabb_get_extents" 
            ~doc:"Get the extents of the AABB (half-widths)."
            [] 
            (abbrv "Common.Math.vec2") ;
          map_method "aabb" "IsValid" ~rename:"aabb_is_valid" 
            ~doc:"Verify that the bounds are sorted."
            [] 
            bool ;
          map_method "aabb" "RayCast" ~rename:"aabb_ray_cast" 
            ~doc:"Perform a precise raycast against the AABB."
            [ curry_arg "output" ((abbrv "ray_cast_output") @@ arg 0) ;
              curry_arg "input" ((abbrv "ray_cast_input") @@ arg 1) ] 
            bool ;
          map_method "aabb" "TestOverlap" ~rename:"aabb_test_overlap" 
            ~doc:"Tests if another AABB overlaps this one."
            [ curry_arg "other" ((abbrv "aabb") @@ arg 0) ] 
            bool ;
        ] ;
        section "We use contact ids to facilitate warm starting." [
          def_type 
            ~doc:"We use contact ids to facilitate warm starting."
            "contact_id" (abstract any) ;
          def_type  "features" (abstract any) ;
          map_attribute "contact_id" "features" ~rename:"contact_id_features"  (abbrv "features") ;
          map_method "contact_id" "Copy" ~rename:"contact_id_copy"  [] 
            (abbrv "contact_id") ;
          map_method "contact_id" "Set" ~rename:"contact_id_set"  [ curry_arg "id" ((abbrv "contact_id") @@ arg 0) ] void ;
          structure "Shapes"
            ~doc:""
            [
              section "This holds the mass data computed for a shape." [
                def_type 
                  ~doc:"This holds the mass data computed for a shape."
                  "mass_data" (abstract any) ;
                map_attribute "mass_data" "center" ~rename:"mass_data_center" 
                  ~doc:"The position of the shape's centroid relative to the \
                        shape's origin."
                  (abbrv "Common.Math.vec2") ;
                map_attribute "mass_data" "I" ~rename:"mass_data_i" 
                  ~doc:"The rotational inertia of the shape. This may be about the \
                        center or local origin, depending on usage."
                  float ;
                map_attribute "mass_data" "mass" ~rename:"mass_data_mass" 
                  ~doc:"The mass of the shape, usually in kilograms."
                  float ;
              ] ;
              section "A shape is used for collision detection." [
                def_type 
                  ~doc:"A shape is used for collision detection."
                  "shape" (abstract any) ;
                map_method "shape" "ComputeAABB" ~rename:"shape_compute_aabb" 
                  ~doc:"Given a transform, compute the associated axis aligned \
                        bounding box for this shape."
                  [ curry_arg "aabb" ((abbrv "aabb") @@ arg 0) ;
                    curry_arg "xf" ((abbrv "Common.Math.transform") @@ arg 1) ] void ;
                map_method "shape" "ComputeMass" ~rename:"shape_compute_mass" 
                  ~doc:"Compute the mass properties of this shape using its \
                        dimensions and density. The inertia tensor is computed \
                        about the local origin, not the centroid."
                  [ curry_arg "mass_data" ((abbrv "mass_data") @@ arg 0) ;
                    curry_arg "density" (float @@ arg 1) ] void ;
                map_method "shape" "ComputeSubmergedArea" ~rename:"shape_compute_submerged_area" 
                  ~doc:"Compute the volume and centroid of this shape intersected \
                        with a half plane"
                  [ curry_arg "normal" ((abbrv "Common.Math.vec2") @@ arg 0) ;
                    curry_arg "offset" (float @@ arg 1) ;
                    curry_arg "xf" ((abbrv "Common.Math.transform") @@ arg 2) ;
                    curry_arg "c" ((abbrv "Common.Math.vec2") @@ arg 3) ] 
                  float ;
                map_method "shape" "Copy" ~rename:"shape_copy" 
                  ~doc:"Clone the shape"
                  [] 
                  (abbrv "shape") ;
                map_method "shape" "GetType" ~rename:"shape_get_type" 
                  ~doc:"Get the type of this shape. You can use this to down cast \
                        to the concrete shape."
                  [] 
                  int ;
                map_method "shape" "RayCast" ~rename:"shape_ray_cast" 
                  ~doc:"Cast a ray against this shape."
                  [ curry_arg "output" ((abbrv "ray_cast_output") @@ arg 0) ;
                    curry_arg "input" ((abbrv "ray_cast_input") @@ arg 1) ;
                    curry_arg "transform" ((abbrv "Common.Math.transform") @@ arg 2) ] 
                  bool ;
                map_method "shape" "Set" ~rename:"shape_set" 
                  ~doc:"Assign the properties of anther shape to this"
                  [ curry_arg "other" ((abbrv "shape") @@ arg 0) ] void ;
                map_function "shape_test_overlap"
                  [ curry_arg "shape1" ((abbrv "shape") @@ arg 0) ;
                    curry_arg "transform1" ((abbrv "Common.Math.transform") @@ arg 1) ;
                    curry_arg "shape2" ((abbrv "shape") @@ arg 2) ;
                    curry_arg "transform2" ((abbrv "Common.Math.transform") @@ arg 3) ]
                  "Box2D.Collision.Shapes.b2Shape.TestOverlap" 
                  bool ;
                map_method "shape" "TestPoint" ~rename:"shape_test_point" 
                  ~doc:"Test a point for containment in this shape. This only works \
                        for convex shapes."
                  [ curry_arg "xf" ((abbrv "Common.Math.transform") @@ arg 0) ;
                    curry_arg "p" ((abbrv "Common.Math.vec2") @@ arg 1) ] 
                  bool ;
                map_global "shape_e_hit_collide"
                  ~doc:"Possible return values for TestSegment"
                  ~read_only:true (int @@ field (field (field (field (global "Box2D") "Collision") "Shapes") "b2Shape") "e_hitCollide") ;
                map_global "shape_e_miss_collide"
                  ~doc:"Return value for TestSegment indicating a miss."
                  ~read_only:true (int @@ field (field (field (field (global "Box2D") "Collision") "Shapes") "b2Shape") "e_missCollide") ;
                map_global "shape_e_starts_inside_collide"
                  ~doc:"Return value for TestSegment indicating that the segment \
                        starting point, p1, is already inside the shape."
                  ~read_only:true (int @@ field (field (field (field (global "Box2D") "Collision") "Shapes") "b2Shape") "e_startsInsideCollide") ;
              ] ;
              section "This structure is used to build edge shapes." [
              ] ;
              section "A circle shape." [
                def_type 
                  ~doc:"A circle shape."
                  "circle_shape" (abstract any) ;
                inherits ([], "circle_shape") ([], "shape") "as_shape" ;
                map_method "circle_shape" "GetLocalPosition" ~rename:"circle_shape_get_local_position" 
                  ~doc:"Get the local position of this circle in its parent body."
                  [] 
                  (abbrv "Common.Math.vec2") ;
                map_method "circle_shape" "GetRadius" ~rename:"circle_shape_get_radius" 
                  ~doc:"Get the radius of the circle"
                  [] 
                  float ;
                map_method "circle_shape" "SetLocalPosition" ~rename:"circle_shape_set_local_position" 
                  ~doc:"Set the local position of this circle in its parent body."
                  [ curry_arg "position" ((abbrv "Common.Math.vec2") @@ arg 0) ] void ;
                map_method "circle_shape" "SetRadius" ~rename:"circle_shape_set_radius" 
                  ~doc:"Set the radius of the circle"
                  [ curry_arg "radius" (float @@ arg 0) ] void ;
              ] ;
              section "Convex polygon." [
                def_type 
                  ~doc:"Convex polygon."
                  "polygon_shape" (abstract any) ;
                inherits ([], "polygon_shape") ([], "shape") "as_shape" ;
                map_function "polygon_shape_as_array"
                  [ curry_arg "vertices" ((array any) @@ arg 0) ;
                    curry_arg "vertexCount" (float @@ arg 1) ]
                  "Box2D.Collision.Shapes.b2PolygonShape.AsArray" 
                  (abbrv "polygon_shape") ;
                map_function "polygon_shape_as_box"
                  [ curry_arg "hx" (float @@ arg 0) ;
                    curry_arg "hy" (float @@ arg 1) ]
                  "Box2D.Collision.Shapes.b2PolygonShape.AsBox" 
                  (abbrv "polygon_shape") ;
                map_function "polygon_shape_as_edge"
                  ~doc:"Set this as a single edge."

                  [ curry_arg "v1" ((abbrv "Common.Math.vec2") @@ arg 0) ;
                    curry_arg "v2" ((abbrv "Common.Math.vec2") @@ arg 1) ]
                  "Box2D.Collision.Shapes.b2PolygonShape.AsEdge" 
                  (abbrv "polygon_shape") ;
                map_function "polygon_shape_as_oriented_box"
                  [ curry_arg "hx" (float @@ arg 0) ;
                    curry_arg "hy" (float @@ arg 1) ;
                    curry_arg "center" ((abbrv "Common.Math.vec2") @@ arg 2) ;
                    curry_arg "angle" (float @@ arg 3) ]
                  "Box2D.Collision.Shapes.b2PolygonShape.AsOrientedBox" 
                  (abbrv "polygon_shape") ;
                map_function "polygon_shape_as_vector"
                  [ curry_arg "vertices" ((array (abbrv "Common.Math.vec2")) @@ arg 0) ;
                    curry_arg "vertexCount" (float @@ arg 1) ]
                  "Box2D.Collision.Shapes.b2PolygonShape.AsVector" 
                  (abbrv "polygon_shape") ;
                map_function "polygon_shape_compute_centroid"
                  ~doc:"Computes the centroid of the given polygon"

                  [ curry_arg "vs" ((array float) @@ arg 0) ;
                    curry_arg "count" (int @@ arg 1) ]
                  "Box2D.Collision.Shapes.b2PolygonShape.ComputeCentroid" 
                  (abbrv "Common.Math.vec2") ;
                map_method "polygon_shape" "GetNormals" ~rename:"polygon_shape_get_normals" 
                  ~doc:"Get the edge normal vectors. There is one for each vertex."
                  [] 
                  (array (abbrv "Common.Math.vec2")) ;
                map_method "polygon_shape" "GetSupport" ~rename:"polygon_shape_get_support" 
                  ~doc:"Get the supporting vertex index in the given direction."
                  [ curry_arg "d" ((abbrv "Common.Math.vec2") @@ arg 0) ] 
                  int ;
                map_method "polygon_shape" "GetSupportVertex" ~rename:"polygon_shape_get_support_vertex"  [ curry_arg "d" ((abbrv "Common.Math.vec2") @@ arg 0) ] 
                  (abbrv "Common.Math.vec2") ;
                map_method "polygon_shape" "GetVertexCount" ~rename:"polygon_shape_get_vertex_count" 
                  ~doc:"Get the vertex count."
                  [] 
                  int ;
                map_method "polygon_shape" "GetVertices" ~rename:"polygon_shape_get_vertices" 
                  ~doc:"Get the vertices in local coordinates."
                  [] 
                  (array any) ;
                map_method "polygon_shape" "SetAsArray" ~rename:"polygon_shape_set_as_array" 
                  ~doc:"Copy vertices. This assumes the vertices define a convex \
                        polygon. It is assumed that the exterior is the the right \
                        of each edge."
                  [ curry_arg "vertices" ((array any) @@ arg 0) ;
                    curry_arg "vertex_count" (float @@ arg 1) ] void ;
                map_method "polygon_shape" "SetAsBox" ~rename:"polygon_shape_set_as_box" 
                  ~doc:"Build vertices to represent an axis-aligned box."
                  [ curry_arg "hx" (float @@ arg 0) ;
                    curry_arg "hy" (float @@ arg 1) ] void ;
                map_method "polygon_shape" "SetAsEdge" ~rename:"polygon_shape_set_as_edge" 
                  ~doc:"Set this as a single edge."
                  [ curry_arg "v1" ((abbrv "Common.Math.vec2") @@ arg 0) ;
                    curry_arg "v2" ((abbrv "Common.Math.vec2") @@ arg 1) ] void ;
                map_method "polygon_shape" "SetAsOrientedBox" ~rename:"polygon_shape_set_as_oriented_box"  [ curry_arg "hx" (float @@ arg 0) ;
                                                                                                             curry_arg "hy" (float @@ arg 1) ;
                                                                                                             curry_arg "center" ((abbrv "Common.Math.vec2") @@ arg 2) ;
                                                                                                             curry_arg "angle" (float @@ arg 3) ] void ;
                map_method "polygon_shape" "SetAsVector" ~rename:"polygon_shape_set_as_vector" 
                  ~doc:"Copy vertices. This assumes the vertices define a convex \
                        polygon. It is assumed that the exterior is the the right \
                        of each edge."
                  [ curry_arg "vertices" ((array (abbrv "Common.Math.vec2")) @@ arg 0) ;
                    curry_arg "vertex_count" (float @@ arg 1) ] void ;
                def_type 
                  ~doc:"This structure is used to build edge shapes."
                  "edge_chain_def" (abstract any) ;
                map_attribute "edge_chain_def" "isALoop" ~rename:"edge_chain_def_is_aloop" 
                  ~doc:"Whether to create an extra edge between the first and last \
                        vertices."
                  bool ;
                map_attribute "edge_chain_def" "vertexCount" ~rename:"edge_chain_def_vertex_count" 
                  ~doc:"The number of vertices in the chain."
                  int ;
                map_attribute "edge_chain_def" "vertices" ~rename:"edge_chain_def_vertices" 
                  ~doc:"The vertices in local coordinates."
                  (array any) ;
              ] ;
            ] ;
        ] ;
        section "A manifold for two touching convex shapes." [
          def_type 
            ~doc:"A manifold for two touching convex shapes."
            "manifold" (abstract any) ;
          map_attribute "manifold" "m_localPlaneNormal" ~rename:"manifold_m_local_plane_normal" 
            ~doc:"Not used for Type e_points"
            (abbrv "Common.Math.vec2") ;
          map_attribute "manifold" "m_localPoint" ~rename:"manifold_m_local_point" 
            ~doc:"Usage depends on manifold type"
            (abbrv "Common.Math.vec2") ;
          map_attribute "manifold" "m_pointCount" ~rename:"manifold_m_point_count" 
            ~doc:"The number of manifold points"
            int ;
          map_attribute "manifold" "m_points" ~rename:"manifold_m_points" 
            ~doc:"The points of contact"
            (array any) ;
          map_attribute "manifold" "m_type" ~rename:"manifold_m_type"  int ;
          map_method "manifold" "Copy" ~rename:"manifold_copy"  [] 
            (abbrv "manifold") ;
          map_method "manifold" "Reset" ~rename:"manifold_reset"  [] void ;
          map_method "manifold" "Set" ~rename:"manifold_set"  [ curry_arg "m" ((abbrv "manifold") @@ arg 0) ] void ;
          map_global "manifold_e_circles" ~read_only:true (int @@ field (field (field (global "Box2D") "Collision") "b2Manifold") "e_circles") ;
          map_global "manifold_e_face_a" ~read_only:true (int @@ field (field (field (global "Box2D") "Collision") "b2Manifold") "e_faceA") ;
          map_global "manifold_e_face_b" ~read_only:true (int @@ field (field (field (global "Box2D") "Collision") "b2Manifold") "e_faceB") ;
        ] ;
        section "This is used to compute the current state of a contact manifold." [
          def_type 
            ~doc:"This is used to compute the current state of a contact \
                  manifold."
            "world_manifold" (abstract any) ;
          map_attribute "world_manifold" "m_normal" ~rename:"world_manifold_m_normal" 
            ~doc:"world vector pointing from A to B"
            (abbrv "Common.Math.vec2") ;
          map_attribute "world_manifold" "m_points" ~rename:"world_manifold_m_points" 
            ~doc:"world contact point (point of intersection)"
            (array any) ;
          map_method "world_manifold" "Initialize" ~rename:"world_manifold_initialize" 
            ~doc:"Evaluate the manifold with supplied transforms. This \
                  assumes modest motion from the original state. This does \
                  not change the point count, impulses, etc. The radii must \
                  come from the shapes that generated the manifold."
            [ curry_arg "manifold" ((abbrv "manifold") @@ arg 0) ;
              curry_arg "xf_a" ((abbrv "Common.Math.transform") @@ arg 1) ;
              curry_arg "radius_a" (float @@ arg 2) ;
              curry_arg "xf_b" ((abbrv "Common.Math.transform") @@ arg 3) ;
              curry_arg "radius_b" (float @@ arg 4) ] void ;
        ] ;
        section "This structure is used to report contact points." [
          def_type 
            ~doc:"This structure is used to report contact points."
            "contact_point" (abstract any) ;
          map_attribute "contact_point" "friction" ~rename:"contact_point_friction" 
            ~doc:"The combined friction coefficient"
            float ;
          map_attribute "contact_point" "id" ~rename:"contact_point_id" 
            ~doc:"The contact id identifies the features in contact"
            (abbrv "contact_id") ;
          map_attribute "contact_point" "normal" ~rename:"contact_point_normal" 
            ~doc:"Points from shape1 to shape2"
            (abbrv "Common.Math.vec2") ;
          map_attribute "contact_point" "position" ~rename:"contact_point_position" 
            ~doc:"Position in world coordinates"
            (abbrv "Common.Math.vec2") ;
          map_attribute "contact_point" "restitution" ~rename:"contact_point_restitution" 
            ~doc:"The combined restitution coefficient"
            float ;
          map_attribute "contact_point" "separation" ~rename:"contact_point_separation" 
            ~doc:"The separation is negative when shapes are touching"
            float ;
          map_attribute "contact_point" "shape1" ~rename:"contact_point_shape1" 
            ~doc:"The first shape"
            (abbrv "Shapes.shape") ;
          map_attribute "contact_point" "shape2" ~rename:"contact_point_shape2" 
            ~doc:"The second shape"
            (abbrv "Shapes.shape") ;
          map_attribute "contact_point" "velocity" ~rename:"contact_point_velocity" 
            ~doc:"Velocity of point on body2 relative to point on body1 \
                  (pre-solver)"
            (abbrv "Common.Math.vec2") ;
        ] ;
        section "A manifold point is a contact point belonging to a contact manifold." [
          def_type 
            ~doc:"A manifold point is a contact point belonging to a contact \
                  manifold."
            "manifold_point" (abstract any) ;
          map_attribute "manifold_point" "m_id" ~rename:"manifold_point_m_id"  (abbrv "contact_id") ;
          map_attribute "manifold_point" "m_localPoint" ~rename:"manifold_point_m_local_point"  (abbrv "Common.Math.vec2") ;
          map_attribute "manifold_point" "m_normalImpulse" ~rename:"manifold_point_m_normal_impulse"  float ;
          map_attribute "manifold_point" "m_tangentImpulse" ~rename:"manifold_point_m_tangent_impulse"  float ;
          map_method "manifold_point" "Reset" ~rename:"manifold_point_reset"  [] void ;
          map_method "manifold_point" "Set" ~rename:"manifold_point_set"  [ curry_arg "m" ((abbrv "manifold_point") @@ arg 0) ] void ;
        ] ;
        section "Output for b2Distance." [
          def_type 
            ~doc:"Output for b2Distance."
            "distance_output" (abstract any) ;
          map_attribute "distance_output" "distance" ~rename:"distance_output_distance"  float ;
          map_attribute "distance_output" "iterations" ~rename:"distance_output_iterations" 
            ~doc:"Number of gjk iterations used"
            int ;
          map_attribute "distance_output" "pointA" ~rename:"distance_output_point_a" 
            ~doc:"Closest point on shapea"
            (abbrv "Common.Math.vec2") ;
          map_attribute "distance_output" "pointB" ~rename:"distance_output_point_b" 
            ~doc:"Closest point on shapeb"
            (abbrv "Common.Math.vec2") ;
        ] ;
        section "Interface for objects tracking overlap of many AABBs." [
          def_type 
            ~doc:"Interface for objects tracking overlap of many AABBs."
            "ibroad_phase" (abstract any) ;
          map_method "ibroad_phase" "CreateProxy" ~rename:"ibroad_phase_create_proxy" 
            ~doc:"Create a proxy with an initial AABB. Pairs are not reported \
                  until UpdatePairs is called."
            [ curry_arg "aabb" ((abbrv "aabb") @@ arg 0) ;
              curry_arg "user_data" (any @@ arg 1) ] 
            any ;
          map_method "ibroad_phase" "DestroyProxy" ~rename:"ibroad_phase_destroy_proxy" 
            ~doc:"Destroy a proxy. It is up to the client to remove any pairs."
            [ curry_arg "proxy" (any @@ arg 0) ] void ;
          map_method "ibroad_phase" "GetFatAABB" ~rename:"ibroad_phase_get_fat_aabb" 
            ~doc:"Get the fat AABB for a proxy."
            [ curry_arg "proxy" (any @@ arg 0) ] 
            (abbrv "aabb") ;
          map_method "ibroad_phase" "GetProxyCount" ~rename:"ibroad_phase_get_proxy_count" 
            ~doc:"Get the number of proxies."
            [] 
            int ;
          map_method "ibroad_phase" "GetUserData" ~rename:"ibroad_phase_get_user_data" 
            ~doc:"Get user data from a proxy. Returns null if the proxy is \
                  invalid."
            [ curry_arg "proxy" (any @@ arg 0) ] 
            any ;
          map_method "ibroad_phase" "MoveProxy" ~rename:"ibroad_phase_move_proxy" 
            ~doc:"Call MoveProxy as many times as you like, then when you are \
                  done call UpdatePairs to finalized the proxy pairs (for \
                  your time step)."
            [ curry_arg "proxy" (any @@ arg 0) ;
              curry_arg "aabb" ((abbrv "aabb") @@ arg 1) ;
              curry_arg "displacement" ((abbrv "Common.Math.vec2") @@ arg 2) ] void ;
          map_method "ibroad_phase" "Query" ~rename:"ibroad_phase_query" 
            ~doc:"Query an AABB for overlapping proxies. The callback class \
                  is called with each proxy that overlaps the supplied AABB, \
                  and return a Boolean indicating if the broaphase should \
                  proceed to the next match."
            [ curry_arg "callback" ((callback [] void) @@ arg 0) ;
              curry_arg "aabb" ((abbrv "aabb") @@ arg 1) ] void ;
          map_method "ibroad_phase" "RayCast" ~rename:"ibroad_phase_ray_cast" 
            ~doc:"Ray-cast agains the proxies in the tree. This relies on the \
                  callback to perform exact ray-cast in the case where the \
                  proxy contains a shape The callback also performs any \
                  collision filtering"
            [ curry_arg "callback" ((callback [] void) @@ arg 0) ;
              curry_arg "input" ((abbrv "ray_cast_input") @@ arg 1) ] void ;
          map_method "ibroad_phase" "Rebalance" ~rename:"ibroad_phase_rebalance" 
            ~doc:"Give the broadphase a chance for structural optimizations"
            [ curry_arg "iterations" (int @@ arg 0) ] void ;
          map_method "ibroad_phase" "TestOverlap" ~rename:"ibroad_phase_test_overlap"  [ curry_arg "proxy_a" (any @@ arg 0) ;
                                                                                         curry_arg "proxy_b" (any @@ arg 1) ] 
            bool ;
          map_method "ibroad_phase" "UpdatePairs" ~rename:"ibroad_phase_update_pairs" 
            ~doc:"Update the pairs. This results in pair callbacks. This can \
                  only add pairs."
            [ curry_arg "callback" ((callback [] void) @@ arg 0) ] void ;
          map_method "ibroad_phase" "Validate" ~rename:"ibroad_phase_validate" 
            ~doc:"For debugging, throws in invariants have been broken"
            [] void ;
        ] ;
        section "A line in space between two given vertices." [
          def_type 
            ~doc:"A line in space between two given vertices."
            "segment" (abstract any) ;
          map_attribute "segment" "p1" ~rename:"segment_p1" 
            ~doc:"The starting point"
            (abbrv "Common.Math.vec2") ;
          map_attribute "segment" "p2" ~rename:"segment_p2" 
            ~doc:"The ending point"
            (abbrv "Common.Math.vec2") ;
          map_method "segment" "Extend" ~rename:"segment_extend" 
            ~doc:"Extends or clips the segment so that it's ends lie on the \
                  boundary of the AABB"
            [ curry_arg "aabb" ((abbrv "aabb") @@ arg 0) ] void ;
          map_method "segment" "ExtendBackward" ~rename:"segment_extend_backward"  [ curry_arg "aabb" ((abbrv "aabb") @@ arg 0) ] void ;
          map_method "segment" "ExtendForward" ~rename:"segment_extend_forward"  [ curry_arg "aabb" ((abbrv "aabb") @@ arg 0) ] void ;
          map_method "segment" "TestSegment" ~rename:"segment_test_segment" 
            ~doc:"Ray cast against this segment with another segment"
            [ curry_arg "lambda" ((array any) @@ arg 0) ;
              curry_arg "normal" ((abbrv "Common.Math.vec2") @@ arg 1) ;
              curry_arg "segment" ((abbrv "segment") @@ arg 2) ;
              curry_arg "max_lambda" (float @@ arg 3) ] 
            bool ;
        ] ;
        section "An oriented bounding box." [
          def_type 
            ~doc:"An oriented bounding box."
            "obb" (abstract any) ;
          map_attribute "obb" "center" ~rename:"obb_center" 
            ~doc:"The local centroid"
            (abbrv "Common.Math.vec2") ;
          map_attribute "obb" "extents" ~rename:"obb_extents" 
            ~doc:"The half-widths"
            (abbrv "Common.Math.vec2") ;
          map_attribute "obb" "R" ~rename:"obb_r" 
            ~doc:"The rotation matrix"
            (abbrv "Common.Math.mat22") ;
        ] ;
        section "A distance proxy is used by the GJK algorithm." [
          def_type 
            ~doc:"A distance proxy is used by the GJK algorithm."
            "distance_proxy" (abstract any) ;
          map_attribute "distance_proxy" "m_count" ~rename:"distance_proxy_m_count"  int ;
          map_attribute "distance_proxy" "m_radius" ~rename:"distance_proxy_m_radius"  float ;
          map_attribute "distance_proxy" "m_vertices" ~rename:"distance_proxy_m_vertices"  (array any) ;
          map_method "distance_proxy" "GetSupport" ~rename:"distance_proxy_get_support" 
            ~doc:"Get the supporting vertex index in the given direction."
            [ curry_arg "d" ((abbrv "Common.Math.vec2") @@ arg 0) ] 
            float ;
          map_method "distance_proxy" "GetSupportVertex" ~rename:"distance_proxy_get_support_vertex" 
            ~doc:"Get the supporting vertex in the given direction."
            [ curry_arg "d" ((abbrv "Common.Math.vec2") @@ arg 0) ] 
            (abbrv "Common.Math.vec2") ;
          map_method "distance_proxy" "GetVertex" ~rename:"distance_proxy_get_vertex" 
            ~doc:"Get a vertex by index. Used by b2Distance."
            [ curry_arg "index" (int @@ arg 0) ] 
            (abbrv "Common.Math.vec2") ;
          map_method "distance_proxy" "GetVertexCount" ~rename:"distance_proxy_get_vertex_count" 
            ~doc:"Get the vertex count."
            [] 
            int ;
          map_method "distance_proxy" "Set" ~rename:"distance_proxy_set" 
            ~doc:"Initialize the proxy using the given shape. The shape must \
                  remain in scope while the proxy is in use."
            [ curry_arg "shape" ((abbrv "Shapes.shape") @@ arg 0) ] void ;
        ] ;
        section "Input for b2Distance." [
          def_type 
            ~doc:"Input for b2Distance."
            "distance_input" (abstract any) ;
          map_attribute "distance_input" "proxyA" ~rename:"distance_input_proxy_a"  (abbrv "distance_proxy") ;
          map_attribute "distance_input" "proxyB" ~rename:"distance_input_proxy_b"  (abbrv "distance_proxy") ;
          map_attribute "distance_input" "transformA" ~rename:"distance_input_transform_a"  (abbrv "Common.Math.transform") ;
          map_attribute "distance_input" "transformB" ~rename:"distance_input_transform_b"  (abbrv "Common.Math.transform") ;
          map_attribute "distance_input" "useRadii" ~rename:"distance_input_use_radii"  bool ;
        ] ;
        section "A dynamic tree arranges data in a binary tree to accelerate queries such as volume queries and ray casts." [
          def_type 
            ~doc:"A dynamic tree arranges data in a binary tree to accelerate \
                  queries such as volume queries and ray casts."
            "dynamic_tree" (abstract any) ;
          def_type  "dynamic_tree_node" (abstract any) ;
          map_method "dynamic_tree" "CreateProxy" ~rename:"dynamic_tree_create_proxy" 
            ~doc:"Create a proxy. Provide a tight fitting AABB and a userData."
            [ curry_arg "aabb" ((abbrv "aabb") @@ arg 0) ;
              curry_arg "user_data" (any @@ arg 1) ] 
            (abbrv "dynamic_tree_node") ;
          map_method "dynamic_tree" "DestroyProxy" ~rename:"dynamic_tree_destroy_proxy" 
            ~doc:"Destroy a proxy. This asserts if the id is invalid."
            [ curry_arg "proxy" ((abbrv "dynamic_tree_node") @@ arg 0) ] void ;
          map_method "dynamic_tree" "GetFatAABB" ~rename:"dynamic_tree_get_fat_aabb"  [ curry_arg "proxy" ((abbrv "dynamic_tree_node") @@ arg 0) ] 
            (abbrv "aabb") ;
          map_method "dynamic_tree" "GetUserData" ~rename:"dynamic_tree_get_user_data" 
            ~doc:"Get user data from a proxy. Returns null if the proxy is \
                  invalid."
            [ curry_arg "proxy" ((abbrv "dynamic_tree_node") @@ arg 0) ] 
            any ;
          map_method "dynamic_tree" "MoveProxy" ~rename:"dynamic_tree_move_proxy" 
            ~doc:"Move a proxy with a swept AABB. If the proxy has moved \
                  outside of its fattened AABB, then the proxy is removed \
                  from the tree and re-inserted. Otherwise the function \
                  returns immediately."
            [ curry_arg "proxy" ((abbrv "dynamic_tree_node") @@ arg 0) ;
              curry_arg "aabb" ((abbrv "aabb") @@ arg 1) ;
              curry_arg "displacement" ((abbrv "Common.Math.vec2") @@ arg 2) ] 
            bool ;
          map_method "dynamic_tree" "Query" ~rename:"dynamic_tree_query" 
            ~doc:"Query an AABB for overlapping proxies. The callback is \
                  called for each proxy that overlaps the supplied AABB. The \
                  callback should match function signaturefuction \
                  callback(proxy:b2DynamicTreeNode):Booleanand should return \
                  false to trigger premature termination."
            [ curry_arg "callback" ((callback [] void) @@ arg 0) ;
              curry_arg "aabb" ((abbrv "aabb") @@ arg 1) ] void ;
          map_method "dynamic_tree" "RayCast" ~rename:"dynamic_tree_ray_cast" 
            ~doc:"Ray-cast against the proxies in the tree. This relies on \
                  the callback to perform a exact ray-cast in the case were \
                  the proxy contains a shape. The callback also performs the \
                  any collision filtering. This has performance roughly equal \
                  to k log(n), where k is the number of collisions and n is \
                  the number of proxies in the tree."
            [ curry_arg "callback" ((callback [] void) @@ arg 0) ;
              curry_arg "input" ((abbrv "ray_cast_input") @@ arg 1) ] void ;
          map_method "dynamic_tree" "Rebalance" ~rename:"dynamic_tree_rebalance" 
            ~doc:"Perform some iterations to re-balance the tree."
            [ curry_arg "iterations" (int @@ arg 0) ] void ;
        ] ;
        section "The broad-phase is used for computing pairs and performing volume queries and ray casts." [
          def_type 
            ~doc:"The broad-phase is used for computing pairs and performing \
                  volume queries and ray casts."
            "dynamic_tree_broad_phase" (abstract any) ;
          map_method "dynamic_tree_broad_phase" "CreateProxy" ~rename:"dynamic_tree_broad_phase_create_proxy" 
            ~doc:"Create a proxy with an initial AABB. Pairs are not reported \
                  until UpdatePairs is called."
            [ curry_arg "aabb" ((abbrv "aabb") @@ arg 0) ;
              curry_arg "user_data" (any @@ arg 1) ] 
            any ;
          map_method "dynamic_tree_broad_phase" "DestroyProxy" ~rename:"dynamic_tree_broad_phase_destroy_proxy" 
            ~doc:"Destroy a proxy. It is up to the client to remove any pairs."
            [ curry_arg "proxy" (any @@ arg 0) ] void ;
          map_method "dynamic_tree_broad_phase" "GetFatAABB" ~rename:"dynamic_tree_broad_phase_get_fat_aabb" 
            ~doc:"Get the AABB for a proxy."
            [ curry_arg "proxy" (any @@ arg 0) ] 
            (abbrv "aabb") ;
          map_method "dynamic_tree_broad_phase" "GetProxyCount" ~rename:"dynamic_tree_broad_phase_get_proxy_count" 
            ~doc:"Get the number of proxies."
            [] 
            int ;
          map_method "dynamic_tree_broad_phase" "GetUserData" ~rename:"dynamic_tree_broad_phase_get_user_data" 
            ~doc:"Get user data from a proxy. Returns null if the proxy is \
                  invalid."
            [ curry_arg "proxy" (any @@ arg 0) ] 
            any ;
          map_method "dynamic_tree_broad_phase" "MoveProxy" ~rename:"dynamic_tree_broad_phase_move_proxy" 
            ~doc:"Call MoveProxy as many times as you like, then when you are \
                  done call UpdatePairs to finalized the proxy pairs (for \
                  your time step)."
            [ curry_arg "proxy" (any @@ arg 0) ;
              curry_arg "aabb" ((abbrv "aabb") @@ arg 1) ;
              curry_arg "displacement" ((abbrv "Common.Math.vec2") @@ arg 2) ] void ;
          map_method "dynamic_tree_broad_phase" "Query" ~rename:"dynamic_tree_broad_phase_query" 
            ~doc:"Query an AABB for overlapping proxies. The callback class \
                  is called with each proxy that overlaps the supplied AABB, \
                  and return a Boolean indicating if the broaphase should \
                  proceed to the next match."
            [ curry_arg "callback" ((callback [] void) @@ arg 0) ;
              curry_arg "aabb" ((abbrv "aabb") @@ arg 1) ] void ;
          map_method "dynamic_tree_broad_phase" "RayCast" ~rename:"dynamic_tree_broad_phase_ray_cast" 
            ~doc:"Ray-cast agains the proxies in the tree. This relies on the \
                  callback to perform exact ray-cast in the case where the \
                  proxy contains a shape The callback also performs any \
                  collision filtering"
            [ curry_arg "callback" ((callback [] void) @@ arg 0) ;
              curry_arg "input" ((abbrv "ray_cast_input") @@ arg 1) ] void ;
          map_method "dynamic_tree_broad_phase" "Rebalance" ~rename:"dynamic_tree_broad_phase_rebalance"  [ curry_arg "iterations" (int @@ arg 0) ] void ;
          map_method "dynamic_tree_broad_phase" "TestOverlap" ~rename:"dynamic_tree_broad_phase_test_overlap"  [ curry_arg "proxy_a" (any @@ arg 0) ;
                                                                                                                 curry_arg "proxy_b" (any @@ arg 1) ] 
            bool ;
          map_method "dynamic_tree_broad_phase" "UpdatePairs" ~rename:"dynamic_tree_broad_phase_update_pairs" 
            ~doc:"Update the pairs. This results in pair callbacks. This can \
                  only add pairs."
            [ curry_arg "callback" ((callback [] void) @@ arg 0) ] void ;
          map_method "dynamic_tree_broad_phase" "Validate" ~rename:"dynamic_tree_broad_phase_validate"  [] void ;
        ] ;
        section "Used to warm start b2Distance." [
          def_type 
            ~doc:"Used to warm start b2Distance."
            "simplex_cache" (abstract any) ;
          map_attribute "simplex_cache" "count" ~rename:"simplex_cache_count"  int ;
          map_attribute "simplex_cache" "indexA" ~rename:"simplex_cache_index_a" 
            ~doc:"Vertices on shape a"
            (array any) ;
          map_attribute "simplex_cache" "indexB" ~rename:"simplex_cache_index_b" 
            ~doc:"Vertices on shape b"
            (array any) ;
          map_attribute "simplex_cache" "metric" ~rename:"simplex_cache_metric" 
            ~doc:"Length or area"
            float ;
        ] ;
        section "Inpute parameters for b2TimeOfImpact" [
          def_type 
            ~doc:"Inpute parameters for b2TimeOfImpact"
            "toiinput" (abstract any) ;
          map_attribute "toiinput" "proxyA" ~rename:"toiinput_proxy_a"  (abbrv "distance_proxy") ;
          map_attribute "toiinput" "proxyB" ~rename:"toiinput_proxy_b"  (abbrv "distance_proxy") ;
          map_attribute "toiinput" "sweepA" ~rename:"toiinput_sweep_a"  (abbrv "Common.Math.sweep") ;
          map_attribute "toiinput" "sweepB" ~rename:"toiinput_sweep_b"  (abbrv "Common.Math.sweep") ;
          map_attribute "toiinput" "tolerance" ~rename:"toiinput_tolerance"  float ;
        ] ;
      ] ;
    structure "Dynamics"
      ~doc:""
      [
        section "Types" [
          def_type 
            ~doc:"The world class manages all physics entities, dynamic \
                  simulation, and asynchronous queries."
            "world" (abstract any) ;
          def_type 
            ~doc:"A rigid body."
            "body" (abstract any) ;
          def_type 
            ~doc:"A body definition holds all the data needed to construct a \
                  rigid body."
            "body_def" (abstract any) ;
          def_type 
            ~doc:"A fixture is used to attach a shape to a body for collision \
                  detection."
            "fixture" (abstract any) ;
          def_type 
            ~doc:"A fixture definition is used to create a fixture."
            "fixture_def" (abstract any) ;
        ] ;
        section "This holds contact filtering data." [
          def_type 
            ~doc:"This holds contact filtering data."
            "filter_data" (abstract any) ;
          map_attribute "filter_data" "categoryBits" ~rename:"filter_data_category_bits" 
            ~doc:"The collision category bits. Normally you would just set \
                  one bit."
            int ;
          map_attribute "filter_data" "groupIndex" ~rename:"filter_data_group_index" 
            ~doc:"Collision groups allow a certain group of objects to never \
                  collide (negative) or always collide (positive). Zero means \
                  no collision group. Non-zero group filtering always wins \
                  against the mask bits."
            int ;
          map_attribute "filter_data" "maskBits" ~rename:"filter_data_mask_bits" 
            ~doc:"The collision mask bits. This states the categories that \
                  this shape would accept for collision."
            int ;
          map_method "filter_data" "Copy" ~rename:"filter_data_copy"  [] 
            (abbrv "filter_data") ;
        ] ;
        section "Collision filtering." [
          def_type 
            ~doc:"Implement this class to provide collision filtering."
            "contact_filter" (abstract any) ;
          map_method "contact_filter" "RayCollide" ~rename:"contact_filter_ray_collide" 
            ~doc:"Return true if the given fixture should be considered for \
                  ray intersection. By default, userData is cast as a \
                  b2Fixture and collision is resolved according to \
                  ShouldCollide"
            [ curry_arg "user_data" (any @@ arg 0) ;
              curry_arg "fixture" ((abbrv "fixture") @@ arg 1) ] 
            bool ;
          map_method "contact_filter" "ShouldCollide" ~rename:"contact_filter_should_collide" 
            ~doc:"Return true if contact calculations should be performed \
                  between these two fixtures."
            [ curry_arg "fixture_a" ((abbrv "fixture") @@ arg 0) ;
              curry_arg "fixture_b" ((abbrv "fixture") @@ arg 1) ] 
            bool ;
          structure "Contacts"
            ~doc:""
            [
              section "The class manages contact between two shapes." [
                def_type 
                  ~doc:"The class manages contact between two shapes."
                  "contact" (abstract any) ;
                map_method "contact" "FlagForFiltering" ~rename:"contact_flag_for_filtering" 
                  ~doc:"Flag this contact for filtering. Filtering will occur the \
                        next time step."
                  [] void ;
                map_method "contact" "GetFixtureA" ~rename:"contact_get_fixture_a" 
                  ~doc:"Get the first fixture in this contact."
                  [] 
                  (abbrv "fixture") ;
                map_method "contact" "GetFixtureB" ~rename:"contact_get_fixture_b" 
                  ~doc:"Get the second fixture in this contact."
                  [] 
                  (abbrv "fixture") ;
                map_method "contact" "GetManifold" ~rename:"contact_get_manifold" 
                  ~doc:"Get the contact manifold. Do not modify the manifold unless \
                        you understand the internals of Box2D"
                  [] 
                  (abbrv "Collision.manifold") ;
                map_method "contact" "GetNext" ~rename:"contact_get_next" 
                  ~doc:"Get the next contact in the world's contact list."
                  [] 
                  (abbrv "contact") ;
                map_method "contact" "GetWorldManifold" ~rename:"contact_get_world_manifold" 
                  ~doc:"Get the world manifold"
                  [ curry_arg "world_manifold" ((abbrv "Collision.world_manifold") @@ arg 0) ] void ;
                map_method "contact" "IsContinuous" ~rename:"contact_is_continuous" 
                  ~doc:"Does this contact generate TOI events for continuous \
                        simulation"
                  [] 
                  bool ;
                map_method "contact" "IsEnabled" ~rename:"contact_is_enabled" 
                  ~doc:"Has this contact been disabled?"
                  [] 
                  bool ;
                map_method "contact" "IsSensor" ~rename:"contact_is_sensor" 
                  ~doc:"Is this contact a sensor?"
                  [] 
                  bool ;
                map_method "contact" "IsTouching" ~rename:"contact_is_touching" 
                  ~doc:"Is this contact touching."
                  [] 
                  bool ;
                map_method "contact" "SetEnabled" ~rename:"contact_set_enabled" 
                  ~doc:"Enable/disable this contact. This can be used inside the \
                        pre-solve contact listener. The contact is only disabled \
                        for the current time step (or sub-step in continuous \
                        collision)."
                  [ curry_arg "flag" (bool @@ arg 0) ] void ;
                map_method "contact" "SetSensor" ~rename:"contact_set_sensor" 
                  ~doc:"Change this to be a sensor or-non-sensor contact."
                  [ curry_arg "sensor" (bool @@ arg 0) ] void ;
              ] ;
              section "A contact edge is used to connect bodies and contacts together in a contact graph where each body is a node and each contact is an edge." [
                def_type 
                  ~doc:"A contact edge is used to connect bodies and contacts \
                        together in a contact graph where each body is a node and \
                        each contact is an edge."
                  "contact_edge" (abstract any) ;
                map_attribute "contact_edge" "contact" ~rename:"contact_edge_contact"  (abbrv "contact") ;
                map_attribute "contact_edge" "next" ~rename:"contact_edge_next"  (abbrv "contact_edge") ;
                map_attribute "contact_edge" "other" ~rename:"contact_edge_other"  (abbrv "body") ;
                map_attribute "contact_edge" "prev" ~rename:"contact_edge_prev"  (abbrv "contact_edge") ;
              ] ;
              section "This structure is used to report contact point results." [
                def_type 
                  ~doc:"This structure is used to report contact point results."
                  "contact_result" (abstract any) ;
                map_attribute "contact_result" "id" ~rename:"contact_result_id" 
                  ~doc:"The contact id identifies the features in contact"
                  (abbrv "Collision.contact_id") ;
                map_attribute "contact_result" "normal" ~rename:"contact_result_normal" 
                  ~doc:"Points from shape1 to shape2"
                  (abbrv "Common.Math.vec2") ;
                map_attribute "contact_result" "normalImpulse" ~rename:"contact_result_normal_impulse" 
                  ~doc:"The normal impulse applied to body2"
                  float ;
                map_attribute "contact_result" "position" ~rename:"contact_result_position" 
                  ~doc:"Position in world coordinates"
                  (abbrv "Common.Math.vec2") ;
                map_attribute "contact_result" "shape1" ~rename:"contact_result_shape1" 
                  ~doc:"The first shape"
                  (abbrv "Collision.Shapes.shape") ;
                map_attribute "contact_result" "shape2" ~rename:"contact_result_shape2" 
                  ~doc:"The second shape"
                  (abbrv "Collision.Shapes.shape") ;
                map_attribute "contact_result" "tangentImpulse" ~rename:"contact_result_tangent_impulse" 
                  ~doc:"The tangent impulse applied to body2"
                  float ;
              ] ;
              section "Get contact information." [
                def_type 
                  ~doc:"Implement this class to get contact information."
                  "contact_listener" (abstract any) ;
                def_type 
                  ~doc:"Contact impulses for reporting. Impulses are used instead \
                        of forces because sub-step forces may approach infinity for \
                        rigid body collisions. These match up one-to-one with the \
                        contact points in b2Manifold.."
                  "contact_impulse" (abstract any) ;
                map_method "contact_listener" "BeginContact" ~rename:"contact_listener_begin_contact" 
                  ~doc:"Called when two fixtures begin to touch."
                  [ curry_arg "contact" ((abbrv "contact") @@ arg 0) ] void ;
                map_method "contact_listener" "EndContact" ~rename:"contact_listener_end_contact" 
                  ~doc:"Called when two fixtures cease to touch."
                  [ curry_arg "contact" ((abbrv "contact") @@ arg 0) ] void ;
                map_method "contact_listener" "PostSolve" ~rename:"contact_listener_post_solve" 
                  ~doc:"This lets you inspect a contact after the solver is \
                        finished. This is useful for inspecting impulses. Note: the \
                        contact manifold does not include time of impact impulses, \
                        which can be arbitrarily large if the sub-step is small. \
                        Hence the impulse is provided explicitly in a separate data \
                        structure. Note: this is only called for contacts that are \
                        touching, solid, and awake."
                  [ curry_arg "contact" ((abbrv "contact") @@ arg 0) ;
                    curry_arg "impulse" ((abbrv "contact_impulse") @@ arg 1) ] void ;
                map_method "contact_listener" "PreSolve" ~rename:"contact_listener_pre_solve" 
                  ~doc:"This is called after a contact is updated. This allows you \
                        to inspect a contact before it goes to the solver. If you \
                        are careful, you can modify the contact manifold (e.g. \
                        disable contact). A copy of the old manifold is provided so \
                        that you can detect changes. Note: this is called only for \
                        awake bodies. Note: this is called even when the number of \
                        contact points is zero. Note: this is not called for \
                        sensors. Note: if you set the number of contact points to \
                        zero, you will not get an EndContact callback. However, you \
                        may get a BeginContact callback the next step."
                  [ curry_arg "contact" ((abbrv "contact") @@ arg 0) ;
                    curry_arg "old_manifold" ((abbrv "Collision.manifold") @@ arg 1) ] void ;
              ] ;
            ] ;
          structure "Controllers"
            ~doc:""
            [
              section "Common Types" [
                def_type 
                  ~doc:"Base class for controllers."
                  "controller" (abstract any) ;
                def_type  "controller_edge" (abstract any) ;
                def_type 
                  ~doc:"Time step"
                  "time_step" (public (record [ row "dt" (float @@ field root "dt") ;
                                                row "inv_dt" (float @@ field root "inv_dt") ;
                                                row "iterations" (int @@ field root "iterations") ])) ;
              ] ;
              section "Base class for controllers." [
                map_method "controller" "AddBody" ~rename:"controller_add_body"  [ curry_arg "body" ((abbrv "body") @@ arg 0) ] void ;
                map_method "controller" "Clear" ~rename:"controller_clear"  [] void ;
                map_method "controller" "Draw" ~rename:"controller_draw"  [ curry_arg "debug_draw" ((abbrv "Debug_draw.t") @@ arg 0) ] void ;
                map_method "controller" "GetBodyList" ~rename:"controller_get_body_list"  [] 
                  (abbrv "controller_edge") ;
                map_method "controller" "GetNext" ~rename:"controller_get_next"  [] 
                  (abbrv "controller") ;
                map_method "controller" "GetWorld" ~rename:"controller_get_world"  [] 
                  (abbrv "world") ;
                map_method "controller" "RemoveBody" ~rename:"controller_remove_body"  [ curry_arg "body" ((abbrv "body") @@ arg 0) ] void ;
                map_method "controller" "Step" ~rename:"controller_step"  [ curry_arg "step" ((abbrv "time_step") @@ arg 0) ] void ;
              ] ;
              section "Controller Edges" [
                map_attribute "controller_edge" "body" ~rename:"controller_edge_body" 
                  ~doc:"the body"
                  (abbrv "body") ;
                map_attribute "controller_edge" "controller" ~rename:"controller_edge_controller" 
                  ~doc:"provides quick access to other end of this edge"
                  (abbrv "controller") ;
                map_attribute "controller_edge" "nextBody" ~rename:"controller_edge_next_body" 
                  ~doc:"the next controller edge in the controllers's body list"
                  (abbrv "controller_edge") ;
                map_attribute "controller_edge" "nextController" ~rename:"controller_edge_next_controller" 
                  ~doc:"the next controller edge in the body's controller list"
                  (abbrv "controller_edge") ;
                map_attribute "controller_edge" "prevBody" ~rename:"controller_edge_prev_body" 
                  ~doc:"the previous controller edge in the controllers's body list"
                  (abbrv "controller_edge") ;
                map_attribute "controller_edge" "prevController" ~rename:"controller_edge_prev_controller" 
                  ~doc:"the previous controller edge in the body's controller list"
                  (abbrv "controller_edge") ;
              ] ;
              section "Applies an acceleration every frame, like gravity" [
                def_type 
                  ~doc:"Applies an acceleration every frame, like gravity"
                  "constant_accel_controller" (abstract any) ;
                inherits ([], "constant_accel_controller") ([], "controller") "as_controller" ;
                map_attribute "constant_accel_controller" "A" ~rename:"constant_accel_controller_a" 
                  ~doc:"The acceleration to apply"
                  (abbrv "Common.Math.vec2") ;
              ] ;
              section "Calculates buoyancy forces for fluids in the form of a half plane" [
                def_type 
                  ~doc:"Calculates buoyancy forces for fluids in the form of a half \
                        plane"
                  "buoyancy_controller" (abstract any) ;
                inherits ([], "buoyancy_controller") ([], "controller") "as_controller" ;
                map_attribute "buoyancy_controller" "angularDrag" ~rename:"buoyancy_controller_angular_drag" 
                  ~doc:"Linear drag co-efficient"
                  float ;
                map_attribute "buoyancy_controller" "density" ~rename:"buoyancy_controller_density" 
                  ~doc:"The fluid density"
                  float ;
                map_attribute "buoyancy_controller" "gravity" ~rename:"buoyancy_controller_gravity" 
                  ~doc:"Gravity vector, if the world's gravity is not used"
                  (abbrv "Common.Math.vec2") ;
                map_attribute "buoyancy_controller" "linearDrag" ~rename:"buoyancy_controller_linear_drag" 
                  ~doc:"Linear drag co-efficient"
                  float ;
                map_attribute "buoyancy_controller" "normal" ~rename:"buoyancy_controller_normal" 
                  ~doc:"The outer surface normal"
                  (abbrv "Common.Math.vec2") ;
                map_attribute "buoyancy_controller" "offset" ~rename:"buoyancy_controller_offset" 
                  ~doc:"The height of the fluid surface along the normal"
                  float ;
                map_attribute "buoyancy_controller" "useDensity" ~rename:"buoyancy_controller_use_density" 
                  ~doc:"If false, bodies are assumed to be uniformly dense, \
                        otherwise use the shapes densities"
                  bool ;
                map_attribute "buoyancy_controller" "useWorldGravity" ~rename:"buoyancy_controller_use_world_gravity" 
                  ~doc:"If true, gravity is taken from the world instead of the \
                        gravity parameter."
                  bool ;
                map_attribute "buoyancy_controller" "velocity" ~rename:"buoyancy_controller_velocity" 
                  ~doc:"Fluid velocity, for drag calculations"
                  (abbrv "Common.Math.vec2") ;
              ] ;
              section "Applies top down linear damping to the controlled bodies The damping is calculated by multiplying velocity by a matrix in local co-ordinates." [
                def_type 
                  ~doc:"Applies top down linear damping to the controlled bodies \
                        The damping is calculated by multiplying velocity by a \
                        matrix in local co-ordinates."
                  "tensor_damping_controller" (abstract any) ;
                inherits ([], "tensor_damping_controller") ([], "controller") "as_controller" ;
                map_attribute "tensor_damping_controller" "maxTimestep" ~rename:"tensor_damping_controller_max_timestep" 
                  ~doc:"Set this to a positive number to clamp the maximum amount \
                        of damping done."
                  float ;
                map_attribute "tensor_damping_controller" "T" ~rename:"tensor_damping_controller_t" 
                  ~doc:"Tensor to use in damping model"
                  (abbrv "Common.Math.mat22") ;
                map_method "tensor_damping_controller" "SetAxisAligned" ~rename:"tensor_damping_controller_set_axis_aligned" 
                  ~doc:"Helper function to set T in a common case"
                  [ curry_arg "x_damping" (float @@ arg 0) ;
                    curry_arg "y_damping" (float @@ arg 1) ] void ;
              ] ;
              section "Applies a force every frame" [
                def_type 
                  ~doc:"Applies a force every frame"
                  "constant_force_controller" (abstract any) ;
                inherits ([], "constant_force_controller") ([], "controller") "as_controller" ;
                map_attribute "constant_force_controller" "F" ~rename:"constant_force_controller_f" 
                  ~doc:"The force to apply"
                  (abbrv "Common.Math.vec2") ;
              ] ;
              section "Applies simplified gravity between every pair of bodies" [
                def_type 
                  ~doc:"Applies simplified gravity between every pair of bodies"
                  "gravity_controller" (abstract any) ;
                inherits ([], "gravity_controller") ([], "controller") "as_controller" ;
                map_attribute "gravity_controller" "G" ~rename:"gravity_controller_g" 
                  ~doc:"Specifies the strength of the gravitiation force"
                  float ;
                map_attribute "gravity_controller" "invSqr" ~rename:"gravity_controller_inv_sqr" 
                  ~doc:"If true, gravity is proportional to r^-2, otherwise r^-1"
                  bool ;
              ] ;
            ] ;
          structure "Joints"
            ~doc:"Joints"
            [
              section "The base joint class." [
                def_type 
                  ~doc:"The base joint class."
                  "joint" (abstract any) ;
                map_method "joint" "GetAnchorA" ~rename:"joint_get_anchor_a" 
                  ~doc:"Get the anchor point on bodyA in world coordinates."
                  [] 
                  (abbrv "Common.Math.vec2") ;
                map_method "joint" "GetAnchorB" ~rename:"joint_get_anchor_b" 
                  ~doc:"Get the anchor point on bodyB in world coordinates."
                  [] 
                  (abbrv "Common.Math.vec2") ;
                map_method "joint" "GetBodyA" ~rename:"joint_get_body_a" 
                  ~doc:"Get the first body attached to this joint."
                  [] 
                  (abbrv "body") ;
                map_method "joint" "GetBodyB" ~rename:"joint_get_body_b" 
                  ~doc:"Get the second body attached to this joint."
                  [] 
                  (abbrv "body") ;
                map_method "joint" "GetNext" ~rename:"joint_get_next" 
                  ~doc:"Get the next joint the world joint list."
                  [] 
                  (abbrv "joint") ;
                map_method "joint" "GetReactionForce" ~rename:"joint_get_reaction_force" 
                  ~doc:"Get the reaction force on body2 at the joint anchor in \
                        Newtons."
                  [ curry_arg "inv_dt" (float @@ arg 0) ] 
                  (abbrv "Common.Math.vec2") ;
                map_method "joint" "GetReactionTorque" ~rename:"joint_get_reaction_torque" 
                  ~doc:"Get the reaction torque on body2 in N."
                  [ curry_arg "inv_dt" (float @@ arg 0) ] 
                  float ;
                map_method "joint" "GetType" ~rename:"joint_get_type" 
                  ~doc:"Get the type of the concrete joint."
                  [] 
                  int ;
                map_method "joint" "GetUserData" ~rename:"joint_get_user_data" 
                  ~doc:"Get the user data pointer."
                  [] 
                  any ;
                map_method "joint" "IsActive" ~rename:"joint_is_active" 
                  ~doc:"Short-cut function to determine if either body is inactive."
                  [] 
                  bool ;
                map_method "joint" "SetUserData" ~rename:"joint_set_user_data" 
                  ~doc:"Set the user data pointer."
                  [ curry_arg "data" (any @@ arg 0) ] void ;
              ] ;
              section "Joint definitions are used to construct joints." [
                def_type 
                  ~doc:"Joint definitions are used to construct joints."
                  "joint_def" (abstract any) ;
                map_attribute "joint_def" "bodyA" ~rename:"joint_def_body_a" 
                  ~doc:"The first attached body."
                  (abbrv "body") ;
                map_attribute "joint_def" "bodyB" ~rename:"joint_def_body_b" 
                  ~doc:"The second attached body."
                  (abbrv "body") ;
                map_attribute "joint_def" "collideConnected" ~rename:"joint_def_collide_connected" 
                  ~doc:"Set this flag to true if the attached bodies should collide."
                  bool ;
                map_attribute "joint_def" "type" ~rename:"joint_def_type" 
                  ~doc:"The joint type is set automatically for concrete joint \
                        types."
                  int ;
                map_attribute "joint_def" "userData" ~rename:"joint_def_user_data" 
                  ~doc:"Use this to attach application specific data to your joints."
                  any ;
              ] ;
              section "A gear joint is used to connect two joints together." [
                def_type 
                  ~doc:"A gear joint is used to connect two joints together."
                  "gear_joint" (abstract any) ;
                inherits ([], "gear_joint") ([], "joint") "as_joint" ;
                map_method "gear_joint" "GetRatio" ~rename:"gear_joint_get_ratio" 
                  ~doc:"Get the gear ratio."
                  [] 
                  float ;
                map_method "gear_joint" "SetRatio" ~rename:"gear_joint_set_ratio" 
                  ~doc:"Set the gear ratio."
                  [ curry_arg "ratio" (float @@ arg 0) ] void ;
              ] ;
              section "Line joint definition." [
                def_type 
                  ~doc:"Line joint definition."
                  "line_joint_def" (abstract any) ;
                inherits ([], "line_joint_def") ([], "joint_def") "as_joint_def" ;
                map_attribute "line_joint_def" "enableLimit" ~rename:"line_joint_def_enable_limit" 
                  ~doc:"Enable/disable the joint limit."
                  bool ;
                map_attribute "line_joint_def" "enableMotor" ~rename:"line_joint_def_enable_motor" 
                  ~doc:"Enable/disable the joint motor."
                  bool ;
                map_attribute "line_joint_def" "localAnchorA" ~rename:"line_joint_def_local_anchor_a" 
                  ~doc:"The local anchor point relative to bodyA's origin."
                  (abbrv "Common.Math.vec2") ;
                map_attribute "line_joint_def" "localAnchorB" ~rename:"line_joint_def_local_anchor_b" 
                  ~doc:"The local anchor point relative to bodyB's origin."
                  (abbrv "Common.Math.vec2") ;
                map_attribute "line_joint_def" "localAxisA" ~rename:"line_joint_def_local_axis_a" 
                  ~doc:"The local translation axis in bodyA."
                  (abbrv "Common.Math.vec2") ;
                map_attribute "line_joint_def" "lowerTranslation" ~rename:"line_joint_def_lower_translation" 
                  ~doc:"The lower translation limit, usually in meters."
                  float ;
                map_attribute "line_joint_def" "maxMotorForce" ~rename:"line_joint_def_max_motor_force" 
                  ~doc:"The maximum motor torque, usually in N-m."
                  float ;
                map_attribute "line_joint_def" "motorSpeed" ~rename:"line_joint_def_motor_speed" 
                  ~doc:"The desired motor speed in radians per second."
                  float ;
                map_attribute "line_joint_def" "upperTranslation" ~rename:"line_joint_def_upper_translation" 
                  ~doc:"The upper translation limit, usually in meters."
                  float ;
                map_method "line_joint_def" "Initialize" ~rename:"line_joint_def_initialize"  [ curry_arg "b_a" ((abbrv "body") @@ arg 0) ;
                                                                                                curry_arg "b_b" ((abbrv "body") @@ arg 1) ;
                                                                                                curry_arg "anchor" ((abbrv "Common.Math.vec2") @@ arg 2) ;
                                                                                                curry_arg "axis" ((abbrv "Common.Math.vec2") @@ arg 3) ] void ;
              ] ;
              section "A weld joint essentially glues two bodies together." [
                def_type 
                  ~doc:"A weld joint essentially glues two bodies together."
                  "weld_joint" (abstract any) ;
                inherits ([], "weld_joint") ([], "joint") "as_joint" ;
              ] ;
              section "A joint edge is used to connect bodies and joints together in a joint graph where each body is a node and each joint is an edge." [
                def_type 
                  ~doc:"A joint edge is used to connect bodies and joints together \
                        in a joint graph where each body is a node and each joint \
                        is an edge."
                  "joint_edge" (abstract any) ;
                map_attribute "joint_edge" "joint" ~rename:"joint_edge_joint" 
                  ~doc:"The joint"
                  (abbrv "joint") ;
                map_attribute "joint_edge" "next" ~rename:"joint_edge_next" 
                  ~doc:"The next joint edge in the body's joint list"
                  (abbrv "joint_edge") ;
                map_attribute "joint_edge" "other" ~rename:"joint_edge_other" 
                  ~doc:"Provides quick access to the other body attached."
                  (abbrv "body") ;
                map_attribute "joint_edge" "prev" ~rename:"joint_edge_prev" 
                  ~doc:"The previous joint edge in the body's joint list"
                  (abbrv "joint_edge") ;
              ] ;
              section "A line joint." [
                def_type 
                  ~doc:"A line joint."
                  "line_joint" (abstract any) ;
                inherits ([], "line_joint") ([], "joint") "as_joint" ;
                map_method "line_joint" "EnableLimit" ~rename:"line_joint_enable_limit" 
                  ~doc:"Enable/disable the joint limit."
                  [ curry_arg "flag" (bool @@ arg 0) ] void ;
                map_method "line_joint" "EnableMotor" ~rename:"line_joint_enable_motor" 
                  ~doc:"Enable/disable the joint motor."
                  [ curry_arg "flag" (bool @@ arg 0) ] void ;
                map_method "line_joint" "GetJointSpeed" ~rename:"line_joint_get_joint_speed" 
                  ~doc:"Get the current joint translation speed, usually in meters \
                        per second."
                  [] 
                  float ;
                map_method "line_joint" "GetJointTranslation" ~rename:"line_joint_get_joint_translation" 
                  ~doc:"Get the current joint translation, usually in meters."
                  [] 
                  float ;
                map_method "line_joint" "GetLowerLimit" ~rename:"line_joint_get_lower_limit" 
                  ~doc:"Get the lower joint limit, usually in meters."
                  [] 
                  float ;
                map_method "line_joint" "GetMaxMotorForce" ~rename:"line_joint_get_max_motor_force" 
                  ~doc:"Get the maximum motor force, usually in N."
                  [] 
                  float ;
                map_method "line_joint" "GetMotorForce" ~rename:"line_joint_get_motor_force" 
                  ~doc:"Get the current motor force, usually in N."
                  [] 
                  float ;
                map_method "line_joint" "GetMotorSpeed" ~rename:"line_joint_get_motor_speed" 
                  ~doc:"Get the motor speed, usually in meters per second."
                  [] 
                  float ;
                map_method "line_joint" "GetUpperLimit" ~rename:"line_joint_get_upper_limit" 
                  ~doc:"Get the upper joint limit, usually in meters."
                  [] 
                  float ;
                map_method "line_joint" "IsLimitEnabled" ~rename:"line_joint_is_limit_enabled" 
                  ~doc:"Is the joint limit enabled?"
                  [] 
                  bool ;
                map_method "line_joint" "IsMotorEnabled" ~rename:"line_joint_is_motor_enabled" 
                  ~doc:"Is the joint motor enabled?"
                  [] 
                  bool ;
                map_method "line_joint" "SetLimits" ~rename:"line_joint_set_limits" 
                  ~doc:"Set the joint limits, usually in meters."
                  [ curry_arg "lower" (float @@ arg 0) ;
                    curry_arg "upper" (float @@ arg 1) ] void ;
                map_method "line_joint" "SetMaxMotorForce" ~rename:"line_joint_set_max_motor_force" 
                  ~doc:"Set the maximum motor force, usually in N."
                  [ curry_arg "force" (float @@ arg 0) ] void ;
                map_method "line_joint" "SetMotorSpeed" ~rename:"line_joint_set_motor_speed" 
                  ~doc:"Set the motor speed, usually in meters per second."
                  [ curry_arg "speed" (float @@ arg 0) ] void ;
              ] ;
              section "Mouse joint definition." [
                def_type 
                  ~doc:"Mouse joint definition."
                  "mouse_joint_def" (abstract any) ;
                inherits ([], "mouse_joint_def") ([], "joint_def") "as_joint_def" ;
                map_attribute "mouse_joint_def" "dampingRatio" ~rename:"mouse_joint_def_damping_ratio" 
                  ~doc:"The damping ratio. 0 = no damping, 1 = critical damping."
                  float ;
                map_attribute "mouse_joint_def" "frequencyHz" ~rename:"mouse_joint_def_frequency_hz" 
                  ~doc:"The response speed."
                  float ;
                map_attribute "mouse_joint_def" "maxForce" ~rename:"mouse_joint_def_max_force" 
                  ~doc:"The maximum constraint force that can be exerted to move \
                        the candidate body. Usually you will express as some \
                        multiple of the weight (multiplier mass gravity)."
                  float ;
                map_attribute "mouse_joint_def" "target" ~rename:"mouse_joint_def_target" 
                  ~doc:"The initial world target point. This is assumed to coincide \
                        with the body anchor initially."
                  (abbrv "Common.Math.vec2") ;
              ] ;
              section "Friction joint defintion" [
                def_type 
                  ~doc:"Friction joint defintion"
                  "friction_joint_def" (abstract any) ;
                inherits ([], "friction_joint_def") ([], "joint_def") "as_joint_def" ;
                map_attribute "friction_joint_def" "localAnchorA" ~rename:"friction_joint_def_local_anchor_a" 
                  ~doc:"The local anchor point relative to bodyA's origin."
                  (abbrv "Common.Math.vec2") ;
                map_attribute "friction_joint_def" "localAnchorB" ~rename:"friction_joint_def_local_anchor_b" 
                  ~doc:"The local anchor point relative to bodyB's origin."
                  (abbrv "Common.Math.vec2") ;
                map_attribute "friction_joint_def" "maxForce" ~rename:"friction_joint_def_max_force" 
                  ~doc:"The maximun force in N."
                  float ;
                map_attribute "friction_joint_def" "maxTorque" ~rename:"friction_joint_def_max_torque" 
                  ~doc:"The maximun friction torque in N-m"
                  float ;
                map_method "friction_joint_def" "Initialize" ~rename:"friction_joint_def_initialize" 
                  ~doc:"Initialize the bodies, anchors, axis, and reference angle \
                        using the world anchor and world axis."
                  [ curry_arg "b_a" ((abbrv "body") @@ arg 0) ;
                    curry_arg "b_b" ((abbrv "body") @@ arg 1) ;
                    curry_arg "anchor" ((abbrv "Common.Math.vec2") @@ arg 2) ] void ;
              ] ;
              section "A distance joint constrains two points on two bodies to remain at a fixed distance from each other." [
                def_type 
                  ~doc:"A distance joint constrains two points on two bodies to \
                        remain at a fixed distance from each other."
                  "distance_joint" (abstract any) ;
                inherits ([], "distance_joint") ([], "joint") "as_joint" ;
                map_method "distance_joint" "GetDampingRatio" ~rename:"distance_joint_get_damping_ratio"  [] 
                  float ;
                map_method "distance_joint" "GetFrequency" ~rename:"distance_joint_get_frequency"  [] 
                  float ;
                map_method "distance_joint" "GetLength" ~rename:"distance_joint_get_length"  [] 
                  float ;
                map_method "distance_joint" "SetDampingRatio" ~rename:"distance_joint_set_damping_ratio"  [ curry_arg "ratio" (float @@ arg 0) ] void ;
                map_method "distance_joint" "SetFrequency" ~rename:"distance_joint_set_frequency"  [ curry_arg "hz" (float @@ arg 0) ] void ;
                map_method "distance_joint" "SetLength" ~rename:"distance_joint_set_length"  [ curry_arg "length" (float @@ arg 0) ] void ;
              ] ;
              section "Pulley joint definition." [
                def_type 
                  ~doc:"Pulley joint definition."
                  "pulley_joint_def" (abstract any) ;
                inherits ([], "pulley_joint_def") ([], "joint_def") "as_joint_def" ;
                map_attribute "pulley_joint_def" "groundAnchorA" ~rename:"pulley_joint_def_ground_anchor_a" 
                  ~doc:"The first ground anchor in world coordinates. This point \
                        never moves."
                  (abbrv "Common.Math.vec2") ;
                map_attribute "pulley_joint_def" "groundAnchorB" ~rename:"pulley_joint_def_ground_anchor_b" 
                  ~doc:"The second ground anchor in world coordinates. This point \
                        never moves."
                  (abbrv "Common.Math.vec2") ;
                map_attribute "pulley_joint_def" "lengthA" ~rename:"pulley_joint_def_length_a" 
                  ~doc:"The a reference length for the segment attached to bodyA."
                  float ;
                map_attribute "pulley_joint_def" "lengthB" ~rename:"pulley_joint_def_length_b" 
                  ~doc:"The a reference length for the segment attached to bodyB."
                  float ;
                map_attribute "pulley_joint_def" "localAnchorA" ~rename:"pulley_joint_def_local_anchor_a" 
                  ~doc:"The local anchor point relative to bodyA's origin."
                  (abbrv "Common.Math.vec2") ;
                map_attribute "pulley_joint_def" "localAnchorB" ~rename:"pulley_joint_def_local_anchor_b" 
                  ~doc:"The local anchor point relative to bodyB's origin."
                  (abbrv "Common.Math.vec2") ;
                map_attribute "pulley_joint_def" "maxLengthA" ~rename:"pulley_joint_def_max_length_a" 
                  ~doc:"The maximum length of the segment attached to bodyA."
                  float ;
                map_attribute "pulley_joint_def" "maxLengthB" ~rename:"pulley_joint_def_max_length_b" 
                  ~doc:"The maximum length of the segment attached to bodyB."
                  float ;
                map_attribute "pulley_joint_def" "ratio" ~rename:"pulley_joint_def_ratio" 
                  ~doc:"The pulley ratio, used to simulate a block-and-tackle."
                  float ;
                map_method "pulley_joint_def" "Initialize" ~rename:"pulley_joint_def_initialize"  [ curry_arg "b_a" ((abbrv "body") @@ arg 0) ;
                                                                                                    curry_arg "b_b" ((abbrv "body") @@ arg 1) ;
                                                                                                    curry_arg "ga_a" ((abbrv "Common.Math.vec2") @@ arg 2) ;
                                                                                                    curry_arg "ga_b" ((abbrv "Common.Math.vec2") @@ arg 3) ;
                                                                                                    curry_arg "anchor_a" ((abbrv "Common.Math.vec2") @@ arg 4) ;
                                                                                                    curry_arg "anchor_b" ((abbrv "Common.Math.vec2") @@ arg 5) ;
                                                                                                    curry_arg "r" (float @@ arg 6) ] void ;
              ] ;
              section "Prismatic joint definition." [
                def_type 
                  ~doc:"Prismatic joint definition."
                  "prismatic_joint_def" (abstract any) ;
                inherits ([], "prismatic_joint_def") ([], "joint_def") "as_joint_def" ;
                map_attribute "prismatic_joint_def" "enableLimit" ~rename:"prismatic_joint_def_enable_limit" 
                  ~doc:"Enable/disable the joint limit."
                  bool ;
                map_attribute "prismatic_joint_def" "enableMotor" ~rename:"prismatic_joint_def_enable_motor" 
                  ~doc:"Enable/disable the joint motor."
                  bool ;
                map_attribute "prismatic_joint_def" "localAnchorA" ~rename:"prismatic_joint_def_local_anchor_a" 
                  ~doc:"The local anchor point relative to bodyA's origin."
                  (abbrv "Common.Math.vec2") ;
                map_attribute "prismatic_joint_def" "localAnchorB" ~rename:"prismatic_joint_def_local_anchor_b" 
                  ~doc:"The local anchor point relative to bodyB's origin."
                  (abbrv "Common.Math.vec2") ;
                map_attribute "prismatic_joint_def" "localAxisA" ~rename:"prismatic_joint_def_local_axis_a" 
                  ~doc:"The local translation axis in body1."
                  (abbrv "Common.Math.vec2") ;
                map_attribute "prismatic_joint_def" "lowerTranslation" ~rename:"prismatic_joint_def_lower_translation" 
                  ~doc:"The lower translation limit, usually in meters."
                  float ;
                map_attribute "prismatic_joint_def" "maxMotorForce" ~rename:"prismatic_joint_def_max_motor_force" 
                  ~doc:"The maximum motor torque, usually in N-m."
                  float ;
                map_attribute "prismatic_joint_def" "motorSpeed" ~rename:"prismatic_joint_def_motor_speed" 
                  ~doc:"The desired motor speed in radians per second."
                  float ;
                map_attribute "prismatic_joint_def" "referenceAngle" ~rename:"prismatic_joint_def_reference_angle" 
                  ~doc:"The constrained angle between the bodies: bodyB_angle - \
                        bodyA_angle."
                  float ;
                map_attribute "prismatic_joint_def" "upperTranslation" ~rename:"prismatic_joint_def_upper_translation" 
                  ~doc:"The upper translation limit, usually in meters."
                  float ;
                map_method "prismatic_joint_def" "Initialize" ~rename:"prismatic_joint_def_initialize"  [ curry_arg "b_a" ((abbrv "body") @@ arg 0) ;
                                                                                                          curry_arg "b_b" ((abbrv "body") @@ arg 1) ;
                                                                                                          curry_arg "anchor" ((abbrv "Common.Math.vec2") @@ arg 2) ;
                                                                                                          curry_arg "axis" ((abbrv "Common.Math.vec2") @@ arg 3) ] void ;
              ] ;
              section "A prismatic joint." [
                def_type 
                  ~doc:"A prismatic joint."
                  "prismatic_joint" (abstract any) ;
                inherits ([], "prismatic_joint") ([], "joint") "as_joint" ;
                map_method "prismatic_joint" "EnableLimit" ~rename:"prismatic_joint_enable_limit" 
                  ~doc:"Enable/disable the joint limit."
                  [ curry_arg "flag" (bool @@ arg 0) ] void ;
                map_method "prismatic_joint" "EnableMotor" ~rename:"prismatic_joint_enable_motor" 
                  ~doc:"Enable/disable the joint motor."
                  [ curry_arg "flag" (bool @@ arg 0) ] void ;
                map_method "prismatic_joint" "GetJointSpeed" ~rename:"prismatic_joint_get_joint_speed" 
                  ~doc:"Get the current joint translation speed, usually in meters \
                        per second."
                  [] 
                  float ;
                map_method "prismatic_joint" "GetJointTranslation" ~rename:"prismatic_joint_get_joint_translation" 
                  ~doc:"Get the current joint translation, usually in meters."
                  [] 
                  float ;
                map_method "prismatic_joint" "GetLowerLimit" ~rename:"prismatic_joint_get_lower_limit" 
                  ~doc:"Get the lower joint limit, usually in meters."
                  [] 
                  float ;
                map_method "prismatic_joint" "GetMotorForce" ~rename:"prismatic_joint_get_motor_force" 
                  ~doc:"Get the current motor force, usually in N."
                  [] 
                  float ;
                map_method "prismatic_joint" "GetMotorSpeed" ~rename:"prismatic_joint_get_motor_speed" 
                  ~doc:"Get the motor speed, usually in meters per second."
                  [] 
                  float ;
                map_method "prismatic_joint" "GetUpperLimit" ~rename:"prismatic_joint_get_upper_limit" 
                  ~doc:"Get the upper joint limit, usually in meters."
                  [] 
                  float ;
                map_method "prismatic_joint" "IsLimitEnabled" ~rename:"prismatic_joint_is_limit_enabled" 
                  ~doc:"Is the joint limit enabled?"
                  [] 
                  bool ;
                map_method "prismatic_joint" "IsMotorEnabled" ~rename:"prismatic_joint_is_motor_enabled" 
                  ~doc:"Is the joint motor enabled?"
                  [] 
                  bool ;
                map_method "prismatic_joint" "SetLimits" ~rename:"prismatic_joint_set_limits" 
                  ~doc:"Set the joint limits, usually in meters."
                  [ curry_arg "lower" (float @@ arg 0) ;
                    curry_arg "upper" (float @@ arg 1) ] void ;
                map_method "prismatic_joint" "SetMaxMotorForce" ~rename:"prismatic_joint_set_max_motor_force" 
                  ~doc:"Set the maximum motor force, usually in N."
                  [ curry_arg "force" (float @@ arg 0) ] void ;
                map_method "prismatic_joint" "SetMotorSpeed" ~rename:"prismatic_joint_set_motor_speed" 
                  ~doc:"Set the motor speed, usually in meters per second."
                  [ curry_arg "speed" (float @@ arg 0) ] void ;
              ] ;
              section "Friction joint." [
                def_type 
                  ~doc:"Friction joint."
                  "friction_joint" (abstract any) ;
                inherits ([], "friction_joint") ([], "joint") "as_joint" ;
                map_attribute "friction_joint" "m_angularMass" ~rename:"friction_joint_m_angular_mass"  float ;
                map_attribute "friction_joint" "m_linearMass" ~rename:"friction_joint_m_linear_mass"  (abbrv "Common.Math.mat22") ;
                map_method "friction_joint" "GetMaxForce" ~rename:"friction_joint_get_max_force"  [] 
                  float ;
                map_method "friction_joint" "GetMaxTorque" ~rename:"friction_joint_get_max_torque"  [] 
                  float ;
                map_method "friction_joint" "SetMaxForce" ~rename:"friction_joint_set_max_force"  [ curry_arg "force" (float @@ arg 0) ] void ;
                map_method "friction_joint" "SetMaxTorque" ~rename:"friction_joint_set_max_torque"  [ curry_arg "torque" (float @@ arg 0) ] void ;
              ] ;
              section "Distance joint definition." [
                def_type 
                  ~doc:"Distance joint definition."
                  "distance_joint_def" (abstract any) ;
                inherits ([], "distance_joint_def") ([], "joint_def") "as_joint_def" ;
                map_attribute "distance_joint_def" "dampingRatio" ~rename:"distance_joint_def_damping_ratio" 
                  ~doc:"The damping ratio. 0 = no damping, 1 = critical damping."
                  float ;
                map_attribute "distance_joint_def" "frequencyHz" ~rename:"distance_joint_def_frequency_hz" 
                  ~doc:"The mass-spring-damper frequency in Hertz."
                  float ;
                map_attribute "distance_joint_def" "length" ~rename:"distance_joint_def_length" 
                  ~doc:"The natural length between the anchor points."
                  float ;
                map_attribute "distance_joint_def" "localAnchorA" ~rename:"distance_joint_def_local_anchor_a" 
                  ~doc:"The local anchor point relative to body1's origin."
                  (abbrv "Common.Math.vec2") ;
                map_attribute "distance_joint_def" "localAnchorB" ~rename:"distance_joint_def_local_anchor_b" 
                  ~doc:"The local anchor point relative to body2's origin."
                  (abbrv "Common.Math.vec2") ;
                map_method "distance_joint_def" "Initialize" ~rename:"distance_joint_def_initialize" 
                  ~doc:"Initialize the bodies, anchors, and length using the world \
                        anchors."
                  [ curry_arg "b_a" ((abbrv "body") @@ arg 0) ;
                    curry_arg "b_b" ((abbrv "body") @@ arg 1) ;
                    curry_arg "anchor_a" ((abbrv "Common.Math.vec2") @@ arg 2) ;
                    curry_arg "anchor_b" ((abbrv "Common.Math.vec2") @@ arg 3) ] void ;
              ] ;
              section "Revolute joint definition." [
                def_type 
                  ~doc:"Revolute joint definition."
                  "revolute_joint_def" (abstract any) ;
                inherits ([], "revolute_joint_def") ([], "joint_def") "as_joint_def" ;
                map_attribute "revolute_joint_def" "enableLimit" ~rename:"revolute_joint_def_enable_limit" 
                  ~doc:"A flag to enable joint limits."
                  bool ;
                map_attribute "revolute_joint_def" "enableMotor" ~rename:"revolute_joint_def_enable_motor" 
                  ~doc:"A flag to enable the joint motor."
                  bool ;
                map_attribute "revolute_joint_def" "localAnchorA" ~rename:"revolute_joint_def_local_anchor_a" 
                  ~doc:"The local anchor point relative to bodyA's origin."
                  (abbrv "Common.Math.vec2") ;
                map_attribute "revolute_joint_def" "localAnchorB" ~rename:"revolute_joint_def_local_anchor_b" 
                  ~doc:"The local anchor point relative to bodyB's origin."
                  (abbrv "Common.Math.vec2") ;
                map_attribute "revolute_joint_def" "lowerAngle" ~rename:"revolute_joint_def_lower_angle" 
                  ~doc:"The lower angle for the joint limit (radians)."
                  float ;
                map_attribute "revolute_joint_def" "maxMotorTorque" ~rename:"revolute_joint_def_max_motor_torque" 
                  ~doc:"The maximum motor torque used to achieve the desired motor \
                        speed. Usually in N-m."
                  float ;
                map_attribute "revolute_joint_def" "motorSpeed" ~rename:"revolute_joint_def_motor_speed" 
                  ~doc:"The desired motor speed. Usually in radians per second."
                  float ;
                map_attribute "revolute_joint_def" "referenceAngle" ~rename:"revolute_joint_def_reference_angle" 
                  ~doc:"The bodyB angle minus bodyA angle in the reference state \
                        (radians)."
                  float ;
                map_attribute "revolute_joint_def" "upperAngle" ~rename:"revolute_joint_def_upper_angle" 
                  ~doc:"The upper angle for the joint limit (radians)."
                  float ;
                map_method "revolute_joint_def" "Initialize" ~rename:"revolute_joint_def_initialize" 
                  ~doc:"Initialize the bodies, anchors, and reference angle using \
                        the world anchor."
                  [ curry_arg "b_a" ((abbrv "body") @@ arg 0) ;
                    curry_arg "b_b" ((abbrv "body") @@ arg 1) ;
                    curry_arg "anchor" ((abbrv "Common.Math.vec2") @@ arg 2) ] void ;
              ] ;
              section "Gear joint definition." [
                def_type 
                  ~doc:"Gear joint definition."
                  "gear_joint_def" (abstract any) ;
                inherits ([], "gear_joint_def") ([], "joint_def") "as_joint_def" ;
                map_attribute "gear_joint_def" "joint1" ~rename:"gear_joint_def_joint1" 
                  ~doc:"The first revolute/prismatic joint attached to the gear \
                        joint."
                  (abbrv "joint") ;
                map_attribute "gear_joint_def" "joint2" ~rename:"gear_joint_def_joint2" 
                  ~doc:"The second revolute/prismatic joint attached to the gear \
                        joint."
                  (abbrv "joint") ;
                map_attribute "gear_joint_def" "ratio" ~rename:"gear_joint_def_ratio" 
                  ~doc:"The gear ratio."
                  float ;
              ] ;
              section "A mouse joint is used to make a point on a body track a specified world point." [
                def_type 
                  ~doc:"A mouse joint is used to make a point on a body track a \
                        specified world point."
                  "mouse_joint" (abstract any) ;
                inherits ([], "mouse_joint") ([], "joint") "as_joint" ;
                map_method "mouse_joint" "GetDampingRatio" ~rename:"mouse_joint_get_damping_ratio"  [] 
                  float ;
                map_method "mouse_joint" "GetFrequency" ~rename:"mouse_joint_get_frequency"  [] 
                  float ;
                map_method "mouse_joint" "GetMaxForce" ~rename:"mouse_joint_get_max_force"  [] 
                  float ;
                map_method "mouse_joint" "GetTarget" ~rename:"mouse_joint_get_target"  [] 
                  (abbrv "Common.Math.vec2") ;
                map_method "mouse_joint" "SetDampingRatio" ~rename:"mouse_joint_set_damping_ratio"  [ curry_arg "ratio" (float @@ arg 0) ] void ;
                map_method "mouse_joint" "SetFrequency" ~rename:"mouse_joint_set_frequency"  [ curry_arg "hz" (float @@ arg 0) ] void ;
                map_method "mouse_joint" "SetMaxForce" ~rename:"mouse_joint_set_max_force"  [ curry_arg "max_force" (float @@ arg 0) ] void ;
                map_method "mouse_joint" "SetTarget" ~rename:"mouse_joint_set_target" 
                  ~doc:"Use this to update the target point."
                  [ curry_arg "target" ((abbrv "Common.Math.vec2") @@ arg 0) ] void ;
              ] ;
              section "A revolute joint constrains to bodies to share a common point while they are free to rotate about the point." [
                def_type 
                  ~doc:"A revolute joint constrains to bodies to share a common \
                        point while they are free to rotate about the point."
                  "revolute_joint" (abstract any) ;
                inherits ([], "revolute_joint") ([], "joint") "as_joint" ;
                map_method "revolute_joint" "EnableLimit" ~rename:"revolute_joint_enable_limit" 
                  ~doc:"Enable/disable the joint limit."
                  [ curry_arg "flag" (bool @@ arg 0) ] void ;
                map_method "revolute_joint" "EnableMotor" ~rename:"revolute_joint_enable_motor" 
                  ~doc:"Enable/disable the joint motor."
                  [ curry_arg "flag" (bool @@ arg 0) ] void ;
                map_method "revolute_joint" "GetJointAngle" ~rename:"revolute_joint_get_joint_angle" 
                  ~doc:"Get the current joint angle in radians."
                  [] 
                  float ;
                map_method "revolute_joint" "GetJointSpeed" ~rename:"revolute_joint_get_joint_speed" 
                  ~doc:"Get the current joint angle speed in radians per second."
                  [] 
                  float ;
                map_method "revolute_joint" "GetLowerLimit" ~rename:"revolute_joint_get_lower_limit" 
                  ~doc:"Get the lower joint limit in radians."
                  [] 
                  float ;
                map_method "revolute_joint" "GetMotorSpeed" ~rename:"revolute_joint_get_motor_speed" 
                  ~doc:"Get the motor speed in radians per second."
                  [] 
                  float ;
                map_method "revolute_joint" "GetMotorTorque" ~rename:"revolute_joint_get_motor_torque" 
                  ~doc:"Get the current motor torque, usually in N-m."
                  [] 
                  float ;
                map_method "revolute_joint" "GetUpperLimit" ~rename:"revolute_joint_get_upper_limit" 
                  ~doc:"Get the upper joint limit in radians."
                  [] 
                  float ;
                map_method "revolute_joint" "IsLimitEnabled" ~rename:"revolute_joint_is_limit_enabled" 
                  ~doc:"Is the joint limit enabled?"
                  [] 
                  bool ;
                map_method "revolute_joint" "IsMotorEnabled" ~rename:"revolute_joint_is_motor_enabled" 
                  ~doc:"Is the joint motor enabled?"
                  [] 
                  bool ;
                map_method "revolute_joint" "SetLimits" ~rename:"revolute_joint_set_limits" 
                  ~doc:"Set the joint limits in radians."
                  [ curry_arg "lower" (float @@ arg 0) ;
                    curry_arg "upper" (float @@ arg 1) ] void ;
                map_method "revolute_joint" "SetMaxMotorTorque" ~rename:"revolute_joint_set_max_motor_torque" 
                  ~doc:"Set the maximum motor torque, usually in N-m."
                  [ curry_arg "torque" (float @@ arg 0) ] void ;
                map_method "revolute_joint" "SetMotorSpeed" ~rename:"revolute_joint_set_motor_speed" 
                  ~doc:"Set the motor speed in radians per second."
                  [ curry_arg "speed" (float @@ arg 0) ] void ;
              ] ;
              section "Weld joint definition." [
                def_type 
                  ~doc:"Weld joint definition."
                  "weld_joint_def" (abstract any) ;
                inherits ([], "weld_joint_def") ([], "joint_def") "as_joint_def" ;
                map_attribute "weld_joint_def" "localAnchorA" ~rename:"weld_joint_def_local_anchor_a" 
                  ~doc:"The local anchor point relative to bodyA's origin."
                  (abbrv "Common.Math.vec2") ;
                map_attribute "weld_joint_def" "localAnchorB" ~rename:"weld_joint_def_local_anchor_b" 
                  ~doc:"The local anchor point relative to bodyB's origin."
                  (abbrv "Common.Math.vec2") ;
                map_attribute "weld_joint_def" "referenceAngle" ~rename:"weld_joint_def_reference_angle" 
                  ~doc:"The body2 angle minus body1 angle in the reference state \
                        (radians)."
                  float ;
                map_method "weld_joint_def" "Initialize" ~rename:"weld_joint_def_initialize" 
                  ~doc:"Initialize the bodies, anchors, axis, and reference angle \
                        using the world anchor and world axis."
                  [ curry_arg "b_a" ((abbrv "body") @@ arg 0) ;
                    curry_arg "b_b" ((abbrv "body") @@ arg 1) ;
                    curry_arg "anchor" ((abbrv "Common.Math.vec2") @@ arg 2) ] void ;
              ] ;
              section "The pulley joint is connected to two bodies and two fixed ground points." [
                def_type 
                  ~doc:"The pulley joint is connected to two bodies and two fixed \
                        ground points."
                  "pulley_joint" (abstract any) ;
                inherits ([], "pulley_joint") ([], "joint") "as_joint" ;
                map_method "pulley_joint" "GetGroundAnchorA" ~rename:"pulley_joint_get_ground_anchor_a" 
                  ~doc:"Get the first ground anchor."
                  [] 
                  (abbrv "Common.Math.vec2") ;
                map_method "pulley_joint" "GetGroundAnchorB" ~rename:"pulley_joint_get_ground_anchor_b" 
                  ~doc:"Get the second ground anchor."
                  [] 
                  (abbrv "Common.Math.vec2") ;
                map_method "pulley_joint" "GetLength1" ~rename:"pulley_joint_get_length1" 
                  ~doc:"Get the current length of the segment attached to body1."
                  [] 
                  float ;
                map_method "pulley_joint" "GetLength2" ~rename:"pulley_joint_get_length2" 
                  ~doc:"Get the current length of the segment attached to body2."
                  [] 
                  float ;
                map_method "pulley_joint" "GetRatio" ~rename:"pulley_joint_get_ratio" 
                  ~doc:"Get the pulley ratio."
                  [] 
                  float ;
              ] ;
            ] ;
        ] ;
        section "Joints and shapes are destroyed when their associated body is destroyed." [
          def_type 
            ~doc:"Joints and shapes are destroyed when their associated body \
                  is destroyed."
            "destruction_listener" (abstract any) ;
          map_method "destruction_listener" "SayGoodbyeFixture" ~rename:"destruction_listener_say_goodbye_fixture" 
            ~doc:"Called when any fixture is about to be destroyed due to the \
                  destruction of its parent body."
            [ curry_arg "fixture" ((abbrv "fixture") @@ arg 0) ] void ;
          map_method "destruction_listener" "SayGoodbyeJoint" ~rename:"destruction_listener_say_goodbye_joint" 
            ~doc:"Called when any joint is about to be destroyed due to the \
                  destruction of one of its attached bodies."
            [ curry_arg "joint" ((abbrv "Joints.joint") @@ arg 0) ] void ;
        ] ;
        section "A rigid body." [
          map_global "body_b2_dynamic_body" (int @@ field (field (field (global "Box2D") "Dynamics") "b2Body") "b2_dynamicBody") ;
          map_global "body_b2_kinematic_body" (int @@ field (field (field (global "Box2D") "Dynamics") "b2Body") "b2_kinematicBody") ;
          map_global "body_b2_static_body" (int @@ field (field (field (global "Box2D") "Dynamics") "b2Body") "b2_staticBody") ;
          map_method "body" "ApplyForce" ~rename:"body_apply_force" 
            ~doc:"Apply a force at a world point. If the force is not applied \
                  at the center of mass, it will generate a torque and affect \
                  the angular velocity. This wakes up the body."
            [ curry_arg "force" ((abbrv "Common.Math.vec2") @@ arg 0) ;
              curry_arg "point" ((abbrv "Common.Math.vec2") @@ arg 1) ] void ;
          map_method "body" "ApplyImpulse" ~rename:"body_apply_impulse" 
            ~doc:"Apply an impulse at a point. This immediately modifies the \
                  velocity. It also modifies the angular velocity if the \
                  point of application is not at the center of mass. This \
                  wakes up the body."
            [ curry_arg "impulse" ((abbrv "Common.Math.vec2") @@ arg 0) ;
              curry_arg "point" ((abbrv "Common.Math.vec2") @@ arg 1) ] void ;
          map_method "body" "ApplyTorque" ~rename:"body_apply_torque" 
            ~doc:"Apply a torque. This affects the angular velocity without \
                  affecting the linear velocity of the center of mass. This \
                  wakes up the body."
            [ curry_arg "torque" (float @@ arg 0) ] void ;
          map_method "body" "CreateFixture" ~rename:"body_create_fixture" 
            ~doc:"Creates a fixture and attach it to this body. Use this \
                  function if you need to set some fixture parameters, like \
                  friction. Otherwise you can create the fixture directly \
                  from a shape. If the density is non-zero, this function \
                  automatically updates the mass of the body. Contacts are \
                  not created until the next time step."
            [ curry_arg "def" ((abbrv "fixture_def") @@ arg 0) ] 
            (abbrv "fixture") ;
          map_method "body" "CreateFixture2" ~rename:"body_create_fixture2" 
            ~doc:"Creates a fixture from a shape and attach it to this body. \
                  This is a convenience function. Use b2FixtureDef if you \
                  need to set parameters like friction, restitution, user \
                  data, or filtering. This function automatically updates the \
                  mass of the body."
            [ curry_arg "shape" ((abbrv "Collision.Shapes.shape") @@ arg 0) ;
              curry_arg "density" (float @@ arg 1) ] 
            (abbrv "fixture") ;
          map_method "body" "DestroyFixture" ~rename:"body_destroy_fixture" 
            ~doc:"Destroy a fixture. This removes the fixture from the \
                  broad-phase and destroys all contacts associated with this \
                  fixture. This will automatically adjust the mass of the \
                  body if the body is dynamic and the fixture has positive \
                  density. All fixtures attached to a body are implicitly \
                  destroyed when the body is destroyed."
            [ curry_arg "fixture" ((abbrv "fixture") @@ arg 0) ] void ;
          map_method "body" "GetAngle" ~rename:"body_get_angle" 
            ~doc:"Get the angle in radians."
            [] 
            float ;
          map_method "body" "GetAngularDamping" ~rename:"body_get_angular_damping" 
            ~doc:"Get the angular damping of the body"
            [] 
            float ;
          map_method "body" "GetAngularVelocity" ~rename:"body_get_angular_velocity" 
            ~doc:"Get the angular velocity."
            [] 
            float ;
          map_method "body" "GetContactList" ~rename:"body_get_contact_list" 
            ~doc:"Get a list of all contacts attached to this body."
            [] 
            (abbrv "Contacts.contact_edge") ;
          map_method "body" "GetControllerList" ~rename:"body_get_controller_list" 
            ~doc:"Get the list of all controllers attached to this body."
            [] 
            (abbrv "Controllers.controller_edge") ;
          map_method "body" "GetDefinition" ~rename:"body_get_definition" 
            ~doc:"Get the definition containing the body properties."
            [] 
            (abbrv "body_def") ;
          map_method "body" "GetFixtureList" ~rename:"body_get_fixture_list" 
            ~doc:"Get the list of all fixtures attached to this body."
            [] 
            (abbrv "fixture") ;
          map_method "body" "GetInertia" ~rename:"body_get_inertia" 
            ~doc:"Get the central rotational inertia of the body."
            [] 
            float ;
          map_method "body" "GetJointList" ~rename:"body_get_joint_list" 
            ~doc:"Get the list of all joints attached to this body."
            [] 
            (abbrv "Joints.joint_edge") ;
          map_method "body" "GetLinearDamping" ~rename:"body_get_linear_damping" 
            ~doc:"Get the linear damping of the body."
            [] 
            float ;
          map_method "body" "GetLinearVelocity" ~rename:"body_get_linear_velocity" 
            ~doc:"Get the linear velocity of the center of mass."
            [] 
            (abbrv "Common.Math.vec2") ;
          map_method "body" "GetLinearVelocityFromLocalPoint" ~rename:"body_get_linear_velocity_from_local_point" 
            ~doc:"Get the world velocity of a local point."
            [ curry_arg "local_point" ((abbrv "Common.Math.vec2") @@ arg 0) ] 
            (abbrv "Common.Math.vec2") ;
          map_method "body" "GetLinearVelocityFromWorldPoint" ~rename:"body_get_linear_velocity_from_world_point" 
            ~doc:"Get the world linear velocity of a world point attached to \
                  this body."
            [ curry_arg "world_point" ((abbrv "Common.Math.vec2") @@ arg 0) ] 
            (abbrv "Common.Math.vec2") ;
          map_method "body" "GetLocalCenter" ~rename:"body_get_local_center" 
            ~doc:"Get the local position of the center of mass."
            [] 
            (abbrv "Common.Math.vec2") ;
          map_method "body" "GetLocalPoint" ~rename:"body_get_local_point" 
            ~doc:"Gets a local point relative to the body's origin given a \
                  world point."
            [ curry_arg "world_point" ((abbrv "Common.Math.vec2") @@ arg 0) ] 
            (abbrv "Common.Math.vec2") ;
          map_method "body" "GetLocalVector" ~rename:"body_get_local_vector" 
            ~doc:"Gets a local vector given a world vector."
            [ curry_arg "world_vector" ((abbrv "Common.Math.vec2") @@ arg 0) ] 
            (abbrv "Common.Math.vec2") ;
          map_method "body" "GetMass" ~rename:"body_get_mass" 
            ~doc:"Get the total mass of the body."
            [] 
            float ;
          map_method "body" "GetMassData" ~rename:"body_get_mass_data" 
            ~doc:"Get the mass data of the body. The rotational inertial is \
                  relative to the center of mass."
            [ curry_arg "data" ((abbrv "Collision.Shapes.mass_data") @@ arg 0) ] void ;
          map_method "body" "GetNext" ~rename:"body_get_next" 
            ~doc:"Get the next body in the world's body list."
            [] 
            (abbrv "body") ;
          map_method "body" "GetPosition" ~rename:"body_get_position" 
            ~doc:"Get the world body origin position."
            [] 
            (abbrv "Common.Math.vec2") ;
          map_method "body" "GetTransform" ~rename:"body_get_transform" 
            ~doc:"Get the body transform for the body's origin."
            [] 
            (abbrv "Common.Math.transform") ;
          map_method "body" "GetType" ~rename:"body_get_type" 
            ~doc:"Get the type of this body."
            [] 
            int ;
          map_method "body" "GetUserData" ~rename:"body_get_user_data" 
            ~doc:"Get the user data pointer that was provided in the body \
                  definition."
            [] 
            any ;
          map_method "body" "GetWorld" ~rename:"body_get_world" 
            ~doc:"Get the parent world of this body."
            [] 
            (abbrv "world") ;
          map_method "body" "GetWorldCenter" ~rename:"body_get_world_center" 
            ~doc:"Get the world position of the center of mass."
            [] 
            (abbrv "Common.Math.vec2") ;
          map_method "body" "GetWorldPoint" ~rename:"body_get_world_point" 
            ~doc:"Get the world coordinates of a point given the local \
                  coordinates."
            [ curry_arg "local_point" ((abbrv "Common.Math.vec2") @@ arg 0) ] 
            (abbrv "Common.Math.vec2") ;
          map_method "body" "GetWorldVector" ~rename:"body_get_world_vector" 
            ~doc:"Get the world coordinates of a vector given the local \
                  coordinates."
            [ curry_arg "local_vector" ((abbrv "Common.Math.vec2") @@ arg 0) ] 
            (abbrv "Common.Math.vec2") ;
          map_method "body" "IsActive" ~rename:"body_is_active" 
            ~doc:"Get the active state of the body."
            [] 
            bool ;
          map_method "body" "IsAwake" ~rename:"body_is_awake" 
            ~doc:"Get the sleeping state of this body."
            [] 
            bool ;
          map_method "body" "IsBullet" ~rename:"body_is_bullet" 
            ~doc:"Is this body treated like a bullet for continuous collision \
                  detection?"
            [] 
            bool ;
          map_method "body" "IsFixedRotation" ~rename:"body_is_fixed_rotation" 
            ~doc:"Does this body have fixed rotation?"
            [] 
            bool ;
          map_method "body" "IsSleepingAllowed" ~rename:"body_is_sleeping_allowed" 
            ~doc:"Is this body allowed to sleep?"
            [] 
            bool ;
          map_method "body" "Merge" ~rename:"body_merge" 
            ~doc:"Merges another body into this. Only fixtures, mass and \
                  velocity are effected, Other properties are ignored"
            [ curry_arg "other" ((abbrv "body") @@ arg 0) ] void ;
          map_method "body" "ResetMassData" ~rename:"body_reset_mass_data" 
            ~doc:"This resets the mass properties to the sum of the mass \
                  properties of the fixtures. This normally does not need to \
                  be called unless you called SetMassData to override the \
                  mass and later you want to reset the mass."
            [] void ;
          map_method "body" "SetActive" ~rename:"body_set_active" 
            ~doc:"Set the active state of the body. An inactive body is not \
                  simulated and cannot be collided with or woken up. If you \
                  pass a flag of true, all fixtures will be added to the \
                  broad-phase. If you pass a flag of false, all fixtures will \
                  be removed from the broad-phase and all contacts will be \
                  destroyed. Fixtures and joints are otherwise unaffected. \
                  You may continue to create/destroy fixtures and joints on \
                  inactive bodies. Fixtures on an inactive body are \
                  implicitly inactive and will not participate in collisions, \
                  ray-casts, or queries. Joints connected to an inactive body \
                  are implicitly inactive. An inactive body is still owned by \
                  a b2World object and remains in the body list."
            [ curry_arg "flag" (bool @@ arg 0) ] void ;
          map_method "body" "SetAngle" ~rename:"body_set_angle" 
            ~doc:"Set the world body angle"
            [ curry_arg "angle" (float @@ arg 0) ] void ;
          map_method "body" "SetAngularDamping" ~rename:"body_set_angular_damping" 
            ~doc:"Set the angular damping of the body."
            [ curry_arg "angular_damping" (float @@ arg 0) ] void ;
          map_method "body" "SetAngularVelocity" ~rename:"body_set_angular_velocity" 
            ~doc:"Set the angular velocity."
            [ curry_arg "omega" (float @@ arg 0) ] void ;
          map_method "body" "SetAwake" ~rename:"body_set_awake" 
            ~doc:"Set the sleep state of the body. A sleeping body has vety \
                  low CPU cost."
            [ curry_arg "flag" (bool @@ arg 0) ] void ;
          map_method "body" "SetBullet" ~rename:"body_set_bullet" 
            ~doc:"Should this body be treated like a bullet for continuous \
                  collision detection?"
            [ curry_arg "flag" (bool @@ arg 0) ] void ;
          map_method "body" "SetFixedRotation" ~rename:"body_set_fixed_rotation" 
            ~doc:"Set this body to have fixed rotation. This causes the mass \
                  to be reset."
            [ curry_arg "fixed" (bool @@ arg 0) ] void ;
          map_method "body" "SetLinearDamping" ~rename:"body_set_linear_damping" 
            ~doc:"Set the linear damping of the body."
            [ curry_arg "linear_damping" (float @@ arg 0) ] void ;
          map_method "body" "SetLinearVelocity" ~rename:"body_set_linear_velocity" 
            ~doc:"Set the linear velocity of the center of mass."
            [ curry_arg "v" ((abbrv "Common.Math.vec2") @@ arg 0) ] void ;
          map_method "body" "SetMassData" ~rename:"body_set_mass_data" 
            ~doc:"Set the mass properties to override the mass properties of \
                  the fixtures Note that this changes the center of mass \
                  position. Note that creating or destroying fixtures can \
                  also alter the mass. This function has no effect if the \
                  body isn't dynamic."
            [ curry_arg "mass_data" ((abbrv "Collision.Shapes.mass_data") @@ arg 0) ] void ;
          map_method "body" "SetPosition" ~rename:"body_set_position" 
            ~doc:"Setthe world body origin position."
            [ curry_arg "position" ((abbrv "Common.Math.vec2") @@ arg 0) ] void ;
          map_method "body" "SetPositionAndAngle" ~rename:"body_set_position_and_angle" 
            ~doc:"Set the position of the body's origin and rotation \
                  (radians). This breaks any contacts and wakes the other \
                  bodies."
            [ curry_arg "position" ((abbrv "Common.Math.vec2") @@ arg 0) ;
              curry_arg "angle" (float @@ arg 1) ] void ;
          map_method "body" "SetSleepingAllowed" ~rename:"body_set_sleeping_allowed" 
            ~doc:"Is this body allowed to sleep"
            [ curry_arg "flag" (bool @@ arg 0) ] void ;
          map_method "body" "SetTransform" ~rename:"body_set_transform" 
            ~doc:"Set the position of the body's origin and rotation \
                  (radians). This breaks any contacts and wakes the other \
                  bodies. Note this is less efficient than the other overload \
                  - you should use that if the angle is available."
            [ curry_arg "xf" ((abbrv "Common.Math.transform") @@ arg 0) ] void ;
          map_method "body" "SetType" ~rename:"body_set_type" 
            ~doc:"Set the type of this body. This may alter the mass and \
                  velocity"
            [ curry_arg "_type" (int @@ arg 0) ] void ;
          map_method "body" "SetUserData" ~rename:"body_set_user_data" 
            ~doc:"Set the user data. Use this to store your application \
                  specific data."
            [ curry_arg "data" (any @@ arg 0) ] void ;
          map_method "body" "Split" ~rename:"body_split" 
            ~doc:"Splits a body into two, preserving dynamic properties"
            [ curry_arg "callback" ((callback [] void) @@ arg 0) ] 
            (abbrv "body") ;
        ] ;
        section "The world class manages all physics entities, dynamic simulation, and asynchronous queries." [
          map_method "world" "AddController" ~rename:"world_add_controller" 
            ~doc:"Add a controller to the world list"
            [ curry_arg "c" ((abbrv "Controllers.controller") @@ arg 0) ] 
            (abbrv "Controllers.controller") ;
          map_method "world" "ClearForces" ~rename:"world_clear_forces" 
            ~doc:"Call this after you are done with time steps to clear the \
                  forces. You normally call this after each call to Step, \
                  unless you are performing sub-steps."
            [] void ;
          map_method "world" "CreateBody" ~rename:"world_create_body" 
            ~doc:"Create a rigid body given a definition. No reference to the \
                  definition is retained."
            [ curry_arg "def" ((abbrv "body_def") @@ arg 0) ] 
            (abbrv "body") ;
          map_method "world" "CreateController" ~rename:"world_create_controller"  [ curry_arg "controller" ((abbrv "Controllers.controller") @@ arg 0) ] 
            (abbrv "Controllers.controller") ;
          map_method "world" "CreateJoint" ~rename:"world_create_joint" 
            ~doc:"Create a joint to constrain bodies together. No reference \
                  to the definition is retained. This may cause the connected \
                  bodies to cease colliding."
            [ curry_arg "def" ((abbrv "Joints.joint_def") @@ arg 0) ] 
            (abbrv "Joints.joint") ;
          map_method "world" "DestroyBody" ~rename:"world_destroy_body" 
            ~doc:"Destroy a rigid body given a definition. No reference to \
                  the definition is retained. This function is locked during \
                  callbacks."
            [ curry_arg "b" ((abbrv "body") @@ arg 0) ] void ;
          map_method "world" "DestroyController" ~rename:"world_destroy_controller"  [ curry_arg "controller" ((abbrv "Controllers.controller") @@ arg 0) ] void ;
          map_method "world" "DestroyJoint" ~rename:"world_destroy_joint" 
            ~doc:"Destroy a joint. This may cause the connected bodies to \
                  begin colliding."
            [ curry_arg "j" ((abbrv "Joints.joint") @@ arg 0) ] void ;
          map_method "world" "DrawDebugData" ~rename:"world_draw_debug_data" 
            ~doc:"Call this to draw shapes and other debug draw data."
            [] void ;
          map_method "world" "GetBodyCount" ~rename:"world_get_body_count" 
            ~doc:"Get the number of bodies."
            [] 
            int ;
          map_method "world" "GetBodyList" ~rename:"world_get_body_list" 
            ~doc:"Get the world body list. With the returned body, use \
                  b2Body::GetNext to get the next body in the world list. A \
                  NULL body indicates the end of the list."
            [] 
            (abbrv "body") ;
          map_method "world" "GetContactCount" ~rename:"world_get_contact_count" 
            ~doc:"Get the number of contacts (each may have 0 or more contact \
                  points)."
            [] 
            int ;
          map_method "world" "GetContactList" ~rename:"world_get_contact_list" 
            ~doc:"Get the world contact list. With the returned contact, use \
                  b2Contact::GetNext to get the next contact in the world \
                  list. A NULL contact indicates the end of the list."
            [] 
            (abbrv "Contacts.contact") ;
          map_method "world" "GetGravity" ~rename:"world_get_gravity" 
            ~doc:"Get the global gravity vector."
            [] 
            (abbrv "Common.Math.vec2") ;
          map_method "world" "GetGroundBody" ~rename:"world_get_ground_body" 
            ~doc:"The world provides a single static ground body with no \
                  collision shapes. You can use this to simplify the creation \
                  of joints and static shapes."
            [] 
            (abbrv "body") ;
          map_method "world" "GetJointCount" ~rename:"world_get_joint_count" 
            ~doc:"Get the number of joints."
            [] 
            int ;
          map_method "world" "GetJointList" ~rename:"world_get_joint_list" 
            ~doc:"Get the world joint list. With the returned joint, use \
                  b2Joint::GetNext to get the next joint in the world list. A \
                  NULL joint indicates the end of the list."
            [] 
            (abbrv "Joints.joint") ;
          map_method "world" "GetProxyCount" ~rename:"world_get_proxy_count" 
            ~doc:"Get the number of broad-phase proxies."
            [] 
            int ;
          map_method "world" "IsLocked" ~rename:"world_is_locked" 
            ~doc:"Is the world locked (in the middle of a time step)."
            [] 
            bool ;
          map_method "world" "QueryAABB" ~rename:"world_query_aabb" 
            ~doc:"Query the world for all fixtures that potentially overlap \
                  the provided AABB."
            [ curry_arg "callback" ((callback [] void) @@ arg 0) ;
              curry_arg "aabb" ((abbrv "Collision.aabb") @@ arg 1) ] void ;
          map_method "world" "QueryPoint" ~rename:"world_query_point" 
            ~doc:"Query the world for all fixtures that contain a point."
            [ curry_arg "callback" ((callback [] void) @@ arg 0) ;
              curry_arg "p" ((abbrv "Common.Math.vec2") @@ arg 1) ] void ;
          map_method "world" "QueryShape" ~rename:"world_query_shape" 
            ~doc:"Query the world for all fixtures that precisely overlap the \
                  provided transformed shape."
            [ curry_arg "callback" ((callback [] void) @@ arg 0) ;
              curry_arg "shape" ((abbrv "Collision.Shapes.shape") @@ arg 1) ;
              curry_arg "transform" ((abbrv "Common.Math.transform") @@ arg 2) ] void ;
          map_method "world" "RayCast" ~rename:"world_ray_cast" 
            ~doc:"Ray-cast the world for all fixtures in the path of the ray. \
                  Your callback Controls whether you get the closest point, \
                  any point, or n-points The ray-cast ignores shapes that \
                  contain the starting point"
            [ curry_arg "callback" ((callback [] void) @@ arg 0) ;
              curry_arg "point1" ((abbrv "Common.Math.vec2") @@ arg 1) ;
              curry_arg "point2" ((abbrv "Common.Math.vec2") @@ arg 2) ] void ;
          map_method "world" "RayCastAll" ~rename:"world_ray_cast_all"  [ curry_arg "point1" ((abbrv "Common.Math.vec2") @@ arg 0) ;
                                                                          curry_arg "point2" ((abbrv "Common.Math.vec2") @@ arg 1) ] 
            (array any) ;
          map_method "world" "RayCastOne" ~rename:"world_ray_cast_one"  [ curry_arg "point1" ((abbrv "Common.Math.vec2") @@ arg 0) ;
                                                                          curry_arg "point2" ((abbrv "Common.Math.vec2") @@ arg 1) ] 
            (abbrv "fixture") ;
          map_method "world" "RemoveController" ~rename:"world_remove_controller"  [ curry_arg "c" ((abbrv "Controllers.controller") @@ arg 0) ] void ;
          map_method "world" "SetBroadPhase" ~rename:"world_set_broad_phase" 
            ~doc:"Use the given object as a broadphase. The old broadphase \
                  will not be cleanly emptied."
            [ curry_arg "broad_phase" ((abbrv "Collision.ibroad_phase") @@ arg 0) ] void ;
          map_method "world" "SetContactFilter" ~rename:"world_set_contact_filter" 
            ~doc:"Register a contact filter to provide specific control over \
                  collision. Otherwise the default filter is used \
                  (b2_defaultFilter)."
            [ curry_arg "filter" ((abbrv "contact_filter") @@ arg 0) ] void ;
          map_method "world" "SetContactListener" ~rename:"world_set_contact_listener" 
            ~doc:"Register a contact event listener"
            [ curry_arg "listener" ((abbrv "Contacts.contact_listener") @@ arg 0) ] void ;
          map_method "world" "SetContinuousPhysics" ~rename:"world_set_continuous_physics" 
            ~doc:"Enable/disable continuous physics. For testing."
            [ curry_arg "flag" (bool @@ arg 0) ] void ;
          map_method "world" "SetDebugDraw" ~rename:"world_set_debug_draw" 
            ~doc:"Register a routine for debug drawing. The debug draw \
                  functions are called inside the b2World::Step method, so \
                  make sure your renderer is ready to consume draw commands \
                  when you call Step()."
            [ curry_arg "debug_draw" ((abbrv "Debug_draw.t") @@ arg 0) ] void ;
          map_method "world" "SetDestructionListener" ~rename:"world_set_destruction_listener" 
            ~doc:"Destruct the world. All physics entities are destroyed and \
                  all heap memory is released."
            [ curry_arg "listener" ((abbrv "destruction_listener") @@ arg 0) ] void ;
          map_method "world" "SetGravity" ~rename:"world_set_gravity" 
            ~doc:"Change the global gravity vector."
            [ curry_arg "gravity" ((abbrv "Common.Math.vec2") @@ arg 0) ] void ;
          map_method "world" "SetWarmStarting" ~rename:"world_set_warm_starting" 
            ~doc:"Enable/disable warm starting. For testing."
            [ curry_arg "flag" (bool @@ arg 0) ] void ;
          map_method "world" "Step" ~rename:"world_step" 
            ~doc:"Take a time step. This performs collision detection, \
                  integration, and constraint solution."
            [ curry_arg "dt" (float @@ arg 0) ;
              curry_arg "velocity_iterations" (int @@ arg 1) ;
              curry_arg "position_iterations" (int @@ arg 2) ] void ;
          map_method "world" "Validate" ~rename:"world_validate" 
            ~doc:"Perform validation of internal data structures."
            [] void ;
          map_global "world_e_locked" ~read_only:true (int @@ field (field (field (global "Box2D") "Dynamics") "b2World") "e_locked") ;
          map_global "world_e_new_fixture" ~read_only:true (int @@ field (field (field (global "Box2D") "Dynamics") "b2World") "e_newFixture") ;
        ] ;
        section "Contact impulses for reporting." [
          def_type 
            ~doc:"Contact impulses for reporting."
            "contact_impulse" (abstract any) ;
          map_attribute "contact_impulse" "normalImpulses" ~rename:"contact_impulse_normal_impulses"  (array any) ;
          map_attribute "contact_impulse" "tangentImpulses" ~rename:"contact_impulse_tangent_impulses"  (array any) ;
        ] ;
        section "A fixture is used to attach a shape to a body for collision detection." [
          map_method "fixture" "GetAABB" ~rename:"fixture_get_aabb" 
            ~doc:"Get the fixture's AABB. This AABB may be enlarge and/or \
                  stale. If you need a more accurate AABB, compute it using \
                  the shape and the body transform."
            [] 
            (abbrv "Collision.aabb") ;
          map_method "fixture" "GetBody" ~rename:"fixture_get_body" 
            ~doc:"Get the parent body of this fixture. This is NULL if the \
                  fixture is not attached."
            [] 
            (abbrv "body") ;
          map_method "fixture" "GetDensity" ~rename:"fixture_get_density" 
            ~doc:"Get the density of this fixture."
            [] 
            float ;
          map_method "fixture" "GetFilterData" ~rename:"fixture_get_filter_data" 
            ~doc:"Get the contact filtering data."
            [] 
            (abbrv "filter_data") ;
          map_method "fixture" "GetFriction" ~rename:"fixture_get_friction" 
            ~doc:"Get the coefficient of friction."
            [] 
            float ;
          map_method "fixture" "GetMassData" ~rename:"fixture_get_mass_data" 
            ~doc:"Get the mass data for this fixture. The mass data is based \
                  on the density and the shape. The rotational inertia is \
                  about the shape's origin. This operation may be expensive"
            [ curry_arg "mass_data" ((abbrv "Collision.Shapes.mass_data") @@ arg 0) ] 
            (abbrv "Collision.Shapes.mass_data") ;
          map_method "fixture" "GetNext" ~rename:"fixture_get_next" 
            ~doc:"Get the next fixture in the parent body's fixture list."
            [] 
            (abbrv "fixture") ;
          map_method "fixture" "GetRestitution" ~rename:"fixture_get_restitution" 
            ~doc:"Get the coefficient of restitution."
            [] 
            float ;
          map_method "fixture" "GetShape" ~rename:"fixture_get_shape" 
            ~doc:"Get the child shape. You can modify the child shape, \
                  however you should not change the number of vertices \
                  because this will crash some collision caching mechanisms."
            [] 
            (abbrv "Collision.Shapes.shape") ;
          map_method "fixture" "GetType" ~rename:"fixture_get_type" 
            ~doc:"Get the type of the child shape. You can use this to down \
                  cast to the concrete shape."
            [] 
            int ;
          map_method "fixture" "GetUserData" ~rename:"fixture_get_user_data" 
            ~doc:"Get the user data that was assigned in the fixture \
                  definition. Use this to store your application specific \
                  data."
            [] 
            any ;
          map_method "fixture" "IsSensor" ~rename:"fixture_is_sensor" 
            ~doc:"Is this fixture a sensor (non-solid)?"
            [] 
            bool ;
          map_method "fixture" "RayCast" ~rename:"fixture_ray_cast" 
            ~doc:"Perform a ray cast against this shape."
            [ curry_arg "output" ((abbrv "Collision.ray_cast_output") @@ arg 0) ;
              curry_arg "input" ((abbrv "Collision.ray_cast_input") @@ arg 1) ] 
            bool ;
          map_method "fixture" "SetDensity" ~rename:"fixture_set_density" 
            ~doc:"Set the density of this fixture. This will _not_ \
                  automatically adjust the mass of the body. You must call \
                  b2Body::ResetMassData to update the body's mass."
            [ curry_arg "density" (float @@ arg 0) ] void ;
          map_method "fixture" "SetFilterData" ~rename:"fixture_set_filter_data" 
            ~doc:"Set the contact filtering data. This will not update \
                  contacts until the next time step when either parent body \
                  is active and awake."
            [ curry_arg "filter" ((abbrv "filter_data") @@ arg 0) ] void ;
          map_method "fixture" "SetFriction" ~rename:"fixture_set_friction" 
            ~doc:"Set the coefficient of friction."
            [ curry_arg "friction" (float @@ arg 0) ] void ;
          map_method "fixture" "SetRestitution" ~rename:"fixture_set_restitution" 
            ~doc:"Get the coefficient of restitution."
            [ curry_arg "restitution" (float @@ arg 0) ] void ;
          map_method "fixture" "SetSensor" ~rename:"fixture_set_sensor" 
            ~doc:"Set if this fixture is a sensor."
            [ curry_arg "sensor" (bool @@ arg 0) ] void ;
          map_method "fixture" "SetUserData" ~rename:"fixture_set_user_data" 
            ~doc:"Set the user data. Use this to store your application \
                  specific data."
            [ curry_arg "data" (any @@ arg 0) ] void ;
          map_method "fixture" "TestPoint" ~rename:"fixture_test_point" 
            ~doc:"Test a point for containment in this fixture."
            [ curry_arg "p" ((abbrv "Common.Math.vec2") @@ arg 0) ] 
            bool ;
        ] ;
        section "A fixture definition is used to create a fixture." [
          map_attribute "fixture_def" "density" ~rename:"fixture_def_density" 
            ~doc:"The density, usually in kg/m^2."
            float ;
          map_attribute "fixture_def" "filter" ~rename:"fixture_def_filter" 
            ~doc:"Contact filtering data."
            (abbrv "filter_data") ;
          map_attribute "fixture_def" "friction" ~rename:"fixture_def_friction" 
            ~doc:"The friction coefficient, usually in the range [0,1]."
            float ;
          map_attribute "fixture_def" "isSensor" ~rename:"fixture_def_is_sensor" 
            ~doc:"A sensor shape collects contact information but never \
                  generates a collision response."
            bool ;
          map_attribute "fixture_def" "restitution" ~rename:"fixture_def_restitution" 
            ~doc:"The restitution (elasticity) usually in the range [0,1]."
            float ;
          map_attribute "fixture_def" "shape" ~rename:"fixture_def_shape" 
            ~doc:"The shape, this must be set. The shape will be cloned, so \
                  you can create the shape on the stack."
            (abbrv "Collision.Shapes.shape") ;
          map_attribute "fixture_def" "userData" ~rename:"fixture_def_user_data" 
            ~doc:"Use this to store application specific fixture data."
            any ;
        ] ;
        section "A body definition holds all the data needed to construct a rigid body." [
          map_attribute "body_def" "active" ~rename:"body_def_active" 
            ~doc:"Does this body start out active?"
            bool ;
          map_attribute "body_def" "allowSleep" ~rename:"body_def_allow_sleep" 
            ~doc:"Set this flag to false if this body should never fall \
                  asleep. Note that this increases CPU usage."
            bool ;
          map_attribute "body_def" "angle" ~rename:"body_def_angle" 
            ~doc:"The world angle of the body in radians."
            float ;
          map_attribute "body_def" "angularDamping" ~rename:"body_def_angular_damping" 
            ~doc:"Angular damping is use to reduce the angular velocity. The \
                  damping parameter can be larger than 1.0f but the damping \
                  effect becomes sensitive to the time step when the damping \
                  parameter is large."
            float ;
          map_attribute "body_def" "angularVelocity" ~rename:"body_def_angular_velocity" 
            ~doc:"The angular velocity of the body."
            float ;
          map_attribute "body_def" "awake" ~rename:"body_def_awake" 
            ~doc:"Is this body initially awake or sleeping?"
            bool ;
          map_attribute "body_def" "bullet" ~rename:"body_def_bullet" 
            ~doc:"Is this a fast moving body that should be prevented from \
                  tunneling through other moving bodies? Note that all bodies \
                  are prevented from tunneling through static bodies."
            bool ;
          map_attribute "body_def" "fixedRotation" ~rename:"body_def_fixed_rotation" 
            ~doc:"Should this body be prevented from rotating? Useful for \
                  characters."
            bool ;
          map_attribute "body_def" "inertiaScale" ~rename:"body_def_inertia_scale" 
            ~doc:"Scales the inertia tensor."
            float ;
          map_attribute "body_def" "linearDamping" ~rename:"body_def_linear_damping" 
            ~doc:"Linear damping is use to reduce the linear velocity. The \
                  damping parameter can be larger than 1.0f but the damping \
                  effect becomes sensitive to the time step when the damping \
                  parameter is large."
            float ;
          map_attribute "body_def" "linearVelocity" ~rename:"body_def_linear_velocity" 
            ~doc:"The linear velocity of the body's origin in world \
                  co-ordinates."
            (abbrv "Common.Math.vec2") ;
          map_attribute "body_def" "position" ~rename:"body_def_position" 
            ~doc:"The world position of the body. Avoid creating bodies at \
                  the origin since this can lead to many overlapping shapes."
            (abbrv "Common.Math.vec2") ;
          map_attribute "body_def" "type" ~rename:"body_def_type" 
            ~doc:"The body type: static, kinematic, or dynamic. A member of \
                  the b2BodyType class Note: if a dynamic body would have \
                  zero mass, the mass is set to one."
            int ;
          map_attribute "body_def" "userData" ~rename:"body_def_user_data" 
            ~doc:"Use this to store application specific body data."
            any ;
        ] ;
      ] ;
  ]
