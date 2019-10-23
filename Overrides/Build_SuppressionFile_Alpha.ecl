IMPORT FCRA, header, promoteSupers,_Control,STD ;

EXPORT Build_SuppressionFile_Alpha(STRING filedate) := FUNCTION 

	dsFcraFile     := FCRA.File_flag(file_id ='header') ;
	dsFcrabase     := header.File_FCRA_Headers ;

	GetRID := JOIN(dsFcrabase , dsFcraFile , LEFT.persistent_record_id = (UNSIGNED) RIGHT.record_id , 
            TRANSFORM ( {dsFcraFile , UNSIGNED6 	RID },
						SELF := RIGHT; 
						SELF.RID := LEFT.RID),RIGHT OUTER,HASH); 

  PromoteSupers.MAC_SF_BuildProcess(GetRID,'~thor_data400::base::alpha_suppression_rid',bld_suppression ,3,,true);
  
	distlistAlpha  :=  if (_Control.ThisEnvironment.Name = 'Prod_Thor',
														'Darren.Knowles@lexisnexis.com,Ayeesha.Kayttala@lexisnexisrisk.com,cody.fouts@lexisnexisrisk.com',
														'Darren.Knowles@lexisnexis.com,Ayeesha.Kayttala@lexisnexisrisk.com,cody.fouts@lexisnexisrisk.com'														
														);
														
												
	RunSuppressions := bld_suppression : SUCCESS(STD.System.Email.SendEmail(distlistAlpha,
																												'Override Alpharetta suppression Build WORKUNIT ' + WORKUNIT + ' has completed',
																												'')),
										 FAILURE(STD.System.Email.SendEmail(distlistAlpha,
																												'Override Alpharetta suppression Build WORKUNIT ' + WORKUNIT + ' has failed',
																												FAILMESSAGE));
	
 RETURN RunSuppressions ;  

END; 

