// create all data
EXPORT dsAllData :=	ProcessFile(Files.dsMasters);
/* This is how to create the XML file
			WriteXGFormat.OutputDataXMLFile('ALL', 'WorldCompliance All Data.xml', '20131007',
								dsAllData, Files.dsMasters);
*/