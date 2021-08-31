#lang racket/base

(require racket/generic
         racket/lazy-require)

(provide df-select
         in-data-frame
         (rename-out
          [df-graphite? data-frame?]))

(lazy-require
  [data-frame (data-frame?
                [df-select df-select^]
                [in-data-frame in-data-frame^])]
  [tabular-asa (table? table-column)])

(define (->symbol s)
  (cond
    [(symbol? s) s]
    [(string? s) (string->symbol s)]))

(define (wrap-pred pred?)
  (lambda (v)
    (with-handlers* ([exn:fail:filesystem:missing-module? (lambda (e) #f)])
      (pred? v))))

(define-generics df-graphite
  (df-select df-graphite name)
  (in-data-frame df-graphite name)
  #:defaults
  ([(wrap-pred table?)
    (define (df-select df name)
      (define name-sym (->symbol name))
      (for/vector ([v (table-column df name-sym)]) v))
    (define (in-data-frame df name)
      (define name-sym (->symbol name))
      (table-column df name-sym))]
   [(wrap-pred data-frame?)
    (define df-select df-select^)
    (define in-data-frame in-data-frame^)]))

