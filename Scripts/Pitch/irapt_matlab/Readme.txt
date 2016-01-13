Readme file for the IRAPT package.

1. The package

The package contains a Matlab (R2009b) implementation of the instantaneous robust algorithm for pitch tracking (IRAPT). A short algorithm description
is given in Azarov, E., Vashkevich, M. and Petrovsky, A., "Instantaneous pitch estimation based on RAPT framework" to appear in the Proc.
of EUSIPCO'2012,  Bucharest, Romania, August 27-31, 2012.

This piece of software is distributed in the hope that it will be useful for research purposes without any limitations to use, copy, modify,
or distribute it. The software is in the public domain so feel free to do whatever you want without any permissions of the authors.
However keep in mind that there is no any warranty (even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE) so use
it at your own risk.

2. Files	

The package includes the following files

Readme.txt 		 			- This readme file
Demo_sample_generation.m 			- Script for generation the test sample, that is placed into web_src directory
irapt_demo.m		 			- IRAPT demo

web_src\Demo_true_F0.mat 			- True pitch for the test sample
web_src\Demo.wav	 			- The test sample

IRAPT_web\dft_fb.m	 			- Implementation of DFT-modulated filter bank for warped signal
IRAPT_web\F0_Bank_get_samples.m			- Implementation of DFT-modulated filter bank for source signal
IRAPT_web\Filter_no_offset.m			- Linear filtering with no offset
IRAPT_web\Get_harmonic_params.m			- Calculating instantaneous harmonic parameters from analytic subband signals
IRAPT_web\irapt.m				- Main interface function of the algorithm
IRAPT_web\irapt1.m				- IRAPT 1 implementation
IRAPT_web\irapt2.m				- IRAPT 2 implementation
IRAPT_web\My_unwrap.m				- A faster version of build in unwrap function
IRAPT_web\MyFit.m				- A faster version of build in linear interpolation
IRAPT_web\TakeHParams_whole_sig.m		- Calculation of instantaneous harmonic parameters for a given signal
IRAPT_web\ValueFunc_corr_line_FFT_interp.m	- Instantaneous period candidate generating function
IRAPT_web\warpingAnalyser.m			- Calculation of instantaneous harmonic parameters in warped time domain
IRAPT_web\Sinc_hash_1000.mat			- Impulse responses of ideal all-pass filters (sinc functions)

3. Configuration

All adjustable parameters of the algorithm are placed in irapt1.m (Cfg structure). The default parameters may not be optimal for speech applications.
Particularly smaller values of Cfg.f0_max_step can improve robustness of the pitch tracking, however will constrain maximum permissible pitch variations.

4. Authors

The authors: Elias Azarov (azarovis@yahoo.com) and Maxim Vashkevich (vashkevich.m@gmail.com),  Belarusian State University of Informatics and 
Radioelectronics 6, P.Brovky str., 220013, Minsk, Belarus.
You are welcome to send any questions, suggestions or error reports to us.