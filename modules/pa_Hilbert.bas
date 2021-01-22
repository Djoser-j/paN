' *********************************************************
'Subject: p-adic arithmetic: invert Hilbert matrix
'Code   : FreeBasic 1.06.0

#include "pan_lib.bi"
#inclib "pan_arith"

'--------------------------------------
'print (augmented) matrix
sub mprint (a() as padic, f() as integer, byval m as integer, byval n as integer, byval sw as integer)
dim as integer i, j

for i = 1 to m
   print "i"; i

   for j = 1 to n
      if j = (m + 1) then print "V"
      a(f(i), j).printf(sw)
   next j
next i
end sub

dim as double tim = timer
dim as integer j, i, t, fi, ft
dim as integer m, u, vx, sg
dim as padic a, b, c
dim g as string
dim q as ratio
width 64, 30
cls

do
print

'set prime and precision
input " 1 + O(p^e)"; g
i = a.cpan(parse(g), 1)
if i = -1 then continue do

input "order"; m
if i or (m < 1) then exit do

'--------------------------------------
u = m shl 1
dim Hm(1 to m, 1 to u) as padic
dim Zm(1 to m, 1 to u) as padic
dim Xm(1 to m, 1 to m) as padic
dim f(1 to m) as integer

print : ? "Order";m;" Hilbert matrix" : ?

for i = 1 to m
   print "t"; i

   for j = 1 to m
      q.a = 1
      q.b = i + j - 1
      with Hm(i, j)
        .cpan(q, 1)
        .printf(0)
      end with
   next j

   'augment with identity matrix
   Hm(i, m + i).d(0) = 1
   'row index
   f(i) = i
next i

'copy into Zm()
for i = 1 to m
   for j = 1 to m + m
      Zm(i, j) = Hm(i, j)
   next j
next i

'Determinant
b.zero
b.d(0) = 1
'sign
sg = 0

'reduce H to upper triangular form
for t = 1 to m

   vx = -Hm(f(t), t).vp
   fi = t
   'search pivot
   for i = t + 1 to m
      u = -Hm(f(i), t).vp
      if u > vx then vx = u: fi = i
   next i

   if fi > t then
      swap f(fi), f(t)
      sg = 1 - sg
   end if

   ft = f(t)
   'determinant update
   b.mult(b, Hm(ft, t))

   'forward elimination
   for i = t + 1 to m
      fi = f(i)
      c.div(Hm(fi, t), Hm(ft, t))

      for j = t + 1 to m + m
         a.mult(c, Hm(ft, j))
         Hm(fi, j).subt(Hm(fi, j), a)
      next j

      Hm(fi, t).zero
   next i
next t

print : ? "Det ";
if sg then b.cmpt(b)
b.printf(1)

print : ? "U and V"
mprint(Hm(), f(), m, m + m, 1)

'back substitution
for i = m to 1 step -1
   fi = f(i)

   for t = 1 to m
      c = Hm(fi, t + m)

      for j = i + 1 to m
         a.mult(Hm(fi, j), Xm(f(j), t))
         c.subt(c, a)
      next j

      Xm(fi, t).div(c, Hm(fi, i))
   next t
next i

print : ? "inverse H"
mprint(Xm(), f(), m, m, 1)

print : ? "error check"
for t = 1 to m
   print "t";t

   for i = 1 to m
      fi = f(i)
      c = Zm(fi, t + m)

      for j = 1 to m
         a.mult(Zm(fi, j), Xm(f(j), t))
         c.subt(c, a)
      next j

      if not Is0(c) then
         print "i";fi;" ";
         c.printf(0)
      end if
   next i
next t

loop

print : ? "timer:"; csng(timer - tim); "s"
system
