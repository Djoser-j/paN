' *********************************************************
'Subject: p-adic interpolation: twisted binomial series
'Code   : FreeBasic 1.06.0

#include "pan_lib.bi"
#inclib "pan_arith"

'----------------------------------------
'Input: string of p-adic digits separated
'by spaces, then a comma and prime p

dim as double tim = timer
dim as padic a(3), f(3), n, u, v, w, wp
dim as integer h, i, j, sw
dim as long a0, p
dim g as string
width 64, 30
cls

#macro diff(pa)
for i = 2 to 3
   u.subt(pa(i-1), pa(i))
   print "diff";i-1;" &";i
   u.printf(0)
   j = u.vp
   'absolute value
   print "|.|_p = ";
   print iif(j > 0,"1/"+str(p^j),str(p^-j))
next i
#endmacro

print "input: base and 3 close exponents"
do
   for i = 0 to 3
      input " p-adic digits and ',' p"; g, p
      sw = a(i).digits(g, p)
      if sw = 1 then exit do
      if sw then continue do

      if i = 0 then
         'echo prime and precision
         print "O(";str(getp);"^";str(a(i).k);")"
      end if
      a(i).printf(1)
   next i

   if a(0).vp then
      print "fail: no unit base"
      continue do
   end if

   for i = 1 to 3
      j = a(i).vp
      if j < 0 then
         print "fail: abs_p(exponent) > 1"
         continue do
      end if

      h = a0: a0 = a(i).d(j)
      if i > 1 and a0 <> h then
         print "fail: exponent mismatch"
         continue do
      end if
   next i

   setsw(0)

   p = getp
   a0 mod= p - 1

   w.teichm(a(0))
   print : ? "w(n)"
   w.printf(0)

   n.div(a(0), w)
   print : ? "{n}"
   n.printf(0)

   wp.powr(w, a0)
   print : ? "d0:";a0;", w(n)^d0"
   wp.printf(0)

   print
   for i = 1 to 3
      u.bino(n, a(i))
      print : ? "{n}^a";str(i)
      u.printf(0)

      f(i).mult(wp, u)
      print : ? "f(";str(i);") =";
      f(i).printf(0)

      if p = 7 and i = 2 then
        'case 16 ^ 1/2
         v.mult(f(i), w)
         print "f(2) * w =";
         v.printf(0)
      end if

      'check
      v.teichm(f(i))
      u.div(f(i), v)
      v.inv(a(i))
      u.bino(u, v)
      u.mult(u, w)
      u.subt(a(0), u)
      if not Is0(u) then
         print : ? "fail"
         u.printf(0)
      end if
   next i

   print : ? : ? "exponents"
   diff(a)
   print : ? "f values"
   diff(f)

   setsw(0)

   print : ?
loop

print "timer:"; csng(timer - tim); "s"
system
