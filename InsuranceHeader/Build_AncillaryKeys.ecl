import  tools,InsuranceHeader_PostProcess; 

#workunit('name','Iheader Ancillary keys');

EXPORT Build_AncillaryKeys (string pVersion) := function 
   
	version        := thorlib.wuid()[2..9];
	shared TheKeys := InsuranceHeader_PostProcess.AncillaryKeys( version	);	
	
	// DL verification Keys 
	tools.mac_WriteIndex('TheKeys.did.New'									  ,BuildDidKey							 );
	tools.mac_WriteIndex('TheKeys.dln.New'									  ,BuildDLKey							   );														  

  RunKeys           := sequential( BuildDidKey
		                         ,BuildDLKey
		                         ,InsuranceHeader_PostProcess.Promote(version).buildfiles.New2Built
		                         ,InsuranceHeader_PostProcess.Promote(version).buildfiles.Built2QA
		                         ,InsuranceHeader_PostProcess.Promote().buildfiles.cleanup ) : SUCCESS(mod_email.SendSuccessEmail(,'InsuranceHeader', , 'Person Ancillary keys')), 
																			                                         FAILURE(mod_email.SendFailureEmail(,'InsuranceHeader', failmessage, 'Person Ancillary keys'));
  // CIID phone Keys 
  runCiidphone := InsuranceHeader.proc_ciidphone(pVersion).run ; 
	
	return sequential(
		 RunKeys
		,runCiidphone 
	);
	
end; 