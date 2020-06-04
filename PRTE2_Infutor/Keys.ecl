IMPORT  doxie,mdr, PRTE2_Infutor, _control;

EXPORT keys := MODULE


	EXPORT Key_Header_Infutor_Knowx := INDEX(
		FILES.Header_Infutor_Knowx, 
		 {s_did}, 
		 {FILES.Header_Infutor_Knowx}, 
		'~prte::key::header.adl.infutor.knowx_' + doxie.Version_SuperKey);
		
	EXPORT key_header_teaser_did := INDEX(
		FILES.Teaser_cnsmr_did, 
		 {did}, 
		 {Files.Teaser_cnsmr_did}, 
		'~prte::key::header.teaser_did_' + doxie.Version_SuperKey);

	EXPORT key_header_teaser_search := INDEX(
		FILES.Infutor_Key_Teaser_cnsmr_did, 
		 {dph_lname,lname,iscurrent,st,pfname,fname,zip,yob,minit}, 
		 {Files.Infutor_Key_Teaser_cnsmr_did}, 
		'~prte::key::header.teaser_search_' + doxie.Version_SuperKey);

	EXPORT key_infutorbest_did := Index(
		Files.infutor_best_did, 
		{did},
		{Files.infutor_best_did},
		'~prte::key::infutor::best.did_' + doxie.Version_SuperKey);

	
END;
