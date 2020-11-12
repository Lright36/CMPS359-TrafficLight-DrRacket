#lang racket
;;Luke Thibodeaux
;;C00096638

(require 2htdp/universe)
(require 2htdp/image)
(require 2htdp/batch-io)
(require test-engine/racket-tests)

;;Your job is to finish the steps 5 and 6 while designing
;;The render-light
(define traffic-light-height 200)
(define traffic-light-width 100)
(define light-box
  (rectangle traffic-light-width traffic-light-height "outline" "black"))
(define (light-on color)(circle 20 "solid" color))
(define (light-off color)(circle 20 "outline" color))
;;A TrafficLight is an enumeration of the following Strings:
;;"red", "yellow", and "green"
;;Interpretation, the following strings represent the different lights a
;;traffic light can light up
(define red-light-on (light-on "red"))
(define yellow-light-on (light-on "yellow"))
(define green-light-on (light-on "green"))
(define red-light-off (light-off "red"))
(define yellow-light-off (light-off "yellow"))
(define green-light-off (light-off "green"))

(define light-on-red
  (overlay light-box
           (above red-light-on yellow-light-off green-light-off)))
(define light-on-yellow
  (overlay light-box
           (above red-light-off yellow-light-on green-light-off)))
(define light-on-green
  (overlay light-box
           (above red-light-off yellow-light-off green-light-on)))

;;A WorldState is a TrafficLight

;;WorldState -> Image
;;Draws a traffic light of a color derived from the current world state
;;Given: "red" Expect: (circle  traffic-light-size "solid" "red")
;;Given: "green" Expect: (circle  traffic-light-size "solid" "green")
;;Given: "yellow" Expect: (circle  traffic-light-size "solid" "yellow")
(define (render-light s)
  (cond
       [(string=? s "red") light-on-red]
       [(string=? s "yellow") light-on-yellow]
       [(string=? s "green") light-on-green]))

       

;; TrafficLight -> TrafficLight
;; yields the next state given current state s
;;Given: "red" Expect: "green"
;;Given: "green" Expect: "yellow"
;;Given: "yellow" Expect: "red"
(define (traffic-light-next s)
  (cond
    [(string=? "red" s) "green"]
    [(string=? "green" s) "yellow"]
    [(string=? "yellow" s) "red"]))

    ;replace with s 

;;Here is the main big-bang function
;;The event handlers are already registered
;;Just finish the definition for render-light and traffic-light-next
(define (main-light color)
  (big-bang color
	    [on-tick traffic-light-next]
	    [to-draw render-light]))

(main-light "red")