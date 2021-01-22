' *********************************************************
'Subject: p-adic arithmetic: logistic map iteration
'Ref.   : C.F. Woodcock and N.P. Smart,
'        `p-adic Chaos and Random Number Generation' (1998)
'Code   : FreeBasic 1.06.0

#include "pan_lib.bi"
#inclib "pan_arith"

'--------------------------------------
dim as double tim = timer
dim i as integer, p as long
dim g as string
dim as padic a, c

width 64, 30
cls

'initial point, prime and precision
input " a/b + O(p^e)"; g
a.cpan(parse(g), 1)
a.printf(0)
p = getp
print

if a.vp < 0 then
   print "logistic fail: abs_p(a) > 1"
   system
end if

'a <- (a^p - a) / p
for i = 1 to 1024
   c.powr(a, p)
   a.subt(c, a)
   a.v = 1
   a.shrt(1)
   if (i and 127) = 0 then
      ? i
      a.printf(0)
   end if
next i

print : ? "timer:"; csng(timer - tim); "s"
system
