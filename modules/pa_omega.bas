' *********************************************************
'Subject: p-adic Omega constant: solve w * exp_p(w) = q
'Code   : FreeBasic 1.06.0

#include "pan_lib.bi"
#inclib "pan_arith"

'Input in 'big O' notation: -2/3 + O(7^9)
'--------------------------------------

dim as double tim = timer
dim as integer i, t, k0, fl = -1
dim as padic w, a, x
dim as long p, q
dim g as string

width 64, 30
cls

print
do
   'set prime and precision
   input " 1 + O(p^e)"; g
   i = a.cpan(parse(g), 1)
   if i = -1 then continue do
   if i = 1 then exit do

   p = getp
   q = iif(p = 2, 4, p)
   t = iif(p = 2, 2, 1)

   k0 = a.k
   with w
     .zero
     'initial approximation q
     .d(t) = 1

      i = 1
     'Hensel lift
      while i shr 1 < k0
        .k = min(i + 1, k0)

         x.add(w, 1)
         x.shlt(t)  '(w + 1) * q
        .expp(w)
        .add(w, q)  '            / exp_p(w) + q
        .div(x, w)

         if fl then
            ? " w ";
           .printf(0)
         end if

         i shl= 1
      wend
     .k = k0

      print "omega"
     .printf(0)

      x.expp(w)
     .mult(w, x)
      print "w * exp_p(w)"
     .printf(1)
   end with

   print : ?
loop

print "timer:"; csng(timer - tim); "s"
system
