@echo off
:: ---------------------------------------------------------------
:: Run a single p-adic demo

:: To be run in the paN base directory
:: ---------------------------------------------------------------

:: demo to run
set file=pa_trans

:: Set path to the source files directory:
set tool=.\modules\bin
:: Path to the working directory:
set work=.\workdir
:: without closing backslashes.

echo.
if not exist %tool%\%file%.exe goto :fail

echo  running %file%.exe

%tool%\%file% < %work%\%file% > %work%\%file%.log

echo.
exit

:fail
echo  %file%.exe not found
echo.
pause
