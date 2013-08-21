(* Published under the MIT License.
   Binding (c) 2013 Arnaud Parant
   Library (c) 2013 Adobe Systems Inc. *)

open Goji

let phonegap_package = register_package 
    ~doc:"Cross-platform Interface to mobile devices"
    ~version:"3.0.0-0"
    "phonegap"

let accelerometer_component = register_component 
    ~doc:"Captures device motion in the x, y, and z direction."
    ~author:"Adobe Systems Inc."
    ~version:"3.0.0"
    ~license:Goji_license.apache_v2
    ~grabber:Goji_grab.(nop (** The JavaScript code is inserted by PhoneGap. *))
    phonegap_package "Phonegap_accelerometer" [
    def_type 
      ~doc:"Contains Accelerometer data captured at a specific point in \
            time."
      "acceleration" (public (record [
          row "x" (float @@ field root "x") ;
          row "y" (float @@ field root "y") ;
          row "z" (float @@ field root "z") ;
          row "timestamp" (float @@ field root "timestamp")
        ])) ;
    def_type 
      ~doc:"The ID returned by watchAcceleration"
      "watchID" (public int) ;
    map_function "get_current_acceleration"
      ~doc:"The acceleration values are returned to the \
            accelerometerSuccess callback function."
      [ curry_arg "on_success"
          ~doc:"Success callback function that provides the Acceleration \
                information."
          ((callback [ curry_arg "acceleration" ((abbrv "acceleration") @@ arg 0) ] void) @@ arg 0) ;
        curry_arg "on_error"
          ~doc:"Error callback function."
          ((callback [] void) @@ arg 1) ]
      "navigator.accelerometer.getCurrentAcceleration" void ;
    map_function "watchAcceleration"
      ~doc:"It retrieves the device's current Acceleration at a regular \
            interval, executing the accelerometerSuccess callback \
            function each time."
      [ curry_arg "on_success"
          ~doc:"onSuccess callback function that provides the Acceleration \
                information."
          ((callback [ curry_arg "acceleration" ((abbrv "acceleration") @@ arg 0) ] void) @@ arg 0) ;
        curry_arg "accelerometerError"
          ~doc:"onError callback function."
          ((callback [] void) @@ arg 1) ;
        opt_arg "accelerometerOptions"
          ~doc:"Specify the interval in milliseconds."
          (float @@ arg 2) ]
      "navigator.accelerometer.watchAcceleration" 
      (abbrv "watchID") ;
    map_function "clearWatch"
      ~doc:"Stop watching the Acceleration."
      [ curry_arg "watchID"
          ~doc:"The ID returned by watchAcceleration."
          ((abbrv "watchID") @@ arg 0) ]
      "navigator.accelerometer.clearWatch" void ;
  ]

let camera_component = register_component 
    ~doc:"The camera object provides access to the device's default camera application."
    ~author:"Adobe Systems Inc."
    ~version:"3.0.0"
    ~license:Goji_license.apache_v2
    ~grabber:Goji_grab.(nop (** The JavaScript code is inserted by PhoneGap. *))
    phonegap_package "Phonegap_camera" [
    def_type 
      ~doc:"Direction of the arrow in the file selection popover."
      "popover_arrow_dir"
      (public (int_enum [ "Up", 1 ; "Down", 2 ; "Left", 4 ; "Right", 8 ; "Any", 15 ])) ;
    def_type 
      ~doc:"Position of the file selection popover."
      "popover_options"
      (public (record [
           row "x" (int @@ field root "x") ;
           row "y" (int @@ field root "y") ;
           row "width" (int @@ field root "width") ;
           row "height" (int @@ field root "height") ;
           row "arrow_dir" (abbrv "popover_arrow_dir" @@ field root "arrowDir")
         ])) ;
    map_type 
      ~doc:"A proxy object that can be used to reposition the file selection popover."
      "popover_handle" ;
    map_method "popover_handle" "setPosition" ~rename:"set_position"
      ~doc:"Set the position of the popover."
      [ curry_arg "options" (abbrv "popover_options") ] void ;
    map_function "get_picture"
      ~doc:"Takes a photo using the camera, or retrieves a photo from \
            the device's image gallery. The image is passed to the \
            success callback as a base64-encoded String, or as the URI \
            for the image file."
      [ opt_arg "quality" ~doc:"" (int @@ field (arg 2) "quality") ;
        opt_arg "destinationType" ~doc:"" (int @@ field (arg 2) "destinationType") ;
        opt_arg "source_type" ~doc:"" (int @@ field (arg 2) "sourceType") ;
        opt_arg "allow_edit" ~doc:"" (bool @@ field (arg 2) "allowEdit") ;
        opt_arg "encoding_type" ~doc:"" (int @@ field (arg 2) "encodingType") ;
        opt_arg "target_width" ~doc:"" (int @@ field (arg 2) "targetWidth") ;
        opt_arg "target_height" ~doc:"" (int @@ field (arg 2) "targetHeight") ;
        opt_arg "media_type" ~doc:"" (int @@ field (arg 2) "mediaType") ;
        opt_arg "correct_orientation" ~doc:"" (bool @@ field (arg 2) "correctOrientation") ;
        opt_arg "save_to_photo_album" ~doc:"" (bool @@ field (arg 2) "saveToPhotoAlbum") ;
        opt_arg "popover" ~doc:"" (abbrv "popover_options" @@ field (arg 2) "popoverOptions") ;

          (*
          opt_arg "popover_x" ~doc:"" (abbrv "popover_options" @@ field (field (arg 2) "popoverOptions") "x") ;

             (* or even *)
          opt_arg "popover_pos" ~doc:""
            (tuple [
                abbrv "popover_options" @@ field (field (arg 2) "popoverOptions") "x" ;
                abbrv "popover_options" @@ field (field (arg 2) "popoverOptions") "y" ]) ;
          *)
        opt_arg "camera_direction" ~doc:"" (int @@ field (arg 2) "cameraDirection") ;
        labeled_arg "on_success"
          ~doc:"onSuccess callback function that provides the image \
                information."
          ((callback [ curry_arg "imageData"
                         ~doc:"Base64 encoding of the image data, or the image file URI, \
                               depending on cameraOptions in effect."
                         (string @@ arg 0) ] void) @@ arg 0) ;
        labeled_arg "on_error"
          ~doc:"onError callback function."
          ((callback [ curry_arg "message"
                         ~doc:"The message is provided by the device's native code."
                         (string @@ arg 0) ] void) @@ arg 1) ;
      ]
      "navigator.camera.getPicture" 
      (abbrv "popover_handle") ;
    map_function "cleanup"
      ~doc:"Removes intermediate image files that are kept in temporary \
            storage after calling camera.getPicture. Applies only when \
            the value of Camera.sourceType equals \
            Camera.PictureSourceType.CAMERA and the \
            Camera.destinationType equals \
            Camera.DestinationType.FILE_URI."
      [ curry_arg "on_success"
          ~doc:"Success callback function."
          ((callback [] void) @@ arg 0) ;
        curry_arg "on_error"
          ~doc:"Error callback function."
          ((callback [ curry_arg "message"
                         ~doc:"The message is provided by the device's native code."
                         (string @@ arg 0) ] void) @@ arg 1) ]
      "navigator.accelerometer.cleanup" void ;
  ]

let camera_component = register_component 
    ~doc:"The device object describes the device's hardware and software."
    ~author:"Adobe Systems Inc."
    ~version:"3.0.0"
    ~license:Goji_license.apache_v2
    ~grabber:Goji_grab.(nop (** The JavaScript code is inserted by PhoneGap. *))
    phonegap_package "Phonegap_device" [
    map_global "name"
      ~doc:"It returns the name of the device's model or product. This \
            value is set by the device manufacturer and may be \
            different across versions of the same product."
      ~read_only:true (string @@ field (global "window.device") "name") ;
    map_global "cordova"
      ~doc:"It returns the version of Cordova running on the device."
      ~read_only:true (string @@ field (global "window.device") "cordova") ;
    map_global "platform"
      ~doc:"Get the device's operating system name."
      ~read_only:true (string @@ field (global "window.device") "platform") ;
    map_global "uuid"
      ~doc:"Get the device's Universally Unique Identifier."
      ~read_only:true (string @@ field (global "window.device") "uuid") ;
    map_global "version"
      ~doc:"Get the operating system version."
      ~read_only:true (string @@ field (global "window.device") "version") ;
    map_global "model"
      ~doc:"It returns the name of the device's model or product. The \
            value is set by the device manufacturer and may be \
            different across versions of the same product."
      ~read_only:true (string @@ field (global "window.device") "model") ;
  ]
