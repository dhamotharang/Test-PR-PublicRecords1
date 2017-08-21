import business_credit, ut, scrubs, _control,tools,std;

EXPORT PostBuildFullReport(string filedate=(string)std.date.today(),
												Business_Credit.Constants().buildType	pBuildType	= Business_Credit.Constants().buildType.Daily, string emailList='') := FUNCTION

#OPTION('multiplePersistInstances',FALSE);
/*******************************************************************************/
/*	datasetName:=<Dataset>                                                     */
/*	This assumes:                                                              */
/*	Folder Name = Scrubs_<Dataset>                                             */
/*	In File Name	=	In_<Dataset>                                               */
/*******************************************************************************/
datasetName	:=	'Business_Credit'; 
scopename		:=	'LinkID';


folderName	:=	'Scrubs_'+datasetName;
inFileName	:=	if(pBuildType	= Business_Credit.Constants().buildType.Daily,Scrubs_Business_Credit.LinkID_In_Business_Credit(process_date=filedate),Scrubs_Business_Credit.LinkID_In_Business_Credit);
return	sequential(Business_Credit.DailyStatsReport(filedate),
									 Scrubs.ScrubsPlus_PassFile(inFileName,'Business_Credit','Scrubs_Business_Credit','Scrubs_SBFE_LinkID','LinkID',filedate,emailList)
									 );

end;
