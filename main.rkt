#lang racket/base


(provide
 stream-take
 (all-from-out racket/stream))

(module core racket/base
  (require
   racket/contract/base racket/stream
   abstraction/tools)

  (provide
   (contract-out))
  (define nonempty-stream/c
     (and/c stream? (not/c stream-empty?))))


(require
 racket/contract racket/stream 
 (submod "." core))


(define (stream-iterate x f)
  (stream-cons x (stream-iterate (f x) f)))






(define (stream-take xs n)
  (if (<= n 0) empty-stream
      (stream-cons
       (stream-first xs)
       (stream-take (stream-rest xs)
		    (sub1 n)))))

(module+ test
  (require rackunit)
  (check-equal?
   (stream->list (stream-take (stream-iterate 0 add1) 3))
   '(0 1 2)))


