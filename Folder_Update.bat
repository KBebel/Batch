@echo off
set PATH=c:\Program Files (x86)\WinSCP\;c:\Program Files (x86)\Winrar\
set logfile="d:\DATATRANSFER\Backup_%date%_%time%.log"
varCatiaFtp = x@x
varFtp = x@x

:start
d:
@echo %date% - %time%
@echo Aktualizacja wybranego folderu
@echo:
@echo Podaj Statek (0711, 0694, XXXXX, ...)
set /p varShip=Ship:
@echo Podaj Folder (R0711ERM, S0711M, XXXXX, ...)
set /p varFolder=Folder:
@echo Podaj czas, ile godzin(1, 2, ...)
set /p varTime=Time:
@echo Dla kogo lub poczatek tytulu pliku rar (np. Dla_HS - Dla_HS_Statek_Scheibe_Deck.rar )
set /p varTxt=Tekst:
@echo Kopiuje: %varFolder%_%varTxt%
winscp.com /console /command "option batch continue" "open %varCatiaFtp%" "synchronize local -delete -Mirror d:\DATATRANSFER\%varShip%_Synchro\%varFolder%\ /catia_daten/mw/mod/%varFolder%/ -filemask="%Ship%*.*"" "exit"
cd d:\DATATRANSFER\%varShip%_Synchro\%varFolder%\
rar a -tn%varTime%h d:\DATATRANSFER\_nach_Stettin\%varFolder%_%varTxt%.rar *
@echo:
winscp.com /console /command "option batch abort" "open %varFtp%" "put -delete d:\DATATRANSFER\_nach_Stettin\%varFolder%_%varTxt%.rar" "exit"
@echo:
@echo Plik %varFolder%_%varTxt%.rar na serwerze Nelton
set choice=
set /p choice="Chcesz podac kolejna sekcje (t/n)?"
if not '%choice%'=="set choice:~0,1%
if '%choice%'=='t' goto start
exit
