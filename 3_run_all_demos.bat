@echo off
:: ---------------------------------------------------------------
:: Run all p-adic demo programs

:: To be run in the paN base directory
:: ---------------------------------------------------------------

:: Set path to the source files directory:
set tool=.\modules\bin
:: Path to the working directory:
set work=.\workdir
:: without closing backslashes.

echo.
if not exist %tool%\*.exe goto :fail

echo  running all cf demos...

for %%a in (%work%\*.log) do del "%%~fa" >nul

for %%a in (%tool%\*.exe) do "%%~fa" < %work%\"%%~na" > %work%\"%%~na".log

echo.
exit

:fail
echo  demo.exes not found
echo.
pause
