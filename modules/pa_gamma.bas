' *********************************************************
'Subject: p-adic gamma-function
'Ref.   : Morita, Y - A p-adic analogue of the Γ-function (1975)
'Code   : FreeBasic 1.06.0

#include "pan_lib.bi"
#inclib "pan_arith"


const pe = 22
'limited precision: pe higher than ~22
'results in overlong computation times
if pe > 30 then
   print "overflow: gamma": end
end if

'prime power maximum
const pmx = (1 shl (pe + 1)) - 1


'Input in 'big O' notation: -2/3 + O(7^8)
'--------------------------------------
dim as double tim = timer
dim as longint g, n, lp, p1, pk, s
dim h as string, q as ratio
dim as integer i, p, t, sw
dim as padic a, c

width 64, 30
cls

print

do
   input " a/b + O(p^e)"; h
   sw = a.cpan(parse(h), 1)
   if sw = 1 then exit do
   if sw then continue do
   a.printf(0)
   print

   with a
      if .vp < 0 then
         print "gamma: domain error"
         continue do
      end if

      p = getp: lp = p

      'R=>L power sum
      s = 0: pk = 1
      for i = 0 to .k - 1 +.v
         p1 = pk: pk *= lp

         if pk > pmx then
            pk = p1: exit for
         end if

         s +=.d(i) * p1 '(mod pk)
      next i

      t = min(i, .k)
   end with

   print " lift";s;" mod";pk

   i = 1
   'initialize product
   g = iif((s and 1) = 1,-1, 1)
   'approach s through integers n
   for n = 2 to s - 1
      i += 1
      if p - i then
         g *= n
         g mod= pk
      else
        'sieve p-multiples
         i = 0
      end if
   next n

   q.a = g: q.b = 1
   c.cpan(q, 0)
   c.k = t
   print : ? "gamma"
   c.printf(1)

   print : ?
loop

print "timer:"; csng(timer - tim); "s"
system
