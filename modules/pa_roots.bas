' ***********************************************
'Subject: p-adic arithmetic: roots
'Code   : FreeBasic 1.06.0

#include "pan_lib.bi"
#inclib "pan_arith"

'--------------------------------------
'Input in 'big O' notation: -2/3 + O(7^9)

dim as double tim = timer
dim g as string, p as long
dim as integer i, sw
dim as padic a, b, c

width 64, 30
cls

'return true if a / p^vp(a) is a 1-unit
#define Is1u(a) (a.d(a.v) = 1)

setsw(1)

print
do
   input " a/b + O(p^e)"; g
   sw = a.cpan(parse(g), 1)
   if sw = 1 then exit do
   if sw then continue do
   a.printf(0)

   c.sqrt(a)
   if not Is0(c) then
      print : ? "sqrt(a)"
      c.printf(0)

      c.mult(c, c)
      print : ? "sqrt(a) ^ 2"
      c.printf(1)
   end if
   print

   p = getp
   if (p > 2) and not Is1u(a) then
      c.teichm(a)
      print : ? "Teichmüller character"
     '(p-1)th root of unity with r = a / p^vp(a) (mod p)
      c.printf(0)

      sw = not Is1(c) and (p < 31)
      if sw then
         b = c
         print : ? "cycle"
         for i = 2 to p - 1
            b.mult(b, c)
            print i;":";
            b.printf(0)
            if Is1(b) then exit for
         next i
      end if
   end if

   print : ?
loop

print "timer:"; csng(timer - tim); "s"
system
