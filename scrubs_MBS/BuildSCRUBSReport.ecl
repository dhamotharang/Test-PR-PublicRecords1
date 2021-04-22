import FraudGovPlatform, FraudGovPlatform_Validation, ut, scrubs, _control,tools,std;

EXPORT BuildSCRUBSReport(string filedate=(string)std.date.today(), string emailList=FraudGovPlatform_Validation.Mailing_List().Alert) := FUNCTION

#OPTION('multiplePersistInstances',FALSE);
/*******************************************************************************/
/*	datasetName:=<Dataset>                                                     */
/*	This assumes:                                                              */
/*	Folder Name = Scrubs_<Dataset>                                             */
/*	In File Name	=	In_<Dataset>                                               */
/*******************************************************************************/
datasetName	:=	'MBS';

folderName	:=	'Scrubs_'+datasetName;


return	sequential(
	if(STD.File.GetSuperFileSubCount(FraudGovPlatform.Filenames().Input.MBSFdnCCID.Sprayed) > 0 ,
		Scrubs_MBS.MAC_Scrubs_Report(filedate,folderName,'CCID', CCID_In_CCID,	emailList)),
	if(STD.File.GetSuperFileSubCount(FraudGovPlatform.Filenames().Input.MBSColValDesc.Sprayed) > 0 ,
		Scrubs_MBS.MAC_Scrubs_Report(filedate,folderName,'ColvalDesc', ColValDesc_In_ColValDesc,	emailList)),
	if(STD.File.GetSuperFileSubCount(FraudGovPlatform.Filenames().Input.MBSFdnHHID.Sprayed) > 0 ,
		Scrubs_MBS.MAC_Scrubs_Report(filedate,folderName,'HHID', HHID_In_HHID,	emailList)),
	if(STD.File.GetSuperFileSubCount(FraudGovPlatform.Filenames().Input.MBSFdnIndType.Sprayed) > 0 ,
		Scrubs_MBS.MAC_Scrubs_Report(filedate,folderName,'IndType',	IndType_In_IndType,	emailList)),
	if(STD.File.GetSuperFileSubCount(FraudGovPlatform.Filenames().Input.MbsIndTypeExclusion.Sprayed) > 0 ,
		Scrubs_MBS.MAC_Scrubs_Report(filedate,folderName,'IndTypeExclusion', IndTypeExclusion_In_IndTypeExclusion,	emailList)),
	if(STD.File.GetSuperFileSubCount(FraudGovPlatform.Filenames().Input.MBSmarketAppend.Sprayed) > 0 ,
		Scrubs_MBS.MAC_Scrubs_Report(filedate,folderName,'MarketAppend', MarketAppend_In_MarketAppend,	emailList)),
	if(STD.File.GetSuperFileSubCount(FraudGovPlatform.Filenames().Input.MbsFdnMasterIDIndTypeInclusion.Sprayed) > 0 ,
		Scrubs_MBS.MAC_Scrubs_Report(filedate,folderName,'MasterIdIndTypeIncl', MasterIDIndTypeIncl_In_MasterIDIndTypeIncl	,	emailList)),
	if(STD.File.GetSuperFileSubCount(FraudGovPlatform.Filenames().Input.Mbs.Sprayed) > 0 ,
		Scrubs_MBS.MAC_Scrubs_Report(filedate,folderName,'MBS', MBS_In_MBS, emailList)),
	if(STD.File.GetSuperFileSubCount(FraudGovPlatform.Filenames().Input.MbsNewGcIdExclusion.Sprayed) > 0 ,
		Scrubs_MBS.MAC_Scrubs_Report(filedate,folderName,'NewGcIdExcl',	NewGcIdExcl_In_NewGcIdExcl	,	emailList)),
	if(STD.File.GetSuperFileSubCount(FraudGovPlatform.Filenames().Input.MbsProductInclude.Sprayed) > 0 ,
		Scrubs_MBS.MAC_Scrubs_Report(filedate,folderName,'ProductInclude', ProductInclude_In_ProductInclude	,	emailList)),
	if(STD.File.GetSuperFileSubCount(FraudGovPlatform.Filenames().Input.MBSSourceGcExclusion.Sprayed) > 0 ,
		Scrubs_MBS.MAC_Scrubs_Report(filedate,folderName,'SourceGcExclusion', SourceGcExclusion_In_SourceGcExclusion,	emailList)),
	if(STD.File.GetSuperFileSubCount(FraudGovPlatform.Filenames().Input.MBSTableCol.Sprayed) > 0 ,
		Scrubs_MBS.MAC_Scrubs_Report(filedate,folderName,'TableCol'	, TableCol_In_TableCol,	emailList))
	 );

end;
