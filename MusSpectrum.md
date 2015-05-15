# mus.spectrum: Spectrum representation based on music theory #

This operations is a specialisation of the general signal processing operator [sig.spectrum](SigSpectrum.md) focused on music-theory.

## Resonance curve ##

  * `mus.spectrum(…,'Resonance',`_r_`)` multiplies the spectrum curve with a resonance curve that emphasizes pulsations that are more easily perceived. Two resonance curves are available:
    * _r_ = `'ToiviainenSnyder'` (Toiviainen & Snyder 2003), default choice, used for onset detection (cf. SigTempo),
    * _r_ = `'Fluctuation'` : fluctuation strength (Fastl 1982), default choice for frame-decomposed `'sig.spectrum'` objects redecomposed in 'Mel' bands (cf. SigFluctuation).<p></li></ul></li></ul>

<h2>Spectrum decomposition into cents</h2>

<code>mus.spectrum(…,'Cents')</code> distribute frequencies along cents. Each octave is decomposed into 1200 bins equally distant in the logarithmic representation. The frequency axis is hence expressed in MIDI-cents unit: to each pitch of the equal temperament is associated the corresponding MIDI pitch standard value multiply by 100 (69*100=6900 for A4=440Hz, 70*100=7000 for B4, etc.).<br>
<br>
<blockquote><img src='https://miningsuite.googlecode.com/svn/wiki/SigSpectrum_ex4.png' /></blockquote>

<blockquote>It has to be noticed that this decomposition requires a frequency resolution that gets higher for lower frequencies: a cent-distribution starting from infinitely low frequency (near 0 Hz would require an infinite frequency resolution). Hence by default, the cent-decomposition is defined only for the frequency range suitable for the frequency resolution initially associated to the given spectrum representation. Two levers are available here:<p>
<ul><li>If a minimal frequency range for the spectrum representation has been set (using the <code>'Min'</code> parameter), the frequency resolution of the spectrum is automatically set in order to meet that particular requirement.<p></li></ul>

> ![https://miningsuite.googlecode.com/svn/wiki/SigSpectrum_ex5.png](https://miningsuite.googlecode.com/svn/wiki/SigSpectrum_ex5.png)
> > _sig.spectrum('ragtime','Cents','Min',100)_

  * By increasing the frequency resolution of the spectrum (for instance by using the `'Res'` or `'MinRes'` parameters), the frequency range will be increased accordingly.

  * `mus.spectrum(…,'Collapsed')` collapses the cent-spectrum into one octave. In the resulting spectrum, the abscissa contains in total 1200 bins, representing the 1200 cents of one octave, and each bin contains the energy related to one position of one octave and of all the multiple of this octave.

## Flowchart Interconnections ##

Same as in [sig.spectrum](SigSpectrum.md).

## Defaults Specification ##

Particular default is set for the following parameter:
  * `’Phase’` is set to 0.

## Accessible Output ##

Same as in [sig.spectrum](SigSpectrum.md).