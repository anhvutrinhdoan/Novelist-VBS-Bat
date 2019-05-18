@echo off
setlocal EnableDelayedExpansion	
del .\names_titles.txt
del .\appeal_terms.txt

set /p VARIABLE2=Perform Novelist appeal term lookup or appeal term title search? (Choose n or b ):

IF %VARIABLE2% == n call :lookup 
IF %VARIABLE2% == b call :search
echo All done!
GOTO :eof

:lookup
	::collect user input
	
	set /p VARIABLE=I can search for multiple authors or novel titles. How many shall I search?:
	for /l %%G in (1,1,%VARIABLE%) do ( 
		set /p STRING[%%G]=Enter author or novel titles: 
		@echo on
		echo !STRING[%%G]! >> .\names_titles.txt
		@echo off
	)

	:: if folder exists do nothing, if it doesn't, create batch_data folder
	IF EXIST batch_data ( echo batch_data directory exists ) ELSE (
		mkdir batch_data 
		echo batch_data directory does not exist, making directory
	)

	for /l %%G in (1,1,%VARIABLE%) do ( 
		set STRING[%%G]=!STRING[%%G]: =+!
		http-ping -n 1 "http://eit.ebscohost.com/Services/SearchService.asmx/Search?prof=s9024282.main.eit&pwd=ep4930&authType=&ipprof=&query=!STRING[%%G]!&db=neh" -f .\batch_data\data%%G.txt
		::clean up data
		findstr /i "<" .\batch_data\data%%G.txt > .\batch_data\data%%G.xml  
		::remove temp text file
		del .\batch_data\data%%G.txt
		
	)

	::clear old output 
	IF EXIST "output.txt" (	del "output.txt" script) ELSE ( echo All clear! )



	::calls vbscript to parse xml file

	@call cscript "%~dp0xmlparse.vbs"
	EXIT /B

:search
	set /p VARIABLE3=How many appeal terms to search?:
	for /l %%G in (1,1,%VARIABLE3%) do ( 
		set /p STRING2[%%G]=Enter appeal terms: 
		@echo on		
		echo AP !STRING2[%%G]! >> .\appeal_terms.txt
		@echo off
	)

	:: if folder exists do nothing, if it doesn't, create batch_data folder
	IF EXIST batch_data ( echo batch_data directory exists ) ELSE (
		mkdir batch_data 
		echo batch_data directory does not exist, making directory
	)
	for /f "tokens=*" %%H IN (appeal_terms.txt) do call	set Appeals = "!Appeals! AND %%H"
	http-ping -n 1 "http://eit.ebscohost.com/Services/SearchService.asmx/Search?prof=s9024282.main.eit&pwd=ep4930&authType=&ipprof=&query=!Appeals!&db=neh" -f .\batch_data\info%%G.txt
	
	::for /l %%G in (1,1,%VARIABLE3%) do ( 
	::	set STRING2[%%G]=!STRING2[%%G]: =+! 
	::	http-ping -n 1 "http://eit.ebscohost.com/Services/SearchService.asmx/Search?prof=s9024282.main.eit&pwd=ep4930&authType=&ipprof=&query=!STRING2[%%G]!&db=neh" -f .\batch_data\info%%G.txt
	::clean up data
	findstr /i "<" .\batch_data\info%%G.txt > .\batch_data\info%%G.xml  
	::remove temp text file
	del .\batch_data\info%%G.txt
	::	
	::)
	::clear old output 
	IF EXIST "output2.txt" (	del "output2.txt" script) ELSE ( echo All clear! )

	::calls vbscript to parse xml file

	@call cscript "%~dp0xmlparse2.vbs"
	EXIT /B

endlocal
@pause
