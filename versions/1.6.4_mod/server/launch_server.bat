@ECHO OFF
SET BINDIR=%~dp0
CD /D "%BINDIR%"
"%ProgramFiles%\Java\jre1.8.0_202\bin\java.exe" -Xmx8192M -Xms8192M -jar minecraftforge-universal-1.6.4-9.11.1.1345.jar