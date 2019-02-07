import FraudGovPlatform, ut, scrubs, _control,tools,std;

EXPORT BuildSCRUBSReport(
	string filedate=(string)std.date.today(),
	dataset(FraudGovPlatform.Layouts.OutputF.SkipModules) pSkipModules = FraudGovPlatform.Files().OutputF.SkipModules,
	string emailList=''
) := FUNCTION

SkipNACBuild := pSkipModules[1].SkipNACBuild;
SkipInquiryLogsBuild := pSkipModules[1].SkipInquiryLogsBuild;

#OPTION('multiplePersistInstances',FALSE);
/*******************************************************************************/
/*	datasetName:=<Dataset>                                                     */
/*	This assumes:                                                              */
/*	Folder Name = Scrubs_<Dataset>                                             */
/*	In File Name	=	In_<Dataset>                                               */
/*******************************************************************************/
datasetName	:=	'FraudGov';
folderName	:=	'Scrubs_'+datasetName;

return sequential(
	if(SkipInquiryLogsBuild=false,Scrubs_FraudGov.MAC_Scrubs_Report(filedate,folderName,'InquiryLogs', InquiryLogs_In_InquiryLogs, emailList)),
	if(SkipNACBuild=false,Scrubs_FraudGov.MAC_Scrubs_Report(filedate,folderName,'NAC', NAC_In_NAC, emailList)));
end;
