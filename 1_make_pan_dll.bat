@echo off
:: ---------------------------------------------------------------
:: Compile dynamic pan library
:: To be run in the paN base directory

:: Note: the paN archive you downloaded is assumed to be
:: unpacked to the base directory of your freeBasic installation.
:: ---------------------------------------------------------------

:: Library name
set lib=pan_arith

:: Set path to the library directory:
set ldir=.\library
:: without closing backslash.

echo.
echo  compiling %lib% DLL

:: Path to the freeBasic compiler
set Fbas=".."
:: Source files directory
set tool=.\modules

set opts= -dll -i %tool% -w pedantic

%Fbas%\fbc %opts% %ldir%\%lib%.bas >compile.log

move %ldir%\%lib%.dll %tool%\bin

echo.
rem pause
