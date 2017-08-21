/*******************************************************************************/
/*	datasetName:=<Dataset>                                                     */
/*	This assumes:                                                              */
/*	Folder Name = Scrubs_<Dataset>                                             */
/*	In File Name	=	In_<Dataset>                                               */
/*******************************************************************************/
datasetName	:=	'Property_Characteristics';
scopename		:=	'';

/*******************************************************************************/
/*	NO NEED TO CHANGE ANYTHING BELOW THIS LINE                                 */
/*******************************************************************************/
MAC_Salt_Report(myFolder,myFile)	:=	MACRO
	folder				:=	#EXPAND(myFolder);
	inFile				:=	folder.#EXPAND(myFile);
	hygiene_name	:=	IF(TRIM(scopename,ALL)<>'',TRIM(scopename,ALL)+'_hygiene','hygiene');
	hygiene				:=	folder.#EXPAND(hygiene_name);
	OUTPUT(inFile,NAMED('Input_File'));
	OUTPUT(hygiene(inFile).Summary('Profile_Summary'),ALL,NAMED('Summary'));
	OUTPUT(hygiene(inFile).invSummary,ALL,NAMED('Inverted'));
	OUTPUT(hygiene(inFile).AllProfiles,ALL,NAMED('Field_Report'));
ENDMACRO;

folderName	:=	'Scrubs_'+datasetName;
inFileName	:=	IF(TRIM(scopename,ALL)<>'',TRIM(scopename,ALL)+'_In_'+datasetName,'In_'+datasetName);

MAC_Salt_Report(folderName,inFileName);
