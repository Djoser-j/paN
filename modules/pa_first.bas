' *********************************************************
'Subject: p-adic arithmetic: simple sums
'Code   : FreeBasic 1.06.0

#include "pan_lib.bi"
#inclib "pan_arith"

'--------------------------------------
'Input in 'big O' notation: -2/3 + O(7^9)

dim as double tim = timer
dim as padic a, b, c, u, v, h(1)
dim g as string, p as long
dim as integer sw, i
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

print "timer:"; csng(timer - tim); "s"
system
