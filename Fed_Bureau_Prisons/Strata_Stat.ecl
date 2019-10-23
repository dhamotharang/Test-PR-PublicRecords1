//

import strata;

export Strata_Stat(string pversion ,dataset(Fed_Bureau_Prisons.layout_federal_bureau_base) fed_base	= Fed_Bureau_Prisons.file_federal_bureau_base) := function

  rPopulationStats_fed_base :=  record
		CountGroup := count(group);
		fed_base.source;
		key_CountNonZero:= sum(group,if(fed_base.key > 0,1,0));
		offender_key_CountNonBlank := sum(group,if(fed_base.offender_key <>'',1,0));  
		persistent_key_CountNonBlank := sum(group,if(fed_base.persistent_key <>'',1,0));
		process_date_CountNonBlank := sum(group,if(fed_base.process_date <>'',1,0));
		date_first_seen_CountNonBlank := sum(group,if(fed_base.date_first_seen <>'',1,0));
		date_last_seen_CountNonBlank := sum(group,if(fed_base.date_last_seen <>'',1,0));
		date_vendor_first_reported_CountNonBlank := sum(group,if(fed_base.date_vendor_first_reported <>'',1,0));
		date_vendor_last_reported_CountNonBlank := sum(group,if(fed_base.date_vendor_last_reported <>'',1,0));
		Record_ID_CountNonBlank := sum(group,if(fed_base.Record_ID <>'',1,0));
		Record_Upload_Date_CountNonBlank := sum(group,if(fed_base.Record_Upload_Date <>'',1,0));
		category_CountNonBlank := sum(group,if(fed_base.category <>'',1,0));
		source_CountNonBlank := sum(group,if(fed_base.source <>'',1,0));
		orig_name_CountNonBlank := sum(group,if(fed_base.orig_name <>'',1,0));
		orig_lastName_CountNonBlank := sum(group,if(fed_base.orig_lastName <>'',1,0));
		orig_firstName_CountNonBlank := sum(group,if(fed_base.orig_firstName <>'',1,0));
		orig_middleName_CountNonBlank := sum(group,if(fed_base.orig_middleName <>'',1,0));
		orig_suffix_CountNonBlank := sum(group,if(fed_base.orig_suffix <>'',1,0));
		DOB_CountNonBlank := sum(group,if(fed_base.DOB <>'',1,0));
		sex_CountNonBlank := sum(group,if(fed_base.sex <>'',1,0));
		race_CountNonBlank := sum(group,if(fed_base.race <>'',1,0));
		age_CountNonBlank := sum(group,if(fed_base.age <>'',1,0));
		Registery_Number_CountNonBlank := sum(group,if(fed_base.Registery_Number <>'',1,0)); 
		Defendant_Status_CountNonBlank := sum(group,if(fed_base.Defendant_Status <>'',1,0));
		offense_description_CountNonBlank := sum(group,if(fed_base.offense_description <>'',1,0));
		disposition_CountNonBlank := sum(group,if(fed_base.disposition <>'',1,0));
		Scheduled_Release_Date_CountNonBlank := sum(group,if(fed_base.Scheduled_Release_Date <>'',1,0));
		nametype_CountNonBlank := sum(group,if(fed_base.nametype <>'',1,0));  
		nid_CountNonZero := sum(group,if(fed_base.nid > 0,1,0));  
		title_CountNonBlank := sum(group,if(fed_base.title <>'',1,0));
		fname_CountNonBlank := sum(group,if(fed_base.fname <>'',1,0));
		mname_CountNonBlank := sum(group,if(fed_base.mname <>'',1,0));
		lname_CountNonBlank := sum(group,if(fed_base.lname <>'',1,0));
		suffix_CountNonBlank := sum(group,if(fed_base.suffix <>'',1,0));
		name_ind_CountNonZero := sum(group,if(fed_base.name_ind > 0,1,0));	
		rec_type_CountNonZero := sum(group,if(fed_base.rec_type > 0,1,0));
	end;

  dPopulationStats_fed_base := table(fed_base
																				,rPopulationStats_fed_base
																		    ,source
																		    ,few);
									
  srt_dPopulationStats_fed_base := sort(dPopulationStats_fed_base,source);	

  STRATA.createXMLStats(srt_dPopulationStats_fed_base
					 ,'Fed_Bureau'
					 ,'_Prisons20'  //rename to _Prisons
					 ,pVersion
					 ,'tarun.patel@lexisnexis.com'
					 ,outStrata);

  return outStrata;

end;

