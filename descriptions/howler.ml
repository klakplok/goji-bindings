(* Published under the MIT License.
   Binding (c) 2013 Benjamin Canou
   Library (c) 2013 Goldfire Studios *)

open Goji

let package =
  register_package
    ~doc:"Modern Web Audio Javascript Library"
    ~version:"1.1.7-0"
    "howler"

let _ =
  register_component
    ~version:"1.1.7"
    ~author:"Goldfire Studios"
    ~license:License.mit
    ~depends:[ "browser" ]
    ~grabber:Grab.(sequence [
      http_get
	"https://raw.github.com/goldfire/howler.js/\
         0b27ccd8dda0032db6c47cbd13a35edeacfc81ad/howler.js"
	"goji_entry.js"
    ])
    ~doc:"Modern Web Audio Javascript Library"
    package "Howler"
    [ def_type ~doc:"the type of sound samples" "sound" (abstract any) ;
      section "Building Samples" [
        def_constructor "sound" "make"
          ~doc:"Builds a sound sample"
          [ opt_arg "autoplay"
              ~doc:"([true] by default)\ Set to true to automatically \
                    start playback when sound is loaded"
              (bool @@ (field (arg 0) "autoplay")) ;
            opt_arg "loop"
              ~doc: "([false] by default) Set to true to automatically \
                     loop the sound forever"
              (bool @@ (field (arg 0) "loop")) ;
            opt_arg "volume"
              ~doc:"(1.0 by default) The volume of the specific track, \
                    from 0.0 to 1.0"
              (bool @@ (field (arg 0) "volume")) ;
            opt_arg "buffer"
              ~doc:"(false by default) Set to true to force HTML5 Audio.\n\
                    Should be used for large audio files so that you don't \
                    have to wait for the full file to be downloaded and \
                    decoded before playing"
              (bool @@ (field (arg 0) "buffer")) ;
            opt_arg "sprites"
              ~doc:"Define sound sprites in format (name, (offset, duration)) \
                    for the sound. The offset and duration are defined \
                    in milliseconds"
              (assoc (tuple_cells [ float ; float ]) @@ field (arg 0) "sprite") ;
            opt_arg "on_load"
              ~doc:"Fires when the sound is loaded"
              (event [] void @@ field (arg 0) "onload") ;
            opt_arg "on_load_error"
              ~doc:"Fires when the sound fails to load"
              (event [] void @@ field (arg 0) "onloaderror") ;
            opt_arg "on_pause"
              ~doc:"Fires when the sound has been pauser"
              (event [] void @@ field (arg 0) "onpause") ;
            opt_arg "on_play"
              ~doc:"Fires when the sound begind playing"
              (event [] void @@ field (arg 0) "onplay") ;
            curry_arg "urls"
              ~doc:"The source URLs to the track(s) to be loaded for the sound.\n\
                    These should be in order of preference, howler.js will \
                    automatically load the first one that is compatible \
                    with the current browser"
              (array string @@ field (arg 0) "urls") ]
          (call_constructor (global "Howl")) ;
      ] ;
      section "Working with Samples" [
        def_method "sound" "play"
          ~doc:"Plays a sound sample"
          [ opt_arg "sprite" ~doc:"Sprite to play" (int @@ rest ()) ]
          (call_method "play") void ;
        map_method "sound" "pause"
          ~doc:"Pauses playback of sound, saving the pos of playback"
          [] void ;
        map_method "sound" "stop"
          ~doc:"Stops playback of sound, resetting pos to 0"
          [] void ;
        map_method "sound" "mute"
          ~doc:"Mutes the sound, but doesn't pause the playback"
          [] void ;
        map_method "sound" "unmute"
          ~doc:"Unmutes the sound"
          [] void ;
        map_method "sound" "loop" ~rename:"set_loop"
          ~doc:"Set whether to loop the sound"
          [ curry_arg "loop"
	      ~doc:"To loop or not to loop, that is the question" (bool @@ arg 0) ]
	  void ;
        map_method "sound" "loop"
          ~doc:"Tells if the sound loops or not"
          [] bool ;
        map_method "sound" "pos" ~rename:"set_pos"
          ~doc:"Set the position of playback"
          [ curry_arg "pos"
	      ~doc:"Position to move current playback to" (float @@ arg 0) ]
	  void ;
        map_method "sound" "pos"
          ~doc:"Get the position of playback"
          [] float ;
        (let fade_params =
          [ curry_arg "to_volume"
	      ~doc:"Volume to fade to (0.0 to 1.0)" (float @@ arg 0) ;
            curry_arg "duration"
	      ~doc:"Time in milliseconds to fade" (float @@ arg 1) ;
            opt_arg "on_complete"
	      ~doc:"Fires when fade is complete" (event [] void @@ rest ()) ]
        in group [
          map_method "sound" "fadeOut"  ~rename:"fade_out"
            ~doc:"Fade out the current sound and pause when finished"
            fade_params void ;
          map_method "sound" "fadeIn" ~rename:"fade_in"
            ~doc:"Fade in the current sound"
            fade_params void
        ]) ;
        map_method "sound" "pos3d" ~rename:"spatial_position"
          ~doc:"Get/set the 3D position of the audio source. The most common \
                usage is to set the x position to affect the left/right ear \
                panning. Setting the value higher than 1.0 will begin to \
                decrease the volume of the sound as it moves further away. \
                This only works with Web Audio API"
          [ curry_arg "x" ~doc:"The x-position of the sound" (float @@ arg 0) ;
            curry_arg "y" ~doc:"The y-position of the sound" (float @@ arg 1) ;
            curry_arg "z" ~doc:"The z-position of the sound" (float @@ arg 2) ]
          void ;
      ] ;
      section "Global Functions" [
        map_function "global_mute"
          ~doc:"Mutes all sounds" [] "Howl.mute" void ;
        map_function "global_unmute"
          ~doc:"Unmutes all sounds" [] "Howl.unmute" void ;
        map_function "set_global_volume"
          ~doc:"Get/set the global volume for all sounds"
          [ curry_arg "to_volume" ~doc:"Volume from 0.0 to 1.0" (float @@ arg 0)]
          "Howl.volume" void
      ] ;
    ]
