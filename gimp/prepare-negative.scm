; Negtive processing script based on:
;   https://code.google.com/p/mcclanahoochie/source/browse/gimp_scripts/auto-wb-lce.scm
;
;   It applies:
;     - Invert
;     - Auto White Balance 
;     - Local Contrast Enhancement
;   effects to an image.
;
; Requires Fx-Foundry (gimp-plugin-registry) 
;   for LCE
;
; Install to ~/.gimp-2.x/scripts
;
; ~Hermann Käser

(define (script-fu-prepare-negative
        image
        drawable)

; ======================================= ;
; setup
; ======================================= ;

    (let* (
         (work-layer -1)
         ) ; End of variable definitions

    ; Save the current settings
    (gimp-context-push)

    ; Start an undo group so the image can be restored with one undo
    (gimp-image-undo-group-start image)

    ; Clear any selections to avoid execution errors. 
    (gimp-selection-none image)

    ; copy visible into a work-layer
    (set! work-layer (car (gimp-layer-new-from-visible image image "Enhanced") ))
    (gimp-image-add-layer image work-layer 0) 

    ; activate
    (gimp-image-set-active-layer image work-layer)

; ======================================= ;
; invert
; ======================================= ;

    ; Invert image
    (gimp-invert work-layer)
    (set! work-layer (car (gimp-image-get-active-layer image)))     
    (gimp-image-set-active-layer image work-layer)

; ======================================= ;
; auto white balance
; ======================================= ;

    (gimp-levels-stretch work-layer)
    (set! work-layer (car (gimp-image-get-active-layer image)))     
    (gimp-image-set-active-layer image work-layer) 

; ======================================= ;
; local contrast enhancement
; ======================================= ;

    (script-fu-LCE 1 work-layer work-layer 45 10)
    (set! work-layer (car (gimp-image-get-active-layer image)))     
    (gimp-image-set-active-layer image work-layer) 

; ======================================= ;
; finish
; ======================================= ;

    (gimp-image-undo-group-end image)

    ; Display the updated image
    (gimp-displays-flush)

    ; Restore previous settings
    (gimp-context-pop)  

    ) ; End of Let block
)  ; End of Define block

(script-fu-register "script-fu-prepare-negative"
                "Auto WB+LCE"
                "Invert, Auto White Balance and Local Contrast Enhancement"
                "Hermann Käser"
                "Hermann Käser"
                "2015"
                "RGB*, GRAY*"
                SF-IMAGE    "Image"    0
                SF-DRAWABLE "Drawable" 0
                )

(script-fu-menu-register "script-fu-prepare-negative"
                     "<Image>/Script-Fu/Negative")