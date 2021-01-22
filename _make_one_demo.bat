@echo off
:: ---------------------------------------------------------------
:: Compile a single p-adic demo

:: To be run in the paN base directory
:: ---------------------------------------------------------------

:: module to compile
set file=pa_trans

:: library name
set name=pan_arith

:: Set path to the freeBasic compiler:
set Fbas=".."
:: without closing backslash.

:: library directory
set ldir=.\library
:: source files directory
set tool=.\modules

if not exist %ldir%\lib%name%.dll.a call 1_make_pan_dll.bat
echo.
echo  compiling %file%.exe

set opts= -p %ldir% -s console -w pedantic

%Fbas%\fbc %opts% %tool%\%file%.bas >compile.log

move %tool%\%file%.exe %tool%\bin >nul

echo.
rem pause
