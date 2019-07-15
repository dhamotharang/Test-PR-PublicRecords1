IMPORT STRATA, dx_Email;

EXPORT Strata_Stat_Domain(

	 string pversion
	,DATASET(dx_Email.Layouts.i_Domain_lkp) pdomain	= Email_Event.Files.Domain_lkp
	,string emailList=''

) :=	FUNCTION

rPopulationStats_domain :=  RECORD
	CountGroup									 					:= COUNT(GROUP);
	domain_name_CountNonBlank				   	  := SUM(GROUP,IF(pdomain.domain_name <>'',1,0));
	create_date_CountNonBlank				 		  := SUM(GROUP,IF(pdomain.create_date <>'',1,0));
	expire_date_CountNonBlank				 			:= SUM(GROUP,IF(pdomain.expire_date <>'',1,0));
	date_first_seen_CountNonBlank				 	:= SUM(GROUP,IF(pdomain.date_first_seen <>'',1,0));
	date_last_seen_CountNonBlank				 	:= SUM(GROUP,IF(pdomain.date_last_seen <>'',1,0));
	date_first_verified_CountTrue				 	:= SUM(GROUP,IF(pdomain.date_first_verified ='true',1,0));
	date_last_verified_CountTrue 					:= SUM(GROUP,IF(pdomain.date_last_verified ='true',1,0));
	domain_status_CountNonBlank				 		:= SUM(GROUP,IF(pdomain.domain_status <> '',1,0));
	verifies_account_CountNonBlank				:= SUM(GROUP,IF(pdomain.verifies_account <>'',1,0));
	process_date_CountNonBlank				 		:= SUM(GROUP,IF(pdomain.process_date <>'',1,0));
	email_rec_key_CountNonBlank					  := SUM(GROUP,IF(pdomain.email_rec_key <>0,1,0));
END;


dPopulationStats_domain := TABLE(pdomain
																			,rPopulationStats_domain
																			,FEW);
									
Srt_dPopulationStats_domain := dPopulationStats_domain;

STRATA.createXMLStats(Srt_dPopulationStats_domain
											,'EmailEvent'
											,'Domain'
											,pVersion
											,emailList
											,zdomain);

RETURN zdomain;

END;