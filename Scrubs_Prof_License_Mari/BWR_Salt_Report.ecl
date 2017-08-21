/*******************************************************************************/
/*	datasetName:=<Dataset>                                                     */
/*	This assumes:                                                              */
/*	Folder Name = Scrubs_<Dataset>                                             */
/*	In File Name	=	In_<Dataset>                                               */
/*******************************************************************************/
datasetName	:=	'Prof_License_Mari';

/*******************************************************************************/
/*	NO NEED TO CHANGE ANYTHING BELOW THIS LINE                                 */
/*******************************************************************************/
MAC_Salt_Report(myFolder,myFile)	:=	MACRO
	folder				:=	#EXPAND(myFolder);
	inFile				:=	folder.#EXPAND(myFile);
	OUTPUT(inFile,NAMED('Input_File'));
	OUTPUT(folder.hygiene(inFile).Summary('Profile_Summary'),ALL,NAMED('Summary'));
	OUTPUT(folder.hygiene(inFile).invSummary,ALL,NAMED('Inverted'));
	OUTPUT(folder.hygiene(inFile).AllProfiles,ALL,NAMED('Field_Report'));
ENDMACRO;

folderName	:=	'Scrubs_'+datasetName;
inFileName	:=	'In_'+datasetName;

MAC_Salt_Report(folderName,inFileName);
