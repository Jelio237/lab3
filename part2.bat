@echo off

setlocal enabledelayedexpansion

set source=%~1
set destination=%~2

if "%source%" == "" (
    set /p "source=Input source folder path: "
)
if not exist "%source%" (
    if not exist "%cd%\%source%" (
        echo Source folder wasn't found
        exit /b 1
    )
)

if "%destination%" == "" goto :choice 

goto :next

:choice
set /p c="Do you want to copy files to the current folder [Y/N]? "

if "%c%" == "Y" goto :choice_yes
if "%c%" == "N" goto :choice_no

goto :choice

:choice_yes
set "destination=%cd%"
goto :next

:choice_no
set /p "destination=Input output folder path: "

:next
if not exist "%destination%" (
    echo Output folder wasn't found
    exit /b 1
)

for %%i in ("%source%\*.*") do (
    set file=%%~nxi
    move "!source!\!file!" "!destination!\"
)