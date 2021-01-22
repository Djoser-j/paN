' *********************************************************
'Subject: p-adic arithmetic: alternative input
'Code   : FreeBasic 1.06.0

#include "pan_lib.bi"
#inclib "pan_arith"

'--------------------------------------
'Input: two strings of p-adic digits
'separated by spaces, with primes p

dim as padic a, b, c, u, v, h(1)
dim g as string, p as long
dim as integer i, sw
width 64, 30
cls

print
do
   for i = 0 to 1
      input " p-adic digits and p"; g, p
      sw = (g = "" or g = "0")
      if sw or (p < 2) then exit do
      h(i).digits(g, p)
      'echo prime and precision
      print "O(";str(getp);"^";str(h(i).k);")"
      h(i).printf(1)
   next i
   a = h(0)
   b = h(1)

   u.add(a, b)
   print : ? "a + b"
   u.printf(1)

   v.subt(a, b)
   print : ? "a - b"
   v.printf(1)
   i = v.vp
   'absolute value
   print "|.|_p = ";
   print iif(i > 0,"1/"+str(p^i),str(p^-i))

   c.mult(u, v)
   print : ? "a^2 - b^2"
   c.printf(1)

   c.div(u, v)
   print : ? "(a+b)/(a-b)"
   c.printf(1)

   c.inv(c)
   print : ? "(a-b)/(a+b)"
   c.printf(1)

   c.mult(c, u)
   c.add(c, b)
   c.subt(c, a)
   if not Is0(c) then
      print : ? "fail"
      c.printf(0)
   end if

   print : ?
loop

system
