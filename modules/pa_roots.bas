' ***********************************************
'Subject: p-adic arithmetic: roots
'Code   : FreeBasic 1.06.0

#include "pan_lib.bi"
#inclib "pan_arith"

'--------------------------------------
'Input in 'big O' notation: -2/3 + O(7^9)

dim as double tim = timer
dim as integer i, sw, fl = -1
dim as padic a, b, c
dim g as string
dim p as long
width 64, 30
cls

'is 1-unit a ?
#define Is1u(a) (a.d(0) = 1)

setsw(1)

print
do
   input " a/b + O(p^e)"; g
   sw = a.cpan(parse(g), 1)
   if sw = 1 then exit do
   if sw then continue do
   a.printf(0)

   p = getp
   if (p > 2) and not Is1u(a) then
      print : ? "Teichmüller character for a"
      'root of unity with r = a (mod p)
      c.teichm(a)
      c.printf(0)

      sw = not Is1(c)
      sw and= p < 31
      if fl and sw then
         b = c
         for i = 2 to p - 1
            b.mult(b, c)
            print : ? "check";i
            b.printf(0)
         next i
      end if
      print
   end if

   c.sqrt(a)
   print : ? "sqrt(a)"
   c.printf(0)

   c.mult(c, c)
   print : ? "sqrt(a) ^ 2"
   c.printf(1)

   print : ?
loop

print "timer:"; csng(timer - tim); "s"
system
