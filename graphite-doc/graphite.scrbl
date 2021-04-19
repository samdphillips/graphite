#lang scribble/manual
@(require scribble/example (for-label racket plot/utils pict data-frame graphite
                                      (except-in plot density lines points)))

@title{Graphite: A data visualization library}

@table-of-contents[]

@defmodule[graphite]


@section[#:tag "graphing-procedures"]{Graphing Procedures}


@defproc[(graph [#:data data data-frame?]
                [#:mapping mapping aes?]
                [#:width width (or/c rational? #f) (plot-width)]
                [#:height height (or/c rational? #f) (plot-height)]
                [#:title title (or/c string? pict? #f) (plot-title)]
                [#:x-label x-label (or/c string? pict? #f) (plot-x-label)]
                [#:x-transform x-transform (or/c invertible-function? #f) #f]
                [#:x-ticks x-ticks ticks? (plot-x-ticks)]
                [#:x-conv x-conv (or/c (-> any/c real?) #f) #f]
                [#:x-min x-min (or/c rational? #f) #f]
                [#:x-max x-max (or/c rational? #f) #f]
                [#:y-label y-label (or/c string? pict? #f) (plot-y-label)]
                [#:y-transform y-transform (or/c invertible-function? #f) #f]
                [#:y-ticks y-ticks ticks? (plot-y-ticks)]
                [#:y-conv y-conv (or/c (-> any/c real?) #f) #f]
                [#:y-min y-min (or/c rational? #f) #f]
                [#:y-max y-max (or/c rational? #f) #f]
                [#:legend-anchor legend-anchor legend-anchor/c (plot-legend-anchor)]
                [renderer graphite-renderer?] ...)
         pict?]{
  Does the thing.
}

@section[#:tag "aesthetics"]{Aesthetic Mappings}

@defproc[(aes [#:<key> value any/c] ...) aes?]{
  Creates an aesthetic mapping.
}

@defproc[(aes? [v any/c]) boolean?]{
  Determines if the input is an aesthetic mapping.
}

@defproc[(aes-with/c [#:<key> contract contract?] ...) contract?]{
  Determines if the aesthetic mapping has each @tt{key}, with each value satisfying
  the given contract.
}

@defproc[(aes-containing/c [#:<key> contract contract?] ...) contract?]{
  Determines if the aesthetic mapping optionally contains each @tt{key}, and if it does,
  that each value satisfies the given contract.
}

@section[#:tag "renderers"]{Renderers}

@defproc[(graphite-renderer? [v any/c]) boolean?]{
  Determines if the input is a renderer, designed to be fed to @racket[graph].
}

@defproc[(points [#:mapping local-mapping
                            (aes-containing/c #:x string?
                                              #:y string?
                                              #:facet (or/c string? #f)
                                              #:discrete-color (or/c string? #f)
                                              #:x-min (or/c rational? #f)
                                              #:x-max (or/c rational? #f)
                                              #:y-min (or/c rational? #f)
                                              #:y-max (or/c rational? #f)
                                              #:sym point-sym/c
                                              #:color plot-color/c
                                              #:fill-color (or/c plot-color/c 'auto)
                                              #:x-jitter (>=/c 0)
                                              #:y-jitter (>=/c 0)
                                              #:size (>=/c 0)
                                              #:line-width (>=/c 0)
                                              #:alpha (real-in 0 1)
                                              #:label (or/c string? pict? #f))
                            (make-hash)])
         graphite-renderer?]{
  Renders some points.
}

@defproc[(fit [#:method method (or/c 'linear 'exp 'power 'log) 'linear]
              [#:mapping local-mapping
                         (aes-containing/c #:x string?
                                           #:y string?
                                           #:facet (or/c string? #f)
                                           #:y-min (or/c rational? #f)
                                           #:y-max (or/c rational? #f)
                                           #:samples (and/c exact-integer? (>=/c 2))
                                           #:color plot-color/c
                                           #:width (>=/c 0)
                                           #:style plot-pen-style/c
                                           #:alpha (real-in 0 1)
                                           #:label (or/c string? pict? #f))
                         (make-hash)])
         graphite-renderer?]{
  Makes a line of best fit.
}

@defproc[(lines [#:mapping local-mapping
                           (aes-containing/c #:x string?
                                             #:y string?
                                             #:facet (or/c string? #f)
                                             #:discrete-color (or/c string? #f)
                                             #:x-min (or/c rational? #f)
                                             #:x-max (or/c rational? #f)
                                             #:y-min (or/c rational? #f)
                                             #:y-max (or/c rational? #f)
                                             #:color plot-color/c
                                             #:width (>=/c 0)
                                             #:style plot-pen-style/c
                                             #:alpha (real-in 0 1)
                                             #:label (or/c string? pict? #f))
                           (make-hash)])
         graphite-renderer?]{
  You know.
}

@defproc[(bar [#:mode mode (or/c 'count 'prop) 'count]
              [#:mapping local-mapping
                         (aes-containing/c #:x string?
                                           #:facet (or/c string? #f)
                                           #:group any/c
                                           #:group-gap (>=/c 0)
                                           #:x-min (or/c rational? #f)
                                           #:x-max (or/c rational? #f)
                                           #:y-min (or/c rational? #f)
                                           #:y-max (or/c rational? #f)
                                           #:gap (real-in 0 1)
                                           #:skip (>=/c 0)
                                           #:invert? boolean?
                                           #:color plot-color/c
                                           #:style plot-brush-style/c
                                           #:line-color plot-color/c
                                           #:line-width (>=/c 0)
                                           #:line-style plot-pen-style/c
                                           #:alpha (real-in 0 1)
                                           #:label (or/c string? pict? #f)
                                           #:add-ticks? boolean?
                                           #:far-ticks? boolean?)
                         (make-hash)])
         graphite-renderer?]{
  Yea
}

@defproc[(stacked-bar [#:mode mode (or/c 'count 'prop) 'count]
                      [#:mapping local-mapping
                                 (aes-containing/c #:x string?
                                                   #:facet (or/c string? #f)
                                                   #:group string?
                                                   #:x-min (or/c rational? #f)
                                                   #:x-max (or/c rational? #f)
                                                   #:y-min (or/c rational? #f)
                                                   #:y-max (or/c rational? #f)
                                                   #:gap (real-in 0 1)
                                                   #:skip (>=/c 0)
                                                   #:invert? boolean?
                                                   #:colors (plot-colors/c nat/c)
                                                   #:styles (plot-brush-styles/c nat/c)
                                                   #:line-colors (plot-colors/c nat/c)
                                                   #:line-widths (plot-colors/c nat/c)
                                                   #:line-styles (plot-pen-styles/c nat/c)
                                                   #:alphas (alphas/c nat/c)
                                                   #:labels (labels/c nat/c)
                                                   #:add-ticks? boolean?
                                                   #:far-ticks? boolean?)
                                 (make-hash)])
         graphite-renderer?]{
  Nah
}

@defproc[(histogram [#:bins bins positive-integer? 30]
                    [#:mapping local-mapping
                               (aes-containing/c #:x string?
                                                 #:y string?
                                                 #:facet (or/c string? #f)
                                                 #:x-min (or/c rational? #f)
                                                 #:x-max (or/c rational? #f)
                                                 #:y-min (or/c rational? #f)
                                                 #:y-max (or/c rational? #f)
                                                 #:color plot-color/c
                                                 #:style plot-brush-style/c
                                                 #:line-color plot-color/c
                                                 #:line-width (>=/c 0)
                                                 #:line-style plot-pen-style/c
                                                 #:alpha (real-in 0 1)
                                                 #:label (or/c string? pict? #f))
                               (make-hash)])
         graphite-renderer?]{
  Meh
}

@defproc[(density [#:mapping local-mapping
                             (aes-containing/c #:x string?
                                               #:facet (or/c string? #f)
                                               #:x-min (or/c rational? #f)
                                               #:x-max (or/c rational? #f)
                                               #:y-min (or/c rational? #f)
                                               #:y-max (or/c rational? #f)
                                               #:samples (and/c exact-integer? (>=/c 2))
                                               #:color plot-color/c
                                               #:width (>=/c 0)
                                               #:style plot-pen-style/c
                                               #:alpha (real-in 0 1)
                                               #:label (or/c string? pict? #f))
                             (make-hash)])
         graphite-renderer?]{
  Maybe
}
