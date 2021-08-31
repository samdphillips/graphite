#lang racket

(require data-frame
         tabular-asa
         gregor
         plot/utils
         graphite)
(provide (all-defined-out))


(define chic-raw-df
  (df-read/csv "data/chicago-nmmaps.csv"))
(define chic-raw-tbl
  (call-with-input-file "data/chicago-nmmaps.csv"
    (lambda (inp)
      (table-read/csv inp))))

(graph #:data chic-raw
       #:title "Temperatures in Chicago"
       #:x-label "Year"
       #:y-label "Temperature (degrees F)"
       #:mapping (aes #:x "date" #:y "temp")
       #:x-transform (only-ticks (date-ticks))
       #:x-conv (compose ->posix iso8601->date)
       #:width 600
       (lines))
