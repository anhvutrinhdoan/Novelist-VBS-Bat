'XML parsing script. Loads xml data files from "batch_data" folder
'then scans through nodes looking for the specific appeal terms
'outputting them to an output file

Set xmlDoc=CreateObject("Msxml2.DOMDocument.6.0")
Set fso = CreateObject("Scripting.FileSystemObject")
Set fileCounter =  CreateObject("Scripting.FileSystemObject")

lookInFolder = ".\batch_data\"

Set objFolder = fileCounter.GetFolder(lookInFolder)
Dim fileName

Set AuthorsAndTitles = fso.OpenTextFile(".\names_titles.txt", 1)

numFiles =  objFolder.Files.Count

For n=1 to numFiles
	fileName = ".\batch_data\data" & n & ".xml"
	xmlDoc.async = False 
	xmlDoc.load(fileName) 
	Set nodes = xmlDoc.getElementsByTagName("subj")
	Set objFile = fso.OpenTextFile(".\output.txt",8,True)

	For Each node In nodes
		If node.getAttribute("type") = "tone" Or node.getAttribute("type") = "style" Or node.getAttribute("type") = "character" Or node.getAttribute("type") = "story" Then
			WScript.Echo node.text	
			
			objFile.Write("'" & node.text & "',")
			
		End If	
	Next	
	objFile.Close	
Next

