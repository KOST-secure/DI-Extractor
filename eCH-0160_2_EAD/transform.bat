@ECHO OFF
SETLOCAL

SET JAVA_HOME=C:\Software\jre6
SET SAXON=C:\Software\saxon9
SET LINT=C:\Software\PCUnixUtils

IF [%1]==[] (
        ECHO usage: %0  path\SIP...  OUTPUT
        EXIT /B
)

IF [%2]==[] (
        ECHO usage: %0  path\SIP...  OUTPUT
        EXIT /B
)

IF NOT EXIST %1 (
        ECHO SIP path %1 not found
        ECHO usage: %0 path\SIP...
        EXIT /B
)

IF NOT EXIST %1\header\metadata.xml (
        ECHO %1\header\metadata.xml not found
        ECHO usage: %0 path\SIP...
        EXIT /B
)

SET ECH-0160=%1
SET OUTPUT=%2
IF EXIST %OUTPUT% (
        DEL /Q %OUTPUT%
)

%JAVA_HOME%\bin\java -cp %SAXON%\saxon9.jar net.sf.saxon.Transform -s:%ECH-0160%\header\metadata.xml -xsl:eCH2EAD.xsl -o:"%OUTPUT%"

%LINT%\xmllint.exe -sax -noout -schema ead.xsd "%OUTPUT%"
ECHO.

IF %ERRORLEVEL%==0 (
        ECHO SIP %ECH-0160% converted
        ECHO output is %OUTPUT%
        ECHO.
)
