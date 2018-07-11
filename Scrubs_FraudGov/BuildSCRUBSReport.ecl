import FraudShared, ut, scrubs, _control,tools,std;

EXPORT BuildSCRUBSReport(string filedate=(string)std.date.today(), string emailList='') := FUNCTION

#OPTION('multiplePersistInstances',FALSE);
/*******************************************************************************/
/*	datasetName:=<Dataset>                                                     */
/*	This assumes:                                                              */
/*	Folder Name = Scrubs_<Dataset>                                             */
/*	In File Name	=	In_<Dataset>                                               */
/*******************************************************************************/
datasetName	:=	'FraudGov';

folderName	:=	'Scrubs_'+datasetName;


return	sequential(
									 Scrubs_FraudGov.MAC_Scrubs_Report(filedate,folderName,'InquiryLogs' , InquiryLogs_In_InquiryLogs , emailList),
									 Scrubs_FraudGov.MAC_Scrubs_Report(filedate,folderName,'NAC_v2' ,	NAC_In_NAC , emailList)
									 );

end;
