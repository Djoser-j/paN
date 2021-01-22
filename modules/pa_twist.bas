' *********************************************************
'Subject: p-adic arithmetic: twisted binomial series
'Code   : FreeBasic 1.06.0

#include "pan_lib.bi"
#inclib "pan_arith"

'--------------------------------------
'Input in 'big O' notation: -2/3 + O(7^9)

dim as double tim = timer
dim as integer i, j, sw
dim as padic h(1), a, b
dim as padic u, v, w0, w
dim as long b0, p
dim g as string
width 64, 30
cls

print
do
   for i = 0 to 1
      input " a/b + O(p^e)"; g
      sw = h(i).cpan(parse(g), 1)
      if sw = 1 then exit do
      if sw then continue do
      h(i).printf(0)
   next i
   a = h(0)
   b = h(1)
   p = getp

   setsw(0)

   i = a.vp
   if i then
      a.shrt(i)
      print : ? "a shifted"
      a.printf(1)
   end if

   if a.d(0) = 1 then
      u.bino(a, b)
      print : ? "a^b"
      u.printf(1)
      print : ?
      continue do
   end if

   print : ? "twist"
   w.teichm(a)
   print : ? "w(a)"
   w.printf(0)
   w0 = w

   u.div(a, w)
   print : ? "{a}"
   u.printf(1)

   u.bino(u, b)
   print : ? "{a}^b"
   u.printf(1)

   j = b.vp
   b0 = b.d(j) mod (p - 1)
   v.powr(w, b0)
   print : ? "b0";b0;", w(a)^b0"
   v.printf(0)

   u.mult(v, u)
   print : ? "u = w(a)^b0 * {a}^b"
   u.printf(0)

   print
   w.teichm(u)
   print : ? "w(u) = w(a)^b0"
   w.printf(0)

   u.div(u, w)
   print : ? "{u} = {a}^b"
   u.printf(1)

   v.inv(b)
   print : ? "1 / b"
   v.printf(1)

   u.bino(u, v)
   print : ? "{u}^1/b = {a}"
   u.printf(1)

   u.mult(w0, u)
   u.shlt(i)
   print : ? "a = w(a) * {a}"
   u.printf(1)

   setsw(0)

   print : ?
loop

print "timer:"; csng(timer - tim); "s"
system
