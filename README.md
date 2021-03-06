p-adic number arithmetic library  
 ==============================
paN is a FreeBasic library for computing with p-adic numbers.  
Unpack to the base directory of your FreeBasic installation.  
  
The maximum precision is fixed at compile time,  
it's set as emx in include file \modules\pan_lib.bi  
This file doubles as library documentation.  
  
Rational reconstruction is done with  
signed 64-bit integers, thus has a limited range.  
  
  
### Contents of the paN packet  
  
  
Makefiles are in the **base directory**  
  
1_make_pan_dll.bat  
2_make_pa_demos.bat  
3_run_all_demos.bat  
  
\_make_one_demo.bat  
\_run_one_demo.bat  
  
  
#### paN\library\  
  
pan_arith.bas  
  fixed point p-adic number arithmetic for FreeBasic  
  
libpan_arith.dll.a  
  pan_arith import library  
  
  
#### paN\modules\bin\  
  
pan_arith.dll  
  pan_arith dynamic link library  
  
#### paN\modules\  
  
pan_lib.bi  
  Include file for p-adic number arithmetic  
  
pa_first.bas  
  First steps: input conversion and basic arithmetic  
  
pa_logistic.bas  
  Iterating the logistic map  
  
pa_Hilbert.bas  
  Inverting an order m Hilbert matrix  
  
pa_roots.bas  
   square roots and Teichmüller characters  
  
pa_trans.bas  
  Transcendental functions: formal properties  
  (exp_p, log_p and binomial)  
  
pa_twist.bas  
  p-adic interpolation: twisted binomial series  
  
pa_omega.bas  
  p-adic omega constant: solve w * exp_p(w) = q  
  
pa_gamma.bas  
  Morita's p-adic analogue of the gamma function  
  
pa_agM.bas  
  p-adic arithmetic-geometric Mean  
  
  
#### paN\workdir\  
  Plain text input files  
  
   
  
#### Copyright:  
        (C) 2021 Djoser.j.Spacher, All rights reserved  
  
#### License:  
        GNU General Public License, GPL  
  
      ______________________________________________  
  
Hensel, K., ['Über eine neue Begründung der Theorie der algebraischen Zahlen,'](http://www.digizeitschriften.de/dms/resolveppn/?PID=GDZPPN00211612X) 1897  
  
Krishnamurthy et al., ['Finite segment p-adic number systems,'](https://www.ias.ac.in/public/Volumes/seca/081/02/0058-0079.pdf) 1975  
  
Weger, B. de, ['Approximation lattices of p-adic numbers,'](http://www.sciencedirect.com/science/article/pii/0022314X86900594/pdf) 1986  
  
Gouvêa, F., *p-adic Numbers - An introduction*, Springer-Verlag, 1997  
  
Caruso, X., ['Computations with p-adic numbers,'](https://hal.archives-ouvertes.fr/hal-01444183/document) (pp.1-31), 2017  
  
[The FreeBASIC compiler](https://sourceforge.net/projects/fbc/files/)  
