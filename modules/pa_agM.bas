' *********************************************************
'Subject: p-adic arithmetic-geometric Mean
'Code   : FreeBasic 1.06.0

#include "pan_lib.bi"
#inclib "pan_arith"

'--------------------------------------
'Input in 'big O' notation: -2/3 + O(7^9)

dim as double tim = timer
dim as integer i, t, sw, fl = 0
dim as padic h, a, b, c, u
dim q as ratio, p as long
dim g as string

width 64, 30
cls

#define Appr0(a) ((a.v >= a.k) orelse Is0(a))

#macro readpa(a)
   sw = a.cpan(parse(g), 1)
   if sw = 1 then exit do
   if sw then continue do
   a.printf(0)
#endmacro

do
   print
   input " a/b + O(p^e)"; g
   readpa(a)
   input " a/b + O(p^e)"; g
   readpa(b)
   p = getp

   u.div(b, a)
   if fl then
      print : ? "b/a"
      u.printf(1)
   end if

   t = u.vp
   sw = (t = 0 and u.d(0) = 1)
   if sw and (p = 2) then
      for i = 1 to 3
         sw and= u.d(i) = 0
      next i
   end if

   if sw = 0 then
      print "agM: domain error"
      continue do
   end if

  'let h:= 1 / 2
   q.a = 1: q.b = 2
   h.cpan(q, 0)

   do
      c.add(a, b)     '(a + b)
      if p > 2 then
         c.mult(c, h) '       / 2
      else
         c.v = 1
         c.shrt(1)
      end if

      b.bino(u, h)    'sqrt(a * b)
      if Is0(b) then
         print "fail: agM"
         exit do
      end if
      b.mult(a, b)
      a = c

      if fl then
         print "a";
         a.printf(0)
         print "b";
         b.printf(0)
      end if

      u.subt(a, b)
      if Appr0(u) then exit do

      u.div(b, a)
   loop

   if fl = 0 then
      print "agM"
      a.printf(1)
   end if

   print
loop

print "timer:"; csng(timer - tim); "s"
system
