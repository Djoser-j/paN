@echo off
:: ---------------------------------------------------------------
:: Delete compiles and logfiles

:: To be run in the paN base directory
:: ---------------------------------------------------------------

:: Library name
set name=pan_arith

:: working directory
set work=.\workdir
:: library directory
set ldir=.\library
:: source files directory
set tool=.\modules\bin

echo.

del %ldir%\lib%name%.dll.a
del %tool%\%name%.dll

for %%a in (%tool%\*.exe) do del "%%~fa" >nul

for %%a in (%work%\*.log) do del "%%~fa" >nul

exit
