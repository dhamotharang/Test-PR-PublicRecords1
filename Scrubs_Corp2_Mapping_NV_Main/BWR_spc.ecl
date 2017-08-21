import SALT30;
/*******************************************************************************/
/*	datasetName:=<Dataset>                                                     */
/*	This assumes:                                                              */
/*	Folder Name = Scrubs_<Dataset>                                             */
/*	In File Name	=	In_<Dataset>                                               */
/*******************************************************************************/
datasetName	:=	'NV';

/*******************************************************************************/
/*	NO NEED TO CHANGE ANYTHING BELOW THIS LINE                                 */
/*******************************************************************************/
MAC_Salt_SPC(myFolder,myFile)	:=	MACRO
	folder				:=	#EXPAND(myFolder);
	inFile				:=	folder.#EXPAND(myFile);
	file_example	:=	inFile;											/* reference to file to be profiled */
	SALT30.MAC_Default_SPC(file_example, outSPC);	/* Create SALT SPC */
	OUTPUT(outSPC,all);														/* SPC Output */
ENDMACRO;

folderName	:=	'Scrubs_'+datasetName;
inFileName	:=	'In_'+datasetName;

MAC_Salt_SPC(folderName,inFileName);
