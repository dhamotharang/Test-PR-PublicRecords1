import STRATA, PhonesFeedback;

export Out_Base_Stats_Population(string fileDate) := function
      
rPopulationStats_PhonesFeedback__file_phonesFeedback_base
 :=
  record
	CountGroup                                        := count(group);
	phonesFeedback.File_PhonesFeedback_Base.state;
    did_CountNonZero                                  := sum(group,if(phonesFeedback.File_PhonesFeedback_Base.did<>0,1,0));
    did_scoreCountNonZero                             := sum(group,if(phonesFeedback.File_PhonesFeedback_Base.did_score<>0,1,0));	
    hhid_CountNonZero                                 := sum(group,if(phonesFeedback.File_PhonesFeedback_Base.hhid<>0,1,0));
    phone_number_CountNonBlank                        := sum(group,if(phonesFeedback.File_PhonesFeedback_Base.phone_number<>'',1,0));
    fname_CountNonBlank                               := sum(group,if(phonesFeedback.File_PhonesFeedback_Base.fname<>'',1,0));
    lname_CountNonBlank                               := sum(group,if(phonesFeedback.File_PhonesFeedback_Base.lname<>'',1,0));
    mname_CountNonBlank                               := sum(group,if(phonesFeedback.File_PhonesFeedback_Base.mname<>'',1,0));
    street_pre_direction_CountNonBlank                := sum(group,if(phonesFeedback.File_PhonesFeedback_Base.street_pre_direction<>'',1,0));
    street_post_direction_CountNonBlank               := sum(group,if(phonesFeedback.File_PhonesFeedback_Base.street_post_direction<>'',1,0));
    street_number_CountNonBlank                       := sum(group,if(phonesFeedback.File_PhonesFeedback_Base.street_number<>'',1,0));
    street_name_CountNonBlank                         := sum(group,if(phonesFeedback.File_PhonesFeedback_Base.street_name<>'',1,0));
    street_suffix_CountNonBlank                       := sum(group,if(phonesFeedback.File_PhonesFeedback_Base.street_suffix<>'',1,0));
    unit_number_CountNonBlank                         := sum(group,if(phonesFeedback.File_PhonesFeedback_Base.unit_number<>'',1,0));
    unit_designation_CountNonBlank                    := sum(group,if(phonesFeedback.File_PhonesFeedback_Base.unit_designation<>'',1,0));
    zip5_CountNonBlank                                := sum(group,if(phonesFeedback.File_PhonesFeedback_Base.zip5<>'',1,0));
    zip4_CountNonBlank                                := sum(group,if(phonesFeedback.File_PhonesFeedback_Base.zip4<>'',1,0));
    city_CountNonBlank                                := sum(group,if(phonesFeedback.File_PhonesFeedback_Base.city<>'',1,0));
    state_CountNonBlank                               := sum(group,if(phonesFeedback.File_PhonesFeedback_Base.state<>'',1,0));
    alt_phone_CountNonBlank                           := sum(group,if(phonesFeedback.File_PhonesFeedback_Base.alt_phone<>'',1,0));
    other_info_CountNonBlank                          := sum(group,if(phonesFeedback.File_PhonesFeedback_Base.other_info<>'',1,0));
    phone_contact_type_CountNonBlank                  := sum(group,if(phonesFeedback.File_PhonesFeedback_Base.phone_contact_type<>'',1,0));
    feedback_source_CountNonBlank                     := sum(group,if(phonesFeedback.File_PhonesFeedback_Base.feedback_source<>'',1,0));
    date_time_added_CountNonBlank                     := sum(group,if(phonesFeedback.File_PhonesFeedback_Base.date_time_added<>'',1,0));
    login_history_id_CountNonBlank                    := sum(group,if(phonesFeedback.File_PhonesFeedback_Base.login_history_id<>'',1,0));
	customerid_CountNonBlank                           := sum(group,if(phonesFeedback.File_PhonesFeedback_Base.customerid<>'',1,0));
  end;

dPopulationStats_PhonesFeedback__file_phonesFeedback_base := table(phonesFeedback.File_PhonesFeedback_Base,
                                                               rPopulationStats_PhonesFeedback__file_phonesFeedback_base,
                                                               state,
															   few
															   );

STRATA.createXMLStats(dPopulationStats_PhonesFeedback__file_phonesFeedback_base,
                      'PhonesFeedback',
					            'base',
					            fileDate,
					            '',
					            resultsOut,
								'view',
								'population',,,true
					           );
										 
PhonesFeedback.Layouts_PhonesFeedback.Layout_PhonesFeedback_base tr(phonesFeedback.File_PhonesFeedback_Base le) := transform

self.date_time_added := phonesFeedback.dateMMMDDYYYY(trim(le.date_time_added,left,right));
self := le;
end;

file_phonesFeedback_new := project(phonesFeedback.File_PhonesFeedback_Base,tr(LEFT));

file_phonesFeedback_filter_nco := phonesFeedback.File_PhonesFeedback_Base( trim(feedback_source) = '8' and trim(date_time_added[1..8]) < '20130226' ) + phonesFeedback.File_PhonesFeedback_Base ( trim(feedback_source) != '8' ) ;
										 
rPopulationStats_PhonesFeedback__file_phonesFeedback_data
 :=
record
	CountGroup                                        := count(group);
	file_phonesFeedback_filter_nco.customerid;
    did_CountNonZero                                  := sum(group,if(file_phonesFeedback_filter_nco.did<>0,1,0));
    did_scoreCountNonZero                             := sum(group,if(file_phonesFeedback_filter_nco.did_score<>0,1,0));	
    hhid_CountNonZero                                 := sum(group,if(file_phonesFeedback_filter_nco.hhid<>0,1,0));
    phone_number_CountNonBlank                        := sum(group,if(file_phonesFeedback_filter_nco.phone_number<>'',1,0));
    fname_CountNonBlank                               := sum(group,if(file_phonesFeedback_filter_nco.fname<>'',1,0));
    lname_CountNonBlank                               := sum(group,if(file_phonesFeedback_filter_nco.lname<>'',1,0));
    mname_CountNonBlank                               := sum(group,if(file_phonesFeedback_filter_nco.mname<>'',1,0));
    street_pre_direction_CountNonBlank                := sum(group,if(file_phonesFeedback_filter_nco.street_pre_direction<>'',1,0));
    street_post_direction_CountNonBlank               := sum(group,if(file_phonesFeedback_filter_nco.street_post_direction<>'',1,0));
    street_number_CountNonBlank                       := sum(group,if(file_phonesFeedback_filter_nco.street_number<>'',1,0));
    street_name_CountNonBlank                         := sum(group,if(file_phonesFeedback_filter_nco.street_name<>'',1,0));
    street_suffix_CountNonBlank                       := sum(group,if(file_phonesFeedback_filter_nco.street_suffix<>'',1,0));
    unit_number_CountNonBlank                         := sum(group,if(file_phonesFeedback_filter_nco.unit_number<>'',1,0));
    unit_designation_CountNonBlank                    := sum(group,if(file_phonesFeedback_filter_nco.unit_designation<>'',1,0));
    zip5_CountNonBlank                                := sum(group,if(file_phonesFeedback_filter_nco.zip5<>'',1,0));
    zip4_CountNonBlank                                := sum(group,if(file_phonesFeedback_filter_nco.zip4<>'',1,0));
    city_CountNonBlank                                := sum(group,if(file_phonesFeedback_filter_nco.city<>'',1,0));
    state_CountNonBlank                               := sum(group,if(file_phonesFeedback_filter_nco.state<>'',1,0));
    alt_phone_CountNonBlank                           := sum(group,if(file_phonesFeedback_filter_nco.alt_phone<>'',1,0));
    other_info_CountNonBlank                          := sum(group,if(file_phonesFeedback_filter_nco.other_info<>'',1,0));
    phone_contact_type_CountNonBlank                  := sum(group,if(file_phonesFeedback_filter_nco.phone_contact_type<>'',1,0));
    feedback_source_CountNonBlank                     := sum(group,if(file_phonesFeedback_filter_nco.feedback_source<>'',1,0));
    date_time_added_CountNonBlank                     := sum(group,if(file_phonesFeedback_filter_nco.date_time_added<>'',1,0));
    login_history_id_CountNonBlank                    := sum(group,if(file_phonesFeedback_filter_nco.login_history_id<>'',1,0));

  end;

dPopulationStats_PhonesFeedback__file_phonesFeedback_data := table(file_phonesFeedback_filter_nco,
                                                               rPopulationStats_PhonesFeedback__file_phonesFeedback_data,
                                                               customerid,
															   few
															   );

STRATA.createXMLStats(dPopulationStats_PhonesFeedback__file_phonesFeedback_data,
                      'PhonesFeedback',
					            'data',
					            fileDate,
					            '',
					            resultsOutdata,
								'view',
								'population_v2',,,true 
					           );										 

rPopulationStats_PhonesFeedback__file_phonesFeedback_data2
 :=
record
	CountGroup                                        := count(group);
	file_phonesFeedback_filter_nco.customerid;
	file_phonesFeedback_filter_nco.feedback_source;
	file_phonesFeedback_filter_nco.phone_contact_type;
    did_CountNonZero                                  := sum(group,if(file_phonesFeedback_filter_nco.did<>0,1,0));
    did_scoreCountNonZero                             := sum(group,if(file_phonesFeedback_filter_nco.did_score<>0,1,0));	
    hhid_CountNonZero                                 := sum(group,if(file_phonesFeedback_filter_nco.hhid<>0,1,0));
    phone_number_CountNonBlank                        := sum(group,if(file_phonesFeedback_filter_nco.phone_number<>'',1,0));
    fname_CountNonBlank                               := sum(group,if(file_phonesFeedback_filter_nco.fname<>'',1,0));
    lname_CountNonBlank                               := sum(group,if(file_phonesFeedback_filter_nco.lname<>'',1,0));
    mname_CountNonBlank                               := sum(group,if(file_phonesFeedback_filter_nco.mname<>'',1,0));
    street_pre_direction_CountNonBlank                := sum(group,if(file_phonesFeedback_filter_nco.street_pre_direction<>'',1,0));
    street_post_direction_CountNonBlank               := sum(group,if(file_phonesFeedback_filter_nco.street_post_direction<>'',1,0));
    street_number_CountNonBlank                       := sum(group,if(file_phonesFeedback_filter_nco.street_number<>'',1,0));
    street_name_CountNonBlank                         := sum(group,if(file_phonesFeedback_filter_nco.street_name<>'',1,0));
    street_suffix_CountNonBlank                       := sum(group,if(file_phonesFeedback_filter_nco.street_suffix<>'',1,0));
    unit_number_CountNonBlank                         := sum(group,if(file_phonesFeedback_filter_nco.unit_number<>'',1,0));
    unit_designation_CountNonBlank                    := sum(group,if(file_phonesFeedback_filter_nco.unit_designation<>'',1,0));
    zip5_CountNonBlank                                := sum(group,if(file_phonesFeedback_filter_nco.zip5<>'',1,0));
    zip4_CountNonBlank                                := sum(group,if(file_phonesFeedback_filter_nco.zip4<>'',1,0));
    city_CountNonBlank                                := sum(group,if(file_phonesFeedback_filter_nco.city<>'',1,0));
    state_CountNonBlank                               := sum(group,if(file_phonesFeedback_filter_nco.state<>'',1,0));
    alt_phone_CountNonBlank                           := sum(group,if(file_phonesFeedback_filter_nco.alt_phone<>'',1,0));
    other_info_CountNonBlank                          := sum(group,if(file_phonesFeedback_filter_nco.other_info<>'',1,0));    
    date_time_added_CountNonBlank                     := sum(group,if(file_phonesFeedback_filter_nco.date_time_added<>'',1,0));
    login_history_id_CountNonBlank                    := sum(group,if(file_phonesFeedback_filter_nco.login_history_id<>'',1,0));
  end;

dPopulationStats_PhonesFeedback__file_phonesFeedback_data2 := table(file_phonesFeedback_filter_nco,
                                                               rPopulationStats_PhonesFeedback__file_phonesFeedback_data2,
                                                               customerid,feedback_source,phone_contact_type,
															   few
															   );
															   
STRATA.createXMLStats(dPopulationStats_PhonesFeedback__file_phonesFeedback_data2,
                      'PhonesFeedback2',
					            'data',
					            fileDate,
					            '',
					            results3,
								'view',
								'population',,,true 
					           );
	 
 return sequential (resultsOut, resultsoutdata, results3);
 
 end;