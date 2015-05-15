# sig.length: Temporal length of sequences #

`sig.length` returns the temporal length of the temporal sequence given in input, which can be either an audio waveform (`sig.input`) or an envelope curve (`sig.envelope`). If the input was decomposed into segments (`sig.segment`), `sig.length` returns a curve indicating the series of temporal duration associated with each successive segment.


## Options ##

  * `sig.length(…,'Unit',`_u_`)` specifies the length unit. The possible values are:
    * _u_ = `'Second'`: duration in seconds (Default choice).
    * _u_ = `'Sample'`: length in number of samples.