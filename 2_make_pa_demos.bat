@echo off
:: ---------------------------------------------------------------
:: Compile all p-adic demo programs

:: To be run in the paN base directory
:: ---------------------------------------------------------------

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
echo  compiling all Cf demos...

set Cmdlin=%Fbas%\fbc -p %ldir% -s console -w pedantic "%%~fa"

for %%a in (%tool%\*.bas) do %Cmdlin% >>compile.log

set Movlin=move "%%~fa" %tool%\bin

for %%a in (%tool%\*.exe) do %Movlin% >nul

echo.
pause
