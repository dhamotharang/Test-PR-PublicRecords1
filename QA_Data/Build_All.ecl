IMPORT tools, _control, QA_Data, Scrubs, Scrubs_QA_Data, AID, AID_Support, ut, std, data_services;

EXPORT Build_All(

	 STRING															       pversion
	,STRING															       pDirectory			    = '/data/hds_180/qa_data/data/' + pversion[1..8]
	,STRING															       pServerIP			    = 'uspr-edata11.risk.regn.net'
	,STRING															       pFileType			    = '*.txt'
	,STRING															       pGroupName			    = tools.fun_Groupname() 																		
	,BOOLEAN														       pIsTesting			    = FALSE
	,BOOLEAN														       pOverwrite			    = FALSE																															
	,DATASET(QA_Data.Layouts.Input.Sprayed_Transactions) 	 
																						 pSprayedTransFile	= QA_Data.Files().Input_Trans.using
	,DATASET(QA_Data.Layouts.Input.Sprayed_Addresses) 	 
																						 pSprayedAddrFile		= QA_Data.Files().Input_Addr.using
	,DATASET(QA_Data.Layouts.Base)             pBaseFile			    = QA_Data.Files().base.qa	

) := FUNCTION

	full_build :=	SEQUENTIAL(
		 QA_Data.Create_Supers
		,QA_Data.SprayFiles(pversion, pServerIP, pDirectory, pFileType, pGroupName, pIsTesting, pOverwrite)
		,QA_Data.Promote().Inputfiles.sprayed2using
		,QA_Data.Build_Base(pversion, pIsTesting, pSprayedAddrFile, pSprayedTransFile, pBaseFile)
		,Scrubs.ScrubsPlus('QA_Data','Scrubs_QA_Data','Scrubs_QA_Data_Base', 'Base', pversion,QA_Data.Email_Notification_Lists(pIsTesting).BuildFailure,false)
		,QA_Data.Build_Strata(pversion, pOverwrite, , , pIsTesting)
		,QA_Data.Promote().Inputfiles.using2used
		,QA_Data.Promote().Buildfiles.Built2QA
		,QA_Data.QA_Records()		
	) : SUCCESS(QA_Data.Send_Emails(pversion,,not pIsTesting).BuildSuccess),
	    FAILURE(QA_Data.Send_Emails(pversion,,not pIsTesting).buildfailure);
	
	RETURN
		IF(tools.fun_IsValidVersion(pversion)
			,full_build
			,OUTPUT('No Valid version parameter passed, skipping QA_Data.Build_All')
		);

END;