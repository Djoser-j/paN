' ***********************************************
'Subject: Include file for p-adic arithmetic.
'Author : Djoser.j.Spacher
'Code   : FreeBasic 1.06.0


'you can change this and recompile:

const emx = 68
'exponent maximum

const te = 20
'power-of-two argument maximum
const amx = (1 shl (te + 1)) - 1


'do not change
' ***********************************************
if te > 30 then
   print "pan_lib.bi: too big const te": end
end if

declare function getp as long
'return the global prime

declare sub setsw (byval sw as integer)
'switch to verbose mode
declare function getsw as integer
'return the current mode

type ratio
   as long a, b
end type

declare function parse (byref g as string) as ratio
'parse input string
declare sub reduce overload (byref a as long, byref b as long)
'reduce rational a/b

type padic
declare constructor ()

declare function cpan (byref q as ratio, byval sw as integer) as integer
'convert q = a/b to p-adic number, set sw to print
declare function digits (byref g as string, byval p as long) as integer
'parse string of p-adic digits; canonicalize for p
declare function crat (byval sw as integer) as ratio
'return rational reconstruction, set sw to print

declare sub add (byref a as padic, byref b as padic)
'let self:= a + b
declare sub add (byref a as padic, byval s as long)
'let self:= a + scalar
declare sub subt (byref a as padic, byref b as padic)
'let self:= a - b
declare sub mult (byref a as padic, byref b as padic)
'let self:= a * b
declare sub mult (byref a as padic, byval s as long)
'let self:= a * scalar
declare sub powr (byref a as padic, byval m as long)
'let self:= a ^ m
declare sub div (byref a as padic, byref b as padic)
'let self:= a / b
declare sub div (byref a as padic, byval s as long)
'let self:= a / scalar
declare sub inv (byref a as padic)
'let self:= 1 / a
declare sub shlt (byval t as integer)
'let self * p^t
declare sub shrt (byval t as integer)
'let self / p^t
declare sub cmpt (byref a as padic)
'let self:= complement_a

declare sub sqrt (byref a as padic)
'let self:= sqrt(a)
declare sub teichm (byref a as padic)
'let self:= Teichmüller character for a
declare sub logp (byref a as padic)
'let self:= log_p(a)
declare sub expp (byref a as padic)
'let self:= exp_p(a)
declare sub bino (byref a as padic, byref c as padic)
'let self:= a ^ c
declare sub rndp (byref a as padic, byref sw as integer)
'let self:= random p-adic number
'seed a, set sw to initialize
declare function vp () as integer
'scan right to left for nonzero d
'return i = k for vp = oo
declare function scan () as integer
'scan left to right for nonzero d
'return i < 0 for self = 0
declare sub printf (byval sw as integer)
'print expansion
declare sub zero ()
'let self:= 0

   as long d(-emx to emx - 1)
   as integer v, k
end type

#define min(a, b) iif((a) > (b), b, a)
#define max(a, b) iif((a) < (b), b, a)

#define Is0(a) (a.d(0) = 0 andalso a.scan < 0)
#define Is1(a) (a.d(0) = 1 andalso a.scan = 0)
