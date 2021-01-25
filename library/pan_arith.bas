' ***********************************************
'Subject: p-adic arithmetic
'Author : Djoser.j.Spacher
'Code   : FreeBasic 1.06.0

#include once "pan_lib.bi"


'switch inversion method
#define iter_


'------------------------------------------------
'max. signed long
const Slng = (clngint(1) shl 31) - 1
'max. prime < 2^15
const Pmax = 32749

'global variables

'default prime
dim shared as long p = 127
'precision
dim shared as integer e = 9

'verbose mode
dim shared as integer Verb = 0

randomize timer

constructor padic export
   k = e
end constructor

'return the global prime
function getp as long export
getp = p
end function

'switch to verbose mode
sub setsw (byval sw as integer) export
   Verb = sw
end sub

'return the current mode
function getsw as integer export
getsw = Verb
end function

'------------------------------------------------
sub reduce (byref a as long, byref b as long) export
dim as long q, r(1) = {a, b}
dim as integer i = 0, j = 1

   while r(i)
      swap i, j
      q = r(i) \ r(j)
      r(i) -= q * r(j)
   wend
   'gcd
   q = abs(r(j))
   if q > 1 then a \= q: b \= q
end sub

sub reduce (byref a as longint, byref b as longint)
dim as longint q, r(1) = {a, b}
dim as integer i = 0, j = 1

   while r(i)
      swap i, j
      q = r(i) \ r(j)
      r(i) -= q * r(j)
   wend
   q = abs(r(j))
   if q > 1 then a \= q: b \= q
end sub

'return 1/a mod b
function invmod (byval a as long, byval b as long) as long
dim as long q, r(1) = {a, b}
dim as long s(1) = {1, 0}
dim as integer i = 0, j = 1

   while r(i)
      swap i, j
      'Euclidean steps
      q = r(i) \ r(j)
      r(i) -= q * r(j)
      s(i) -= q * s(j)
   wend
   if abs(r(j)) > 1 then return 0
   'modular inverse
   q = s(j)
return iif(q < 0, q + b, q)
end function

'parse input string
function parse (byref g as string) as ratio export
dim as const string tok = "'0123456789/O^-"
dim as integer i, j, t, fl = 0
dim as long a, b, n, k, c(3)
dim as ratio q
q.a = 0: q.b = 1

   for i = 1 to len(g)
      t = instr(tok, mid(g, i, 1))

      select case t
      case 0
         continue for
      case 1
         'echo comment
         print mid(g, i + 1)
         if fl then exit for
         return q

      case is < 12
         'build arguments
         j = fl and 3
         c(j) *= 10: c(j) += t - 2

      case is < 15
         'select argument
         fl shr= 2: fl shl= 2
         fl or= t - 11

      case else
         'negative argument
         fl or= 4
      end select
   next i

   a = c(0): b = c(1)
   'exit program
   if a = 0 then q.b = 0: return q
   'default
   if b = 0 then b = 1

   'max. short prime
   n = min(c(2), Pmax)
   if n > 1 then p = n

   'max. array length
   k = min(c(3), emx - 1)
   if k > 0 then e = k

   reduce(a, b)

   'bounds check
   if a > amx or b > amx then return q
   'negative fraction
   if fl and 4 then a = -a

   q.a = a: q.b = b
return q
end function

'convert q = a/b to p-adic number
function padic.cpan (byref q as ratio,_
 byval sw as integer) as integer export
dim as longint b1, a = q.a, b = q.b
dim i as integer
cpan = 0

   if b = 0 then return 1
   if a = 0 then return -1

   if sw then
      'echo numerator, denominator,
      print a;"/";str(b);" + ";
      'prime and precision
      print "O(";str(p);"^";str(e);")"
   end if

   'initialize
   zero

   i = 0
   'find -exponent of p in b
   do until b mod p
      b \= p: i -= 1
   loop

   'modular inverse
   b1 = invmod(b, p)
   if b1 = 0 then
      print "cpan: impossible inverse mod"
      return -1
   end if

   v = emx
   do
      'find exponent of p in a
      do until a mod p
         a \= p: i += 1
      loop

      'valuation
      if v = emx then v = i

      'upper bound
      if i >= emx then exit do
      'check precision
      if (i - v) > e then exit do

      'next digit
      d(i) = a * b1 mod p
      if d(i) < 0 then d(i) += p
      'now p divides a
      a -= d(i) * b
   loop while a
end function

'parse string of p-adic digits, set n = p
function padic.digits (byref g as string,_
 byval n as long) as integer export
dim as const string tok = "'0123456789 ."
dim as integer t, i, j = 0
dim b as padic
digits = 0

   n = min(n, Pmax)
   if n > 1 then p = n
   e = 1
   zero

   g = trim(g)
   if g = "" or g = "0" then
      return 1
   end if

   for i = 1 to len(g)
      t = instr(tok, mid(g, i, 1))

      select case t
      case 0
         continue for
      case 1
         'echo comment
         print mid(g, i + 1)
         return -1

      case is < 12
         'build terms
         d(k) *= 10
         d(k) += t - 2
         j = 1

      case else
         'valuation
         if t = 13 then v = k
         'next term
         k += j: j = 0
      end select

      if k >= emx then exit for
   next i
   k = min(k, emx - 1)

   t = (k - 1) shr 1
   'reverse
   for i = 0 to t
      swap d(i), d(k - i)
   next i

   e = k
   if v then
      v -= k
      'shift right
      for i = 0 to k
         d(i + v) = d(i)
      next i
   end if

   'normalize
   b.k = k
   add(this, b)
end function

'rational reconstruction
function padic.crat (byval fl as integer) as ratio export
dim as longint q, s, pk, p1
dim as longint a, b, x, y
dim as integer t, i, sw
dim as double f, g
dim as long m, n
dim r as ratio

   if Is0(this) then
      if fl then print " 0/1"
      r.a = 0: r.b = 1
      return r
   end if

   'most significant digit
   t = vp

   'R=>L power sum
   s = 0: pk = 1
   for i = t to k - 1 + v
      p1 = pk: pk *= p

      if pk \ p1 - p then
         'longint overflow
         pk = p1: exit for
      end if

      s += d(i) * p1 '(mod pk)
   next i

   'lattice basis
   a = pk: b = 0
   x = s : y = 1

   'reduction
   do
      sw = x < 0 and y > 0
      sw or= x > 0 and y < 0
      if sw then
         f = cdbl(a - b) / (x - y)
      else
         f = cdbl(a + b) / (x + y)

         if x = 0 or y = 0 then
            g = cdbl(a - b) / (x - y)
            f = max(f, g)
         end if
      end if

      'Euclidean step
      q = int(f +.5)
      a -= q * x
      b -= q * y

      'compare norms
      q = max(abs(a), abs(b))
      s = max(abs(x), abs(y))

      if q < s then
         'interchange vectors
         s = a: a = x: x = s
         s = b: b = y: y = s

      else
         exit do
      end if
   loop

   if y < 0 then y =-y: x =-x

   'check determinant
   sw = abs(a * y - x * b) = pk

   if sw and x then
      q = iif(t > 0, x, y)

      'adjust p-power in x or y
      for i = 1 to abs(t)
         s = q: q *= p
         if q \ s - p then
            q = s: exit for
         end if
      next i

      if t > 0 then x = q else y = q end if
      reduce(x, y)

      if i > abs(t) then
         t = 0
      else
         t -= iif(t > 0, i - 1, 1 + i)
      end if
   end if

   m = 0: n = 0
   if sw = 0 then
      print "crat: fail"

   else
      if abs(x) < Slng and y < Slng then
         m = x: n = y
      end if

      if fl then
         print x;
         if y > 1 then print "/";str(y);
         if t then print " *";p;" ^";t;
         print
      end if
   end if

   r.a = m: r.b = n
return r
end function

'print expansion
sub padic.printf (byval sw as integer) export
dim i as integer

   for i = k - 1 + v to v step -1
      print d(i);
      if i = 0 andalso v < 0 then print ".";
   next i

   if v > 0 or k < (1 - v) then ? " v";str(v);
   print

   'best rational approximation
   if sw then crat(sw)
end sub

'------------------------------------------------
'let self:= 0
sub padic.zero () export
dim i as integer
v = 0
k = e
   for i = -emx to emx - 1
      d(i) = 0
   next i
end sub

'scan right to left for nonzero d
'return i = k for vp = oo
function padic.vp () as integer export
dim i as integer
   for i = v to k - 1
      if d(i) then exit for
   next i
return i
end function

'scan left to right for nonzero d
'return i < 0 for self = 0
function padic.scan () as integer export
dim i as integer
   for i = k - 1 + v to v step -1
      if d(i) then exit for
   next i
return i - v
end function

'------------------------------------------------
'Euclidean division
#macro qstep(dt)
   q = c \ p
   dt = c - q * p
   c = q
#endmacro

'add & subt only:
#macro minmax
   if a.v < b.v then
     .v = a.v: u = b.v
   else
     .v = b.v: u = a.v
   end if
  .k = min(a.k, b.k)
#endmacro

'let self:= a + b
sub padic.add (byref a as padic, byref b as padic) export
dim as long q, c = 0
dim as integer i, u
dim r as padic
with r
   minmax

   for i = .v to .k + u
      c += a.d(i) + b.d(i)
      qstep(.d(i))
   next i
end with
this = r
end sub

'let self:= a + scalar
sub padic.add (byref a as padic, byval s as long) export
dim q as ratio, b as padic

   q.a = s: q.b = 1
   b.cpan(q, 0)
   add(a, b)
end sub

'let self:= a - b
sub padic.subt (byref a as padic, byref b as padic) export
dim as long q, c = 1, p1 = p - 1
dim as integer i, u
dim r as padic
with r
   minmax

   for i = .v to .k + u
      c += p1 + a.d(i) - b.d(i)
      qstep(.d(i))
   next i
end with
this = r
end sub

'let self:= complement_a
sub padic.cmpt (byref a as padic) export
dim as long q, c = 1, p1 = p - 1
dim i as integer, r as padic
with r
  .v = a.v
  .k = a.k

   for i = .v to .k +.v
      c += p1 - a.d(i)
      qstep(.d(i))
   next i
end with
this = r
end sub

'let self:= a * b
sub padic.mult (byref a as padic, byref b as padic) export
dim as long ptr ap, bp
dim as longint q, c = 0
dim as integer i, j
dim r as padic
with r
  .k = min(a.k, b.k)

   i = a.vp
   ap = @a.d(i)
   j = b.vp
   bp = @b.d(j)
  .v = i + j

   'zero product
   if max(i, j) =.k then
      zero : exit sub
   end if

   if (.k +.v) > (emx - 1) then
      print "mult: overflow"
      zero : exit sub
   end if

   for i = 0 to .k
      for j = 0 to i
         c += ap[j] * bp[i - j]
      next j
      qstep(.d(i +.v))
   next i

end with
this = r
end sub

'let self:= a * scalar
sub padic.mult (byref a as padic, byval s as long) export
dim q as ratio, b as padic

   q.a = s: q.b = 1
   b.cpan(q, 0)
   mult(a, b)
end sub

'let self:= a ^ m
sub padic.powr (byref a as padic, byval m as long) export
dim as padic r, u = a

if m < 0 then
   'inverse power
   u.inv(u): m = -m
elseif m = 0 then
   this = r: d(0) = 1
   exit sub
end if

with r
  'initialize
  .d(0) = 1
   'R=>L binary powering
   while m
      if m and 1 then .mult(r, u)
      u.mult(u, u)
      m shr= 1
   wend
end with
this = r
end sub

'let self:= a / b
sub padic.div (byref a as padic, byref b as padic) export
dim as long ptr ap, bp
dim as long b1, q, c, s
dim as integer i, j
dim as padic r, x = a, y = b
with r
  .k = min(x.k, y.k)

   i = x.vp
   ap = @x.d(i)
   j = y.vp
   bp = @y.d(j)
  .v = i - j

   'zero dividend
   if i =.k then
      this = a: exit sub
   end if

   if j =.k then
      print "div: zero divisor"
      this = b: exit sub
   end if

   b1 = invmod(bp[0], p)
   if b1 = 0 then
      print "div: impossible inverse mod"
      zero : exit sub
   end if

   y.cmpt(y)
   for i = 0 to .k
      s = ap[i] * b1 mod p
     .d(i +.v) = s

      c = 0
      'remainder - divisor * s
      for j = i to .k
         c += ap[j] + bp[j - i] * s
         qstep(ap[j])
      next j
   next i

end with
this = r
end sub

'let self:= a / scalar
sub padic.div (byref a as padic, byval s as long) export
dim q as ratio, b as padic

   q.a = 1: q.b = s
   b.cpan(q, 0)
   mult(a, b)
end sub

'let self * p^t
sub padic.shlt (byval t as integer) export
dim i as integer
if t < 1 then
   if t then shrt(-t)
   exit sub
end if

   v += t
   for i = k + v to v step -1
      d(i) = d(i - t)
   next i
   for i = v - t to v - 1
      d(i) = 0
   next i
end sub

'let self / p^t
sub padic.shrt (byval t as integer) export
dim i as integer
if t < 1 then
   if t then shlt(-t)
   exit sub
end if

   v -= t
   for i = v to k + v
      d(i) = d(i + t)
   next i
end sub

'------------------------------------------------
#ifndef iter

'let self:= 1 / a
sub padic.inv (byref a as padic) export
dim u as padic
   u.d(0) = 1
   div(u, a)
end sub

#else

'let self:= 1 / a
sub padic.inv (byref a as padic) export
dim as integer fl = (Verb and 1) <> 0
dim as integer i, t, k0
dim as padic r, h, x, u = a
dim q as ratio

k0 = u.k
t = u.vp

if t = k0 then
   print "inv: zero divisor"
   this = a: exit sub
end if

'shift divisor
u.shrt(t)

if p > 2 then
  'let h:= 2
   q.a = 2: q.b = 1
   h.cpan(q, 0)
end if

with r
  'initial approximation
  .d(0) = invmod(u.d(0), p)

   if fl then ? "d0"; .d(0)

   i = 1
   while i shr 1 < k0
     .k = min(i + 1, k0)

      x.mult(r, u)
      x.mult(x, r)
      if p > 2 then
        .mult(r, h)
      else
        .v = -1
        .shlt(1) ' 2x -
      end if
     .subt(r, x) '      x * a * x

      if fl then
         ? " r ";
        .printf(0)
      end if

      i shl= 1
   wend

  .k = k0
  'shift quotient
  .shrt(t)
end with
this = r
end sub

#endif

'------------------------------------------------
'let self:= sqrt(a)
sub padic.sqrt (byref a as padic) export
dim as integer fl = (Verb and 1) <> 0
dim as integer i, t, k0
dim as padic r, h, x, u = a
dim as long f, s
dim q as ratio

k0 = u.k
t = u.vp
'zero argument
if t = k0 then
   this = a: exit sub
end if

'shift radicand
u.shrt(t)

i = (t and 1) = 1
if p = 2 then
   i or= u.d(1) = 1 or u.d(2) = 1
end if
if i then
   print "sqrt: non-residue mod"
   this = r: exit sub
end if

if p > 2 then
  'let h:= 1 / 2
   q.a = 1: q.b = 2
   h.cpan(q, 0)
end if

'find root for small p
for s = 1 to p - 1
   f = s * s - u.d(0)
   if f mod p = 0 then exit for
next s

if s = p then
   print "sqrt: non-residue mod"
   this = r: exit sub
end if

with r
  'initial approximation
  .d(0) = s

   if fl then ? "d0"; .d(0)

   i = 1
   while i shr 1 < k0
     .k = min(i + 1, k0)

      x.div(u, r)   '(a / x
     .add(x, r)     '       + x)
      if p > 2 then
        .mult(r, h) '           / 2
      else
        .v = 1
        .shrt(1)
      end if

      if fl then
         ? " r ";
         .printf(0)
      end if

      i shl= 1
   wend

  .k = k0
  'shift the root
  .shlt(t shr 1)
end with
this = r
end sub

'------------------------------------------------
'let self:= Teichmüller character for a
'here p is supposed to be prime !
sub padic.teichm (byref a as padic) export
dim as integer fl = (Verb and 1) <> 0
dim as long a0, m = p - 1
dim as integer i, t, k0
dim as padic r, h, x, y
dim q as ratio

k0 = a.k
t = a.vp
'w(0) = 0
if t = k0 then
   this = a: exit sub
end if

a0 = a.d(t)

'1-unit
if a0 = 1 then
   this = r: d(0) = 1
   exit sub
end if

'w(p-1) = -1
if a0 = m then
   this.add(r, -1)
   exit sub
end if

if invmod(a0, p) = 0 then
   print "teichm: gcd(a, p) > 1"
   this = r: exit sub
end if

'let h:= 1 / (p - 1)
q.a = 1: q.b = m
h.cpan(q, 0)

with r
  'initial approximation
  .d(0) = a0

   if fl then ? "d0";.d(0)

   i = 1
   while i shr 1 < k0
     .k = min(i + 1, k0)

      x.mult(r, m - 1) ' (m - 1) * x
      y.powr(r, 1 - m) '  1 / x ^ (m - 1)
     .add(x, y)
     .mult(r, h)       '  sum / m

      if fl then
         ? " r ";
        .printf(0)
      end if

      i shl= 1
   wend

  .k = k0
end with
this = r
end sub

'------------------------------------------------
'for p-adic integers only
#define Appr0(a) ((a.v >= a.k) orelse Is0(a))

'let self:= log_p(a)
sub padic.logp (byref a as padic) export
dim as integer fl = Verb
dim as padic s, x, t, u
dim i as integer

u.add(a, -1)

if fl then
   ? "u";
   u.printf(1)
end if

if u.vp < 1 then
   print "logp: domain error"
   this = s: exit sub
end if

x = u
s = u

if fl then
   ? "s1";
   s.printf(1)
end if

i = 1
do
   i += 1
   t.div(u, i)  ' u / i
   t.mult(x, t) '       * x^i-1

   x.mult(x, u) ' x^i-1 * u

   if fl and 2 then
      ? "t";str(i);
      t.printf(0)
   end if

   if Appr0(t) then exit do

   if (i and 1) = 1 then
      s.add(s, t)
   else
      s.subt(s, t)
   end if

   if fl then
      ? "s";str(i);
      s.printf(1)
   end if
loop
this = s
end sub

'let self:= exp_p(a)
sub padic.expp (byref a as padic) export
dim as integer fl = Verb
dim as padic s, x, t
dim as integer i, sw

if fl then
   ? "a";
   a.printf(1)
end if

i = a.vp
sw = iif(p > 2, i < 1, i < 2)
if sw then
   print "expp: domain error"
   this = s: exit sub
end if

x = a
s.add(a, 1)

if fl then
   ? "s1";
   s.printf(1)
end if

i = 1
do
   i += 1
   t.div(a, i)  ' a / i

   x.mult(x, t) '       * x^i-1

   if fl and 2 then
      ? "x";str(i);
      x.printf(0)
   end if

   if Appr0(x) then exit do

   s.add(s, x)

   if fl then
      ? "s";str(i);
      s.printf(1)
   end if
loop
this = s
end sub

'let self:= a ^ c
sub padic.bino (byref a as padic, byref c as padic) export
dim as integer fl = Verb
dim as padic s, x, b, t, u
dim as integer i, sw

u.add(a, -1)

if fl then
   ? "u";
   u.printf(1)
   ? "c";
   c.printf(1)
end if

i = u.vp
sw = i < 1
i += c.vp
sw or= iif(p > 2, i < 1, i < 2)
if sw then
   print "bino: domain error"
   this = s: exit sub
end if

x.mult(c, u)
s.add(x, 1)

if fl then
   ? "s1";
   s.printf(1)
end if

i = 1
do
   i += 1
   t.div(u, i)   ' u / i

   b.add(c, 1 - i)
   t.mult(b, t)  '       * binomial term

   x.mult(x, t)  '                       * x^i-1

   if fl and 2 then
      ? "x";str(i);
      x.printf(0)
   end if

   if Appr0(x) then exit do

   s.add(s, x)

   if fl then
      ? "s";str(i);
      s.printf(1)
   end if
loop
this = s
end sub

'------------------------------------------------
'let self:= random p-adic number
'seed a, set sw to initialize
sub padic.rndp (byref a as padic, byref sw as integer) export
const f = cdbl(1)/17
static r as padic
dim c as padic, t as integer

if sw then
   r = a: sw = 0
   'unit
   r.shrt(a.vp)
end if

with r
   if rnd < f then
     'kick
      t = 1 + int(rnd * (p - 1))
     .add(r, t)
   end if

  'r <- (r^p - r) / p
   c.powr(r, p)
  .subt(c, r)
  .v = 1
  .shrt(1)

   t = .k shr 2
   t = int((rnd -.5) * t +.5)
end with
this = r
v = vp
shlt(t)
end sub
