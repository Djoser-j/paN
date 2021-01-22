' *********************************************************
'Subject: p-adic arithmetic: transcendental functions
'Code   : FreeBasic 1.06.0

#include "pan_lib.bi"
#inclib "pan_arith"

'Input in 'big O' notation: -2/3 + O(7^9)
'--------------------------------------
function diff (byref a as padic, byref b as padic) as integer
dim v as integer, p as long
dim c as padic

   c.subt(a, b)
   c.printf(1)
   v = c.vp
   p = getp
   'absolute value
   print "|.|_p = ";
   print iif(v > 0,"1/"+str(p^v),str(p^-v))
return v
end function

dim as double tim = timer
dim as integer i, j, v0, fl, sw
dim as padic h(1), a, b, u, v
dim g as string, p as long
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
   print : ? "d(a, b)"
   v0 = diff(a, b)

   setsw(0)

   'check formal properties

   i = a.vp
   fl = (i = 0 and a.d(0) = 1)
   if fl then

      u.bino(a, b)
      print : ? "a ^ b"
      u.printf(1)

      v.inv(b)
      print : ? "1 / b"
      v.printf(1)
      v.bino(u, v)
      print : ? "(a ^ b) ^ 1/b"
      v.printf(1)


      u.logp(a)
      print : ? "log(a)"
      u.printf(0)

      v.expp(u)
      print : ? "exp(log(a))"
      v.printf(1)
   end if

   j = b.vp
   sw = (j = 0 and b.d(0) = 1)
   if fl and sw then

      v.logp(b)
      print : ? "log(b)"
      v.printf(0)

      print : ? "d(log(a), log(b))"
      if diff(u, v) - v0 then
         print "log isometry: fail"
      end if

      u.expp(v)
      print : ? "exp(log(b))"
      u.printf(1)

      print : ? "log(uv)"
      u.mult(a, b)
      u.logp(u)
      u.printf(0)

      print : ? "log(u)+log(v)"
      u.logp(a)
      v.logp(b)
      v.add(u, v)
      v.printf(0)
   end if

   fl = iif(p > 2, i > 0, i > 1)
   if fl then

      u.expp(a)
      print : ? "exp(a)"
      u.printf(0)

      v.logp(u)
      print : ? "log(exp(a))"
      v.printf(1)
   end if

   sw = iif(p > 2, j > 0, j > 1)
   if fl and sw then

      v.expp(b)
      print : ? "exp(b)"
      v.printf(0)

      print : ? "d(exp(a), exp(b))"
      if diff(u, v) - v0 then
         print "exp isometry: fail"
      end if

      u.logp(v)
      print : ? "log(exp(b))"
      u.printf(1)

      print : ? "exp(a+b)"
      u.add(a, b)
      u.expp(u)
      u.printf(0)

      print : ? "exp(a)*exp(b)"
      u.expp(a)
      v.expp(b)
      v.mult(u, v)
      v.printf(0)
   end if

   setsw(0)

   print : ?
loop

print "timer:"; csng(timer - tim); "s"
system
