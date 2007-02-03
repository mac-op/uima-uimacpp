@ECHO OFF
@REM     Installs UIMA C++ files
@REM     Called as a post-build step in the install project
@REM     Copies ALL include files and the lib & dlls 
@REM     First arg is the build configuration, i.e. Release or Debug
@REM     Installs in the directory specified by environment variable UIMA_INSTALLDIR
@REM     default is 'install' under the uimacpp directory
@REM     if set to the UIMACPP_HOME of the SDK will replace the entries in the SDK

@if "%~1"=="Release" goto run
@if "%~1"=="Debug" goto run
@ECHO Invalid arg for _InstallUimaCPP; specify Debug or Release
goto end

:run
@SETLOCAL

@REM Every dir has a nul entry

@if NOT "%UIMA_INSTALLDIR%"=="" goto HAVEDIR
  set UIMA_INSTALLDIR=..\install
  @if not exist %UIMA_INSTALLDIR%\nul mkdir %UIMA_INSTALLDIR%
@:HAVEDIR
@if not exist %UIMA_INSTALLDIR%\include\nul mkdir %UIMA_INSTALLDIR%\include
@if not exist %UIMA_INSTALLDIR%\include\uima\nul mkdir %UIMA_INSTALLDIR%\include\uima
@copy cas\uima\*.hpp       %UIMA_INSTALLDIR%\include\uima
@copy cas\uima\*.inl       %UIMA_INSTALLDIR%\include\uima
@copy framework\uima\*.hpp %UIMA_INSTALLDIR%\include\uima
@copy framework\uima\*.h   %UIMA_INSTALLDIR%\include\uima

@if not exist %UIMA_INSTALLDIR%\data\nul mkdir %UIMA_INSTALLDIR%\data
@copy ..\data\*.xsd %UIMA_INSTALLDIR%\data

@if not exist %UIMA_INSTALLDIR%\lib\nul mkdir %UIMA_INSTALLDIR%\lib
@copy ..\%1\lib\*.lib %UIMA_INSTALLDIR%\lib

@if not exist %UIMA_INSTALLDIR%\bin\nul mkdir %UIMA_INSTALLDIR%\bin
@copy ..\%1\bin\*.dll %UIMA_INSTALLDIR%\bin
@copy ..\%1\bin\*.exe %UIMA_INSTALLDIR%\bin

:end
