// EXPORT Out_Base_Stats_Population := 'todo';

import STRATA, AddressFeedback;
BaseFile := AddressFeedback.File_AddressFeedback_Base;
export Out_Base_Stats_Population(string fileDate) := function
      
rPopulationStats_BaseFile  :=   record
	CountGroup                                        := count(group);
	BaseFile.state;
    did_Cnt                                  := sum(group,if(BaseFile.did<>0,1,0));
    did_scoreCnt                             := sum(group,if(BaseFile.did_score<>0,1,0));	
    hhid_Cnt                                 := sum(group,if(BaseFile.hhid<>0,1,0));
    // Address_feedback_id_Count                        := sum(group,if(BaseFile.Address_feedback_id<>'',1,0));
    Login_history_id_Count                        := sum(group,if(BaseFile.Login_history_id<>'',1,0));
   Unique_id_Count                        := sum(group,if(BaseFile.Unique_id<>'',1,0));
    phone_number_Count                        := sum(group,if(BaseFile.phone_number<>'',1,0));
    fname_Count                               := sum(group,if(BaseFile.fname<>'',1,0));
    lname_Count                               := sum(group,if(BaseFile.lname<>'',1,0));
    mname_Count                               := sum(group,if(BaseFile.mname<>'',1,0));
	orig_street_pre_direction_Count                := sum(group,if(BaseFile.orig_street_pre_direction<>'',1,0));
    orig_street_post_direction_Count               := sum(group,if(BaseFile.orig_street_post_direction<>'',1,0));
    orig_street_number_Count                       := sum(group,if(BaseFile.orig_street_number<>'',1,0));
    orig_street_name_Count                         := sum(group,if(BaseFile.orig_street_name<>'',1,0));
    orig_street_suffix_Count                       := sum(group,if(BaseFile.orig_street_suffix<>'',1,0));
    orig_unit_number_Count                         := sum(group,if(BaseFile.orig_unit_number<>'',1,0));
    orig_unit_designation_Count                    := sum(group,if(BaseFile.orig_unit_designation<>'',1,0));
    orig_zip5_Count                                := sum(group,if(BaseFile.orig_zip5<>'',1,0));
    orig_zip4_Count                                := sum(group,if(BaseFile.orig_zip4<>'',1,0));
    orig_city_Count                                := sum(group,if(BaseFile.orig_city<>'',1,0));
    orig_state_Count                               := sum(group,if(BaseFile.orig_state<>'',1,0));
    street_pre_direction_Count                := sum(group,if(BaseFile.street_pre_direction<>'',1,0));
    street_post_direction_Count               := sum(group,if(BaseFile.street_post_direction<>'',1,0));
    street_number_Count                       := sum(group,if(BaseFile.street_number<>'',1,0));
    street_name_Count                         := sum(group,if(BaseFile.street_name<>'',1,0));
    street_suffix_Count                       := sum(group,if(BaseFile.street_suffix<>'',1,0));
    unit_number_Count                         := sum(group,if(BaseFile.unit_number<>'',1,0));
    unit_designation_Count                    := sum(group,if(BaseFile.unit_designation<>'',1,0));
    zip5_Count                                := sum(group,if(BaseFile.zip5<>'',1,0));
    zip4_Count                                := sum(group,if(BaseFile.zip4<>'',1,0));
    city_Count                                := sum(group,if(BaseFile.city<>'',1,0));
    state_Count                               := sum(group,if(BaseFile.state<>'',1,0));
    alt_phone_Count                           := sum(group,if(BaseFile.alt_phone<>'',1,0));
    other_info_Count                          := sum(group,if(BaseFile.other_info<>'',1,0));
    Address_contact_type_Count                  := sum(group,if(BaseFile.Address_contact_type<>'',1,0));
    feedback_source_Count                     := sum(group,if(BaseFile.feedback_source<>'',1,0));
    date_time_added_Count                     := sum(group,if(BaseFile.date_time_added<>'',1,0));
    // Transaction_id_Count                     := sum(group,if(BaseFile.Transaction_id<>'',1,0));
   loginId_Count                    := sum(group,if(BaseFile. loginId<>'',1,0));
	Companyid_Count                           := sum(group,if(BaseFile.Companyid<>'',1,0));
  end;

dPopulationStats_BaseFile := table(BaseFile, rPopulationStats_BaseFile,  state,  few);

STRATA.createXMLStats(dPopulationStats_BaseFile, 'AddressFeedback', 'base', fileDate, '', resultsOut, 'view','population');
										 
rPopulationStats_BaseFile_data := record
	CountGroup                                        := count(group);
	BaseFile.Companyid;
    did_Cnt                                  := sum(group,if(BaseFile.did<>0,1,0));
    did_scoreCnt                             := sum(group,if(BaseFile.did_score<>0,1,0));	
    hhid_Cnt                                 := sum(group,if(BaseFile.hhid<>0,1,0));
    phone_number_Count                        := sum(group,if(BaseFile.phone_number<>'',1,0));
    fname_Count                               := sum(group,if(BaseFile.fname<>'',1,0));
    lname_Count                               := sum(group,if(BaseFile.lname<>'',1,0));
    mname_Count                               := sum(group,if(BaseFile.mname<>'',1,0));
    street_pre_direction_Count                := sum(group,if(BaseFile.street_pre_direction<>'',1,0));
    street_post_direction_Count               := sum(group,if(BaseFile.street_post_direction<>'',1,0));
    street_number_Count                       := sum(group,if(BaseFile.street_number<>'',1,0));
    street_name_Count                         := sum(group,if(BaseFile.street_name<>'',1,0));
    street_suffix_Count                       := sum(group,if(BaseFile.street_suffix<>'',1,0));
    unit_number_Count                         := sum(group,if(BaseFile.unit_number<>'',1,0));
    unit_designation_Count                    := sum(group,if(BaseFile.unit_designation<>'',1,0));
    zip5_Count                                := sum(group,if(BaseFile.zip5<>'',1,0));
    zip4_Count                                := sum(group,if(BaseFile.zip4<>'',1,0));
    city_Count                                := sum(group,if(BaseFile.city<>'',1,0));
    state_Count                               := sum(group,if(BaseFile.state<>'',1,0));
    alt_phone_Count                           := sum(group,if(BaseFile.alt_phone<>'',1,0));
    other_info_Count                          := sum(group,if(BaseFile.other_info<>'',1,0));
    address_contact_type_Count                  := sum(group,if(BaseFile.address_contact_type<>'',1,0));
    feedback_source_Count                     := sum(group,if(BaseFile.feedback_source<>'',1,0));
    date_time_added_Count                     := sum(group,if(BaseFile.date_time_added<>'',1,0));
    login_history_id_Count                    := sum(group,if(BaseFile.login_history_id<>'',1,0));

  end;

dPopulationStats_BaseFile_data := table(BaseFile, rPopulationStats_BaseFile_data, Companyid, few);

STRATA.createXMLStats(dPopulationStats_BaseFile_data, 'AddressFeedback',  'data',  fileDate,  '', resultsOutdata, 'view', 'population_v2');										 

rPopulationStats_BaseFile_data2 := record
	CountGroup                                        := count(group);
	BaseFile.Companyid;
	BaseFile.feedback_source;
	BaseFile.address_contact_type;
    did_Cnt                                  := sum(group,if(BaseFile.did<>0,1,0));
    did_scoreCnt                             := sum(group,if(BaseFile.did_score<>0,1,0));	
    hhid_Cnt                                 := sum(group,if(BaseFile.hhid<>0,1,0));
    phone_number_Count                        := sum(group,if(BaseFile.phone_number<>'',1,0));
    fname_Count                               := sum(group,if(BaseFile.fname<>'',1,0));
    lname_Count                               := sum(group,if(BaseFile.lname<>'',1,0));
    mname_Count                               := sum(group,if(BaseFile.mname<>'',1,0));
    street_pre_direction_Count                := sum(group,if(BaseFile.street_pre_direction<>'',1,0));
    street_post_direction_Count               := sum(group,if(BaseFile.street_post_direction<>'',1,0));
    street_number_Count                       := sum(group,if(BaseFile.street_number<>'',1,0));
    street_name_Count                         := sum(group,if(BaseFile.street_name<>'',1,0));
    street_suffix_Count                       := sum(group,if(BaseFile.street_suffix<>'',1,0));
    unit_number_Count                         := sum(group,if(BaseFile.unit_number<>'',1,0));
    unit_designation_Count                    := sum(group,if(BaseFile.unit_designation<>'',1,0));
    zip5_Count                                := sum(group,if(BaseFile.zip5<>'',1,0));
    zip4_Count                                := sum(group,if(BaseFile.zip4<>'',1,0));
    city_Count                                := sum(group,if(BaseFile.city<>'',1,0));
    state_Count                               := sum(group,if(BaseFile.state<>'',1,0));
    alt_phone_Count                           := sum(group,if(BaseFile.alt_phone<>'',1,0));
    other_info_Count                          := sum(group,if(BaseFile.other_info<>'',1,0));    
    date_time_added_Count                     := sum(group,if(BaseFile.date_time_added<>'',1,0));
    login_history_id_Count                    := sum(group,if(BaseFile.login_history_id<>'',1,0));
  end;

dPopulationStats_BaseFile_data2 := table(BaseFile, rPopulationStats_BaseFile_data2, Companyid,feedback_source,address_contact_type, few);
															   
STRATA.createXMLStats(dPopulationStats_BaseFile_data2 , 'AddressFeedback2', 'data', fileDate, '', results3, 'view', 'population'  );
 return sequential (resultsOut, resultsoutdata, results3);
 end;