p-adic number arithmetic library  
 ==============================
paN is a FreeBasic library for computing with p-adic numbers.  
Unpack to the base directory of your FreeBasic installation.  
  
The maximum precision is fixed at compile time,  
it's set as emx in include file \modules\pan_lib.bi  
This file doubles as library documentation.  
  
  
### Contents of the paN packet  
  
  
Makefiles are in the **base directory**  
(-W1ndows only, but easy to adapt):  
  
1_make_pan_dll.bat  
2_make_pa_demos.bat  
3_run_all_demos.bat  
  
\_make_one_demo.bat  
\_run_one_demo.bat  
  
  
#### paN\library\  
  
pan_arith.bas  
  p-adic number arithmetic realized in FreeBasic  
  
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
  (p - 1)th roots of unity and square roots  
  
pa_trans.bas  
  Transcendental functions: formal properties  
  (exp_p, log_p and binomial)  
  
pa_twist.bas  
  Twisting the binomial series  
  
pa_gamma.bas  
  Morita's p-adic analogue of the gamma function  
  
  
#### paN\workdir\  
  Plain text input files  
  
   
  
#### Copyright:  
        (C) 2020 Djoser.j.Spacher, All rights reserved  
  
#### License:  
        GNU General Public License, GPL  
  
      ______________________________________________  
  
Hensel, K., ['Über eine neue Begründung der Theorie der algebraischen Zahlen,' 1897]
(http://www.digizeitschriften.de/dms/resolveppn/?PID=GDZPPN00211612X)  
  
Krishnamurthy et al., ['Finite segment p-adic number systems,' 1975]
(https://www.ias.ac.in/public/Volumes/seca/081/02/0058-0079.pdf)  
  
Weger, B. de, ['Approximation lattices of p-adic numbers,' 1986]
(http://www.sciencedirect.com/science/article/pii/0022314X86900594/pdf)  
  
Gouvêa, F., *p-adic Numbers - An introduction*, Springer-Verlag, 1997  
  
Caruso, X., ['Computations with p-adic numbers,' (pp.1-31) 2017]
(https://hal.archives-ouvertes.fr/hal-01444183/document)  
  
[The FreeBASIC compiler](https://sourceforge.net/projects/fbc/files/)  
  
