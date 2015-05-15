# sig.cepstrum: Spectral analysis of spectrum #

The harmonic sequence can also be used for the detection of the fundamental frequency itself. One idea is to look at the spectrum representation, and try to automatically detect these periodic sequences. And one simple idea consists in performing a Fourier Transform of the Fourier Transform itself, leading to a so-called cepstrum (Bogert et al., 1963).

So if we take the complex spectrum (_Xk_ in the equation defining `'sig.spectrum'`), we can operate the following chain of operations:<p>

<img src='https://miningsuite.googlecode.com/svn/wiki/SigCepstrum_ex1.png' />

<ul><li>First a logarithm is performed in order to allow an additive separability of product components of the original spectrum. For instance, for the voice in particular, the spectrum is composed of a product of a vocal cord elementary burst, their echoes, and the vocal track. In the logarithm representations, these components are now added one to each other, and we will then be able to detect the periodic signal as one of the components.</li></ul>

<ul><li>Then because the logarithm provokes some modification of the phase, it is important to ensure that the phase remains continuous.</li></ul>

<ul><li>Finally the second Fourier transform is performed in order to find the periodic sequences. As it is sometime a little difficult to conceive what a Fourier transform of Fourier transform is really about, we can simply say, as most say, that it is in fact an Inverse Fourier Transform (as it is the same thing, after all), and the results can then be expressed in a kind of temporal domain, with unit called “quefrency”.</li></ul>

For instance for this spectrum:<p>

<img src='https://miningsuite.googlecode.com/svn/wiki/SigCepstrum_ex2.png' />

we obtain the following cepstrum:<p>

<img src='https://miningsuite.googlecode.com/svn/wiki/SigCepstrum_ex3.png' />

The cepstrum can also be computed from the spectrum amplitude only, by simply taking the logarithm, and directly computing the Fourier transform.<p>

<img src='https://miningsuite.googlecode.com/svn/wiki/SigCepstrum_ex4.png' />

In this case, the phase of the spectrum is not computed.<br>
<br>
<br>
<h2>Flowchart Interconnections</h2>

<code>'sig.cepstrum'</code> accepts either:<br>
<br>
<ul><li><code>'sig.spectrum'</code> objects, or<p>
</li><li><code>'sig.input'</code> objects (same as for <code>'sig.spectrum'</code>),<p>
</li><li>file name(s) or the <code>'Folder'</code> keyword.</li></ul>

<br>
<h2>Frame decomposition</h2>

<code>sig.cepstrum(…,'Frame',…)</code> performs first a frame decomposition, with by default a frame length of 50 ms and half overlapping. For the specification of other frame configuration using additional parameters, cf. the previous SigFrame vs. <i>'Frame'</i> section.<br>
<br>
<br>
<br>
<h2>Parameter specifications</h2>

<ul><li><code>sig.cepstrum(…,'Freq')</code>: The results can be represented, instead of using the quefrency domain (in seconds), back to the frequency domain (in Hz) by taking the inverse of each abscissae value. In this frequency representation, each peak is located on a position that directly in dicates the associated fundamental frequency.<p>
</li><li><code>sig.cepstrum(…,'Min',</code><i>min</i><code>)</code> specifies the lowest delay taken into consideration, in seconds. Default value: 0.0002 s (corresponding to a maximum frequency of 5 kHz). This default value is not set to 0 s in order to exclude the very high peaks confined in the lowest quefrency region: these high peaks seem to come from the fact that the spectrum is a non-centered signal, thus with high (quasi-)stationary energy. However, the value can be forced to 0 using this <code>'Min'</code> option.<p>
</li><li><code>sig.cepstrum(…,'Max',</code><i>max</i><code>)</code> specifies the highest delay taken into consideration, in seconds. Default value: 0.05 s (corresponding to a minimum frequency of 20 Hz). This default value is not set to Inf in order to exclude the very high peaks confined in the highest quefrency region: these high peaks seem to come from the fact that the spectrum is a highly variable signal, thus with high energy on its highest frequencies. However, the value can be forced to Inf using this <code>'Max'</code> option.<p>
</li><li><code>mircepstrum(…,'Complex')</code> computes the cepstrum using the complex spectrum. By default, the cepstrum is computed from the spectrum amplitude only.</li></ul>

<br>
<h2>Accessible Output</h2>

<ul><li><code>Phase</code>: the phase related to the magnitude.