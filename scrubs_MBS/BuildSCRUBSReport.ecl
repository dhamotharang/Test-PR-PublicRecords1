import FraudShared, ut, scrubs, _control,tools,std;

EXPORT BuildSCRUBSReport(string filedate=(string)std.date.today(), string emailList='') := FUNCTION

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
									 Scrubs_MBS.MAC_Scrubs_Report(filedate,folderName,'CCID'								,	CCID_In_CCID																,	emailList),
									 Scrubs_MBS.MAC_Scrubs_Report(filedate,folderName,'ColvalDesc'					,	ColValDesc_In_ColValDesc										,	emailList),
									 Scrubs_MBS.MAC_Scrubs_Report(filedate,folderName,'HHID'								,	HHID_In_HHID																,	emailList),
									 Scrubs_MBS.MAC_Scrubs_Report(filedate,folderName,'IndType'							,	IndType_In_IndType													,	emailList),
									 Scrubs_MBS.MAC_Scrubs_Report(filedate,folderName,'IndTypeExclusion'		,	IndTypeExclusion_In_IndTypeExclusion				,	emailList),
									 Scrubs_MBS.MAC_Scrubs_Report(filedate,folderName,'MarketAppend'				,	MarketAppend_In_MarketAppend								,	emailList),
									 Scrubs_MBS.MAC_Scrubs_Report(filedate,folderName,'MasterIdIndTypeIncl'	,	MasterIDIndTypeIncl_In_MasterIDIndTypeIncl	,	emailList),
									 Scrubs_MBS.MAC_Scrubs_Report(filedate,folderName,'MBS'									,	MBS_In_MBS																	,	emailList),
									 Scrubs_MBS.MAC_Scrubs_Report(filedate,folderName,'NewGcIdExcl'					,	NewGcIdExcl_In_NewGcIdExcl									,	emailList),
									 Scrubs_MBS.MAC_Scrubs_Report(filedate,folderName,'ProductInclude'			,	ProductInclude_In_ProductInclude						,	emailList),
									 Scrubs_MBS.MAC_Scrubs_Report(filedate,folderName,'SourceGcExclusion'		,	SourceGcExclusion_In_SourceGcExclusion			,	emailList),
									 Scrubs_MBS.MAC_Scrubs_Report(filedate,folderName,'TableCol'						,	TableCol_In_TableCol												,	emailList)
									 );

end;
