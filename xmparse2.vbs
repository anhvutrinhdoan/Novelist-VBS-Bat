'XML parsing script. Loads xml data files from "batch_data" folder
'then scans through nodes looking for the specific appeal terms
'outputting them to an output file

Set xmlDoc=CreateObject("Msxml2.DOMDocument.6.0")
Set fso = CreateObject("Scripting.FileSystemObject")
Set fileCounter =  CreateObject("Scripting.FileSystemObject")

lookInFolder = ".\batch_data\"

Set objFolder = fileCounter.GetFolder(lookInFolder)
Dim fileName

Set AuthorsAndTitles = fso.OpenTextFile(".\appeal_terms.txt", 1)

numFiles =  objFolder.Files.Count

For n=1 to numFiles
	fileName = ".\batch_data\info.xml"
	xmlDoc.async = False 
	xmlDoc.load(fileName) 
	Set nodes = xmlDoc.getElementsByTagName("btl")	
	Set objFile = fso.OpenTextFile(".\output_titles.txt",8,True)	

	For Each node In nodes
		WScript.Echo node.text	
		objFile.Write("""" & node.text & """,")			
	Next	
	objFile.Close	
Next
