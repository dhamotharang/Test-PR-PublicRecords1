import business_credit, ut, scrubs, _control,tools,std;

EXPORT BuildSCRUBSReport(STRING	pFilename='', string filedate=(string)std.date.today(), string emailList='') := FUNCTION

#OPTION('multiplePersistInstances',FALSE);
/*******************************************************************************/
/*	datasetName:=<Dataset>                                                     */
/*	This assumes:                                                              */
/*	Folder Name = Scrubs_<Dataset>                                             */
/*	In File Name	=	In_<Dataset>                                               */
/*******************************************************************************/
datasetName	:=	'Business_Credit';

folderName	:=	'Scrubs_'+datasetName;

return	sequential(Scrubs_Business_Credit.RecordNumberCheck(pFilename),
									 Scrubs.ScrubsPlus_PassFile(Business_Credit.Files(pFilename).#EXPAND('AA'),'Business_Credit','Scrubs_Business_Credit','Scrubs_SBFE_AA','AA',filedate,emailList),
									 Scrubs.ScrubsPlus_PassFile(Business_Credit.Files(pFilename).#EXPAND('AB'),'Business_Credit','Scrubs_Business_Credit','Scrubs_SBFE_AB','AB',filedate,emailList),
									 Scrubs.ScrubsPlus_PassFile(Business_Credit.Files(pFilename).#EXPAND('AD'),'Business_Credit','Scrubs_Business_Credit','Scrubs_SBFE_AD','AD',filedate,emailList),
									 Scrubs.ScrubsPlus_PassFile(Business_Credit.Files(pFilename).#EXPAND('AH'),'Business_Credit','Scrubs_Business_Credit','Scrubs_SBFE_AH','AH',filedate,emailList),
									 Scrubs.ScrubsPlus_PassFile(Business_Credit.Files(pFilename).#EXPAND('BI'),'Business_Credit','Scrubs_Business_Credit','Scrubs_SBFE_BI','BI',filedate,emailList),
									 Scrubs.ScrubsPlus_PassFile(Business_Credit.Files(pFilename).#EXPAND('BS'),'Business_Credit','Scrubs_Business_Credit','Scrubs_SBFE_BS','BS',filedate,emailList),
									 Scrubs.ScrubsPlus_PassFile(Business_Credit.Files(pFilename).#EXPAND('CL'),'Business_Credit','Scrubs_Business_Credit','Scrubs_SBFE_CL','CL',filedate,emailList),
									 Scrubs.ScrubsPlus_PassFile(Business_Credit.Files(pFilename).#EXPAND('FA'),'Business_Credit','Scrubs_Business_Credit','Scrubs_SBFE_FA','FA',filedate,emailList),
									 Scrubs.ScrubsPlus_PassFile(Business_Credit.Files(pFilename).#EXPAND('FZ'),'Business_Credit','Scrubs_Business_Credit','Scrubs_SBFE_FZ','FZ',filedate,emailList),
									 Scrubs.ScrubsPlus_PassFile(Business_Credit.Files(pFilename).#EXPAND('IS'),'Business_Credit','Scrubs_Business_Credit','Scrubs_SBFE_IS','IS',filedate,emailList),
									 Scrubs.ScrubsPlus_PassFile(Business_Credit.Files(pFilename).#EXPAND('MA'),'Business_Credit','Scrubs_Business_Credit','Scrubs_SBFE_MA','MA',filedate,emailList),
									 Scrubs.ScrubsPlus_PassFile(Business_Credit.Files(pFilename).#EXPAND('MS'),'Business_Credit','Scrubs_Business_Credit','Scrubs_SBFE_MS','MS',filedate,emailList),
									 Scrubs.ScrubsPlus_PassFile(Business_Credit.Files(pFilename).#EXPAND('PN'),'Business_Credit','Scrubs_Business_Credit','Scrubs_SBFE_PN','PN',filedate,emailList),
									 Scrubs.ScrubsPlus_PassFile(Business_Credit.Files(pFilename).#EXPAND('TI'),'Business_Credit','Scrubs_Business_Credit','Scrubs_SBFE_TI','TI',filedate,emailList),
									 Scrubs.ScrubsPlus_PassFile(Business_Credit.Files(pFilename).#EXPAND('ZZ'),'Business_Credit','Scrubs_Business_Credit','Scrubs_SBFE_ZZ','ZZ',filedate,emailList)
									 );

end;
