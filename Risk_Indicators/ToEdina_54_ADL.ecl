multiple_file_test := false;  // only set this to true in development environment when testing multiple shell files at the same time

import risk_indicators, riskprocessing, riskview;

#if(multiple_file_test)

	layout_internal := RECORD
		string20 file_ind;
		riskprocessing.layouts.layout_internal_shell
	END;

	edina_plus_bob_v54 := record
			 string20 file_ind;
			 risk_indicators.iid_constants.adl_based_modeling_flags ADL_Shell_Flags;
			 risk_indicators.Layout_Boca_Shell_Edina_v54;
	end;

export ToEdina_54_ADL( dataset(layout_internal) bs, boolean isFCRA=false, string dataRestrictionMask, string Intended_Purpose ) := FUNCTION

		edina_plus_bob_v54 convertToEdina_v54(bs le) := transform
			self.file_ind := le.file_ind;
	
#else

export ToEdina_54_ADL( dataset(riskprocessing.layouts.layout_internal_shell) bs, boolean isFCRA=false, string dataRestrictionMask, string Intended_Purpose ) := FUNCTION

	edina_plus_bob_v54 := record
		risk_indicators.iid_constants.adl_based_modeling_flags ADL_Shell_Flags;
		risk_indicators.Layout_Boca_Shell_Edina_v54;
	end;
	edina_plus_bob_v54 convertToEdina_v54(bs le) := transform
	
#end
		
	self.bsversion := 54;
	self.iid.deceasedDate := le.ssn_verification.validation.deceasedDate;
	self.address_verification.input_address_information.dirty_address := le.address_verification.inputaddr_dirty; 
	self.address_verification.input_address_information.not_verified := le.address_verification.inputAddr_not_verified;
	self.address_verification.input_address_information.owned_not_occupied := le.address_verification.inputaddr_owned_not_occupied;
	self.address_verification.input_address_information.non_relative_ADLs := le.address_verification.inputaddr_non_relative_did_count;
	self.address_verification.input_address_information.occupancy_index := le.address_verification.inputaddr_occupancy_index;
	self.address_verification.Address_History_1.occupancy_index := le.address_verification.currAddr_occupancy_index;
	
	self.other_address_info.addrsMilitaryEver := le.addrsMilitaryEver;
	self.other_address_info.economic_trajectory := le.economic_trajectory;
	self.other_address_info.economic_trajectory_index := le.economic_trajectory_index;
	self.other_address_info.unverified_addr_count := le.address_verification.unverified_addr_count;
	
	self.address_verification.input_address_information.addr_sources := le.address_sources_summary.input_addr_sources;
	self.address_verification.input_address_information.addr_sources_first_seen_date := le.address_sources_summary.input_addr_sources_first_seen_date;
	self.address_verification.input_address_information.addr_sources_recordcount := le.address_sources_summary.input_addr_sources_recordcount;
			
	self.address_verification.Address_History_1.addr_sources := le.address_sources_summary.current_addr_sources;
	self.address_verification.Address_History_1.addr_sources_first_seen_date := le.address_sources_summary.current_addr_sources_first_seen_date;
	self.address_verification.Address_History_1.addr_sources_recordcount := le.address_sources_summary.current_addr_sources_recordcount;
	
	self.address_verification.Address_History_2.addr_sources := le.address_sources_summary.previous_addr_sources;
	self.address_verification.Address_History_2.addr_sources_first_seen_date := le.address_sources_summary.previous_addr_sources_first_seen_date;
	self.address_verification.Address_History_2.addr_sources_recordcount := le.address_sources_summary.previous_addr_sources_recordcount;
		
	self.Address_Verification.Address_History_2.Address_Vacancy_Indicator	:= le.advo_addr_hist2.Address_Vacancy_Indicator	;
	self.Address_Verification.Address_History_2.Throw_Back_Indicator := le.advo_addr_hist2.Throw_Back_Indicator	;
	self.Address_Verification.Address_History_2.Seasonal_Delivery_Indicator := le.advo_addr_hist2.Seasonal_Delivery_Indicator;
	self.Address_Verification.Address_History_2.DND_Indicator := le.advo_addr_hist2.DND_Indicator	;
	self.Address_Verification.Address_History_2.College_Indicator := le.advo_addr_hist2.College_Indicator;
	self.Address_Verification.Address_History_2.Drop_Indicator	:= le.advo_addr_hist2.Drop_Indicator;
	self.Address_Verification.Address_History_2.Residential_or_Business_Ind	:= le.advo_addr_hist2.Residential_or_Business_Ind	;
	self.Address_Verification.Address_History_2.Mixed_Address_Usage := le.advo_addr_hist2.Mixed_Address_Usage;
	
	self.address_verification.address_history_2.avm_automated_valuation := le.avm.address_history_2.avm_automated_valuation;
	self.address_verification.address_history_2.avm_automated_valuation2 := le.avm.address_history_2.avm_automated_valuation2;
	self.address_verification.address_history_2.avm_automated_valuation3 := le.avm.address_history_2.avm_automated_valuation3;
	self.address_verification.address_history_2.avm_automated_valuation4 := le.avm.address_history_2.avm_automated_valuation4;
	self.address_verification.address_history_2.avm_automated_valuation5 := le.avm.address_history_2.avm_automated_valuation5;
	self.address_verification.address_history_2.avm_automated_valuation6 := le.avm.address_history_2.avm_automated_valuation6;
	self.address_verification.address_history_2.avm_confidence_score := le.avm.address_history_2.avm_confidence_score;
	self.address_verification.address_history_2.avm_median_fips_level := le.avm.address_history_2.avm_median_fips_level;
	self.address_verification.address_history_2.avm_median_geo11_level := le.avm.address_history_2.avm_median_geo11_level;
	self.address_verification.address_history_2.avm_median_geo12_level := le.avm.address_history_2.avm_median_geo12_level;

	self.Address_Verification.address_history_2.occupants_1yr := le.addr_risk_summary3.occupants_1yr ;
	self.Address_Verification.address_history_2.turnover_1yr_in := le.addr_risk_summary3.turnover_1yr_in ;
	self.Address_Verification.address_history_2.turnover_1yr_out := le.addr_risk_summary3.turnover_1yr_out ;
	self.Address_Verification.address_history_2.N_Vacant_Properties := le.addr_risk_summary3.N_Vacant_Properties;
	self.Address_Verification.address_history_2.N_Business_Count := le.addr_risk_summary3.N_Business_Count ;
	self.Address_Verification.address_history_2.N_SFD_Count := le.addr_risk_summary3.N_SFD_Count ;
	self.Address_Verification.address_history_2.N_MFD_Count := le.addr_risk_summary3.N_MFD_Count;
	self.Address_Verification.address_history_2.N_ave_building_age := le.addr_risk_summary3.N_ave_building_age;
	self.Address_Verification.address_history_2.N_ave_purchase_amount := le.addr_risk_summary3.N_ave_purchase_amount ;
	self.Address_Verification.address_history_2.N_ave_mortgage_amount := le.addr_risk_summary3.N_ave_mortgage_amount ;
	self.Address_Verification.address_history_2.N_ave_assessed_amount := le.addr_risk_summary3.N_ave_assessed_amount ;
	self.Address_Verification.address_history_2.N_ave_building_area := le.addr_risk_summary3.N_ave_building_area ;
	self.Address_Verification.address_history_2.N_ave_price_per_sf := le.addr_risk_summary3.N_ave_price_per_sf ;
	self.Address_Verification.address_history_2.N_ave_no_of_stories_count := le.addr_risk_summary3.N_ave_no_of_stories_count ;
	self.Address_Verification.address_history_2.N_ave_no_of_rooms_count := le.addr_risk_summary3.N_ave_no_of_rooms_count ;
	self.Address_Verification.address_history_2.N_ave_no_of_bedrooms_count := le.addr_risk_summary3.N_ave_no_of_bedrooms_count ;
	self.Address_Verification.address_history_2.N_ave_no_of_baths_count := le.addr_risk_summary3.N_ave_no_of_baths_count ;	
	
	self.phone_verification.Insurance_Phone_Verification := le.insurance_phones_summary.Insurance_Phone_Verification;
	self.phone_verification.phone_ver_bureau := le.phone_ver_bureau;  //this name was changed for 5.4 to use the new field that is non Experian specific
	self.student.attended_college := le.attended_college;	
// end of shell 5.0 new content	
	
	
		self.address_verification.input_address_information.lres := le.lres;
		self.address_verification.address_history_1.lres := le.lres2;
		self.address_verification.address_history_2.lres := le.lres3;
		self.address_verification.input_address_information.addrPop := le.addrPop;
		self.address_verification.address_history_1.addrPop := le.addrPop2;
		self.address_verification.address_history_2.addrPop := le.addrPop3;

		self.address_verification.input_address_information.avm_automated_valuation := le.avm.input_address_information.avm_automated_valuation;
		self.address_verification.input_address_information.avm_confidence_score := le.avm.input_address_information.avm_confidence_score;
		self.address_verification.input_address_information.avm_median_fips_level := le.avm.input_address_information.avm_median_fips_level;
		self.address_verification.input_address_information.avm_median_geo11_level := le.avm.input_address_information.avm_median_geo11_level;
		self.address_verification.input_address_information.avm_median_geo12_level := le.avm.input_address_information.avm_median_geo12_level;
		
		self.address_verification.address_history_1.avm_automated_valuation := le.avm.address_history_1.avm_automated_valuation;
		self.address_verification.address_history_1.avm_confidence_score := le.avm.address_history_1.avm_confidence_score;
		self.address_verification.address_history_1.avm_median_fips_level := le.avm.address_history_1.avm_median_fips_level;
		self.address_verification.address_history_1.avm_median_geo11_level := le.avm.address_history_1.avm_median_geo11_level;
		self.address_verification.address_history_1.avm_median_geo12_level := le.avm.address_history_1.avm_median_geo12_level;
		
		SELF.Velocity_Counters.adlPerSSN_count := le.SSN_Verification.adlPerSSN_count;
		
		self.iid.socllowissue := (unsigned)le.iid.socllowissue;
		self.iid.soclhighissue := (unsigned)le.iid.soclhighissue;
		self.student.date_first_seen := (unsigned)le.student.date_first_seen;
		self.student.date_last_seen := (unsigned)le.student.date_last_seen;
		self.student.dob_formatted := (unsigned)le.student.dob_formatted;
		self.student.college_tier := le.student.college_tier;
		
		
		// new shell 2.5 fields
		self.isFCRA := if(isFCRA,'1','0');
		
		self.rv_scores := if( isFCRA, le.rv_scores); // riskview not populated in non-fcra
		self.fd_scores := if(~isFCRA, le.fd_scores); // fraud defender not populated in fcra
		////////////
		
		
		//// new shell 3.0 fields
		self.cb_allowed := map(	dataRestrictionMask[6]<>'1' and dataRestrictionMask[8]<>'1' and dataRestrictionMask[10]<>'1' => 'ALL',
								dataRestrictionMask[8]<>'1' => 'EQ',
								dataRestrictionMask[6]<>'1' => 'EN',
								dataRestrictionMask[10]<>'1' => 'TN',
								'NONE');		// this should not happen
								
		self.iid.ConsumerFlags := le.ConsumerFlags;
		
		self.ssn_verification.inputsocscharflag := le.ssn_verification.validation.inputsocscharflag;
		
		SELF.Address_Verification.Address_History_1.addr_type := le.Address_Verification.addr_type2;
		self.Address_Verification.Address_History_2.addr_type := le.Address_Verification.addr_type3;

		self.input_dob_age := le.shell_input.age;
		
		self.Address_Verification.Input_Address_Information.avm_automated_valuation2 := le.avm.input_address_information.avm_automated_valuation2;
		self.Address_Verification.Input_Address_Information.avm_automated_valuation3 := le.avm.input_address_information.avm_automated_valuation3;
		self.Address_Verification.Input_Address_Information.avm_automated_valuation4 := le.avm.input_address_information.avm_automated_valuation4;
		self.Address_Verification.Input_Address_Information.avm_automated_valuation5 := le.avm.input_address_information.avm_automated_valuation5;
		self.Address_Verification.Input_Address_Information.avm_automated_valuation6 := le.avm.input_address_information.avm_automated_valuation6;
		
		self.Address_Verification.Address_History_1.avm_automated_valuation2 := le.avm.address_history_1.avm_automated_valuation2;
		self.Address_Verification.Address_History_1.avm_automated_valuation3 := le.avm.address_history_1.avm_automated_valuation3;
		self.Address_Verification.Address_History_1.avm_automated_valuation4 := le.avm.address_history_1.avm_automated_valuation4;
		self.Address_Verification.Address_History_1.avm_automated_valuation5 := le.avm.address_history_1.avm_automated_valuation5;
		self.Address_Verification.Address_History_1.avm_automated_valuation6 := le.avm.address_history_1.avm_automated_valuation6;		
		
		self.attributes.addrs_last30 := le.other_address_info.addrs_last30;
		self.attributes.addrs_last90 := le.other_address_info.addrs_last90;
		self.attributes.addrs_last12 := le.other_address_info.addrs_last12;
		self.attributes.addrs_last24 := le.other_address_info.addrs_last24;
		self.attributes.addrs_last36 := le.other_address_info.addrs_last36;
		self.attributes.date_first_purchase := le.other_address_info.date_first_purchase;	
		self.attributes.date_most_recent_purchase := le.other_address_info.date_most_recent_purchase;	
		self.attributes.date_most_recent_sale := le.other_address_info.date_most_recent_sale;	
		// self.attributes.num_purchase30 := le.other_address_info.num_purchase30;
		// self.attributes.num_purchase90 := le.other_address_info.num_purchase90;
		// self.attributes.num_purchase180 := le.other_address_info.num_purchase180;
		// self.attributes.num_purchase12 := le.other_address_info.num_purchase12;
		// self.attributes.num_purchase24 := le.other_address_info.num_purchase24;
		// self.attributes.num_purchase36 := le.other_address_info.num_purchase36;
		// self.attributes.num_purchase60 := le.other_address_info.num_purchase60;
		// self.attributes.num_sold30 := le.other_address_info.num_sold30;
		// self.attributes.num_sold90 := le.other_address_info.num_sold90;
		// self.attributes.num_sold180 := le.other_address_info.num_sold180;
		// self.attributes.num_sold12 := le.other_address_info.num_sold12;
		// self.attributes.num_sold24 := le.other_address_info.num_sold24;
		// self.attributes.num_sold36 := le.other_address_info.num_sold36;
		// self.attributes.num_sold60 := le.other_address_info.num_sold60;
		// self.attributes.num_watercraft30 := le.watercraft.watercraft_count30;
		// self.attributes.num_watercraft90 := le.watercraft.watercraft_count90;
		// self.attributes.num_watercraft180 := le.watercraft.watercraft_count180;
		// self.attributes.num_watercraft12 := le.watercraft.watercraft_count12;
		// self.attributes.num_watercraft24 := le.watercraft.watercraft_count24;
		// self.attributes.num_watercraft36 := le.watercraft.watercraft_count36;
		// self.attributes.num_watercraft60 := le.watercraft.watercraft_count60;
		self.attributes.num_aircraft := le.aircraft.aircraft_count;
		// self.attributes.num_aircraft30 := le.aircraft.aircraft_count30;
		// self.attributes.num_aircraft90 := le.aircraft.aircraft_count90;
		// self.attributes.num_aircraft180 := le.aircraft.aircraft_count180;
		// self.attributes.num_aircraft12 := le.aircraft.aircraft_count12;
		// self.attributes.num_aircraft24 := le.aircraft.aircraft_count24;
		// self.attributes.num_aircraft36 := le.aircraft.aircraft_count36;
		// self.attributes.num_aircraft60 := le.aircraft.aircraft_count60;
		self.attributes.total_number_derogs := le.total_number_derogs;
		self.attributes.date_last_derog := le.date_last_derog;
		// self.attributes.felonies30 := le.bjl.criminal_count30;
		// self.attributes.felonies90 := le.bjl.criminal_count90;
		// self.attributes.felonies180 := le.bjl.criminal_count180;
		// self.attributes.felonies12 := le.bjl.criminal_count12;
		// self.attributes.felonies24 := le.bjl.criminal_count24;
		// self.attributes.felonies36 := le.bjl.criminal_count36;
		// self.attributes.felonies60 := le.bjl.criminal_count60;
		self.attributes.arrests := le.bjl.arrests_count;
		self.attributes.date_last_arrest := le.bjl.date_last_arrest;	
		// self.attributes.arrests30 := le.bjl.arrests_count30;
		// self.attributes.arrests90 := le.bjl.arrests_count90;
		// self.attributes.arrests180 := le.bjl.arrests_count180;
		// self.attributes.arrests12 := le.bjl.arrests_count12;
		// self.attributes.arrests24 := le.bjl.arrests_count24;
		// self.attributes.arrests36 := le.bjl.arrests_count36;
		// self.attributes.arrests60 := le.bjl.arrests_count60;
		self.attributes.num_unreleased_liens30 := le.bjl.liens_unreleased_count30;
		self.attributes.num_unreleased_liens90 := le.bjl.liens_unreleased_count90;
		self.attributes.num_unreleased_liens180 := le.bjl.liens_unreleased_count180;
		self.attributes.num_unreleased_liens12 := le.bjl.liens_unreleased_count12;
		self.attributes.num_unreleased_liens24 := le.bjl.liens_unreleased_count24;
		self.attributes.num_unreleased_liens36 := le.bjl.liens_unreleased_count36;
		self.attributes.num_unreleased_liens60 := le.bjl.liens_unreleased_count60;
		self.attributes.num_released_liens30 := le.bjl.liens_released_count30;
		self.attributes.num_released_liens90 := le.bjl.liens_released_count90;
		self.attributes.num_released_liens180 := le.bjl.liens_released_count180;
		self.attributes.num_released_liens12 := le.bjl.liens_released_count12;
		self.attributes.num_released_liens24 := le.bjl.liens_released_count24;
		self.attributes.num_released_liens36 := le.bjl.liens_released_count36;
		self.attributes.num_released_liens60 := le.bjl.liens_released_count60;
		self.attributes.bankruptcy_count30 := le.bjl.bk_count30;
		self.attributes.bankruptcy_count90 := le.bjl.bk_count90;
		self.attributes.bankruptcy_count180 := le.bjl.bk_count180;
		self.attributes.bankruptcy_count12 := le.bjl.bk_count12;
		self.attributes.bankruptcy_count24 := le.bjl.bk_count24;
		self.attributes.bankruptcy_count36 := le.bjl.bk_count36;
		self.attributes.bankruptcy_count60 := le.bjl.bk_count60;
		self.attributes.eviction_count := le.bjl.eviction_count;
		self.attributes.date_last_eviction := le.bjl.last_eviction_date;
		self.attributes.eviction_count30 := le.bjl.eviction_count30;
		self.attributes.eviction_count90 := le.bjl.eviction_count90;
		self.attributes.eviction_count180 := le.bjl.eviction_count180;
		self.attributes.eviction_count12 := le.bjl.eviction_count12;
		self.attributes.eviction_count24 := le.bjl.eviction_count24;
		self.attributes.eviction_count36 := le.bjl.eviction_count36;
		self.attributes.eviction_count60 := le.bjl.eviction_count60;
		self.attributes.num_nonderogs := le.source_verification.num_nonderogs;
		self.attributes.num_nonderogs30 := le.source_verification.num_nonderogs30;
		self.attributes.num_nonderogs90 := le.source_verification.num_nonderogs90;
		self.attributes.num_nonderogs180 := le.source_verification.num_nonderogs180;
		self.attributes.num_nonderogs12 := le.source_verification.num_nonderogs12;
		self.attributes.num_nonderogs24 := le.source_verification.num_nonderogs24;
		self.attributes.num_nonderogs36 := le.source_verification.num_nonderogs36;
		self.attributes.num_nonderogs60 := le.source_verification.num_nonderogs60;
		// self.attributes.num_proflic30 := le.professional_license.proflic_count30;
		// self.attributes.num_proflic90 := le.professional_license.proflic_count90;
		// self.attributes.num_proflic180 := le.professional_license.proflic_count180;
		// self.attributes.num_proflic12 := le.professional_license.proflic_count12;
		// self.attributes.num_proflic24 := le.professional_license.proflic_count24;
		// self.attributes.num_proflic36 := le.professional_license.proflic_count36;
		// self.attributes.num_proflic60 := le.professional_license.proflic_count60;
		// self.attributes.num_proflic_exp30 := le.professional_license.expire_count30;
		// self.attributes.num_proflic_exp90 := le.professional_license.expire_count90;
		// self.attributes.num_proflic_exp180 := le.professional_license.expire_count180;
		// self.attributes.num_proflic_exp12 := le.professional_license.expire_count12;
		// self.attributes.num_proflic_exp24 := le.professional_license.expire_count24;
		// self.attributes.num_proflic_exp36 := le.professional_license.expire_count36;
		// self.attributes.num_proflic_exp60 := le.professional_license.expire_count60;
		
		self.infutor := le.infutor_phone;	// puts the infutor phone results into the infutor spot to match previous output
		self.iid.correctlast := if(le.iid.correctlast<>'', '1','0');	// brent doesn't want to see lastnames, so populate with a 1 or 0
		self.estimated_income := le.estimated_income;
		
		
	self.student.college_major := le.student.college_major;  // won't need this when college major put into the student section correctly
	self.student.file_type := le.student.file_type2;
	
	self.address_verification.input_address_information.market_total_value := le.address_verification.input_address_information.assessed_amount;
	self.address_verification.address_history_1.market_total_value := le.address_verification.address_history_1.assessed_amount;
	self.address_verification.address_history_2.market_total_value := le.address_verification.address_history_2.assessed_amount;
	
	self.Other_Address_Info.address_history_advo_college_hit := le.address_history_summary.address_history_advo_college_hit;
	
	self.Address_Verification.Input_Address_Information.Address_Vacancy_Indicator	:= le.advo_input_addr.Address_Vacancy_Indicator	;
	self.Address_Verification.Input_Address_Information.Throw_Back_Indicator := le.advo_input_addr.Throw_Back_Indicator	;
	self.Address_Verification.Input_Address_Information.Seasonal_Delivery_Indicator := le.advo_input_addr.Seasonal_Delivery_Indicator;
	self.Address_Verification.Input_Address_Information.DND_Indicator := le.advo_input_addr.DND_Indicator	;
	self.Address_Verification.Input_Address_Information.College_Indicator := le.advo_input_addr.College_Indicator;
	self.Address_Verification.Input_Address_Information.Drop_Indicator	:= le.advo_input_addr.Drop_Indicator;
	self.Address_Verification.Input_Address_Information.Residential_or_Business_Ind	:= le.advo_input_addr.Residential_or_Business_Ind	;
	self.Address_Verification.Input_Address_Information.Mixed_Address_Usage := le.advo_input_addr.Mixed_Address_Usage;
	
	self.Address_Verification.Input_Address_Information.occupants_1yr := le.addr_risk_summary.occupants_1yr ;
	self.Address_Verification.Input_Address_Information.turnover_1yr_in := le.addr_risk_summary.turnover_1yr_in ;
	self.Address_Verification.Input_Address_Information.turnover_1yr_out := le.addr_risk_summary.turnover_1yr_out ;
	self.Address_Verification.Input_Address_Information.N_Vacant_Properties := le.addr_risk_summary.N_Vacant_Properties;
	self.Address_Verification.Input_Address_Information.N_Business_Count := le.addr_risk_summary.N_Business_Count ;
	self.Address_Verification.Input_Address_Information.N_SFD_Count := le.addr_risk_summary.N_SFD_Count ;
	self.Address_Verification.Input_Address_Information.N_MFD_Count := le.addr_risk_summary.N_MFD_Count;
	self.Address_Verification.Input_Address_Information.N_ave_building_age := le.addr_risk_summary.N_ave_building_age;
	self.Address_Verification.Input_Address_Information.N_ave_purchase_amount := le.addr_risk_summary.N_ave_purchase_amount ;
	self.Address_Verification.Input_Address_Information.N_ave_mortgage_amount := le.addr_risk_summary.N_ave_mortgage_amount ;
	self.Address_Verification.Input_Address_Information.N_ave_assessed_amount := le.addr_risk_summary.N_ave_assessed_amount ;
	self.Address_Verification.Input_Address_Information.N_ave_building_area := le.addr_risk_summary.N_ave_building_area ;
	self.Address_Verification.Input_Address_Information.N_ave_price_per_sf := le.addr_risk_summary.N_ave_price_per_sf ;
	self.Address_Verification.Input_Address_Information.N_ave_no_of_stories_count := le.addr_risk_summary.N_ave_no_of_stories_count ;
	self.Address_Verification.Input_Address_Information.N_ave_no_of_rooms_count := le.addr_risk_summary.N_ave_no_of_rooms_count ;
	self.Address_Verification.Input_Address_Information.N_ave_no_of_bedrooms_count := le.addr_risk_summary.N_ave_no_of_bedrooms_count ;
	self.Address_Verification.Input_Address_Information.N_ave_no_of_baths_count := le.addr_risk_summary.N_ave_no_of_baths_count ;	

	self.Address_Verification.Address_History_1.Address_Vacancy_Indicator	:= le.advo_addr_hist1.Address_Vacancy_Indicator	;
	self.Address_Verification.Address_History_1.Throw_Back_Indicator := le.advo_addr_hist1.Throw_Back_Indicator	;
	self.Address_Verification.Address_History_1.Seasonal_Delivery_Indicator := le.advo_addr_hist1.Seasonal_Delivery_Indicator;
	self.Address_Verification.Address_History_1.DND_Indicator := le.advo_addr_hist1.DND_Indicator	;
	self.Address_Verification.Address_History_1.College_Indicator := le.advo_addr_hist1.College_Indicator;
	self.Address_Verification.Address_History_1.Drop_Indicator	:= le.advo_addr_hist1.Drop_Indicator;
	self.Address_Verification.Address_History_1.Residential_or_Business_Ind	:= le.advo_addr_hist1.Residential_or_Business_Ind	;
	self.Address_Verification.Address_History_1.Mixed_Address_Usage := le.advo_addr_hist1.Mixed_Address_Usage;
	
	self.Address_Verification.Address_History_1.occupants_1yr := le.addr_risk_summary2.occupants_1yr ;
	self.Address_Verification.Address_History_1.turnover_1yr_in := le.addr_risk_summary2.turnover_1yr_in ;
	self.Address_Verification.Address_History_1.turnover_1yr_out := le.addr_risk_summary2.turnover_1yr_out ;
	self.Address_Verification.Address_History_1.N_Vacant_Properties := le.addr_risk_summary2.N_Vacant_Properties;
	self.Address_Verification.Address_History_1.N_Business_Count := le.addr_risk_summary2.N_Business_Count ;
	self.Address_Verification.Address_History_1.N_SFD_Count := le.addr_risk_summary2.N_SFD_Count ;
	self.Address_Verification.Address_History_1.N_MFD_Count := le.addr_risk_summary2.N_MFD_Count;
	self.Address_Verification.Address_History_1.N_ave_building_age := le.addr_risk_summary2.N_ave_building_age;
	self.Address_Verification.Address_History_1.N_ave_purchase_amount := le.addr_risk_summary2.N_ave_purchase_amount ;
	self.Address_Verification.Address_History_1.N_ave_mortgage_amount := le.addr_risk_summary2.N_ave_mortgage_amount ;
	self.Address_Verification.Address_History_1.N_ave_assessed_amount := le.addr_risk_summary2.N_ave_assessed_amount ;
	self.Address_Verification.Address_History_1.N_ave_building_area := le.addr_risk_summary2.N_ave_building_area ;
	self.Address_Verification.Address_History_1.N_ave_price_per_sf := le.addr_risk_summary2.N_ave_price_per_sf ;
	self.Address_Verification.Address_History_1.N_ave_no_of_stories_count := le.addr_risk_summary2.N_ave_no_of_stories_count ;
	self.Address_Verification.Address_History_1.N_ave_no_of_rooms_count := le.addr_risk_summary2.N_ave_no_of_rooms_count ;
	self.Address_Verification.Address_History_1.N_ave_no_of_bedrooms_count := le.addr_risk_summary2.N_ave_no_of_bedrooms_count ;
	self.Address_Verification.Address_History_1.N_ave_no_of_baths_count := le.addr_risk_summary2.N_ave_no_of_baths_count ;	
	
	
// blank these out for 5.0 FCRA shell	
		self.iid.areacodesplitdate := if(isFCRA, 0, (unsigned)le.iid.areacodesplitdate);
		self.iid.areacodesplitflag := if(isFCRA, '', le.iid.areacodesplitflag);		
		self.iid.drlcvalflag := if(isFCRA, '', le.iid.drlcvalflag);
		self.iid.name_addr_phone := if(isFCRA, '', le.iid.name_addr_phone);
		self.iid.DIDCount := if(isFCRA, 0, le.iid.didcount);
		self.iid.DID2 := if(isFCRA, 0, le.iid.did2);	
		self.iid.DID3 := if(isFCRA, 0, le.iid.did3);
		self.address_verification.input_address_information.county := if(isFCRA, '', le.address_verification.input_address_information.county);
		self.address_verification.input_address_information.geo_blk := if(isFCRA, '', le.address_verification.input_address_information.geo_blk);
		self.address_verification.address_history_1.county := if(isFCRA, '', le.address_verification.address_history_1.county);
		self.address_verification.address_history_1.geo_blk := if(isFCRA, '', le.address_verification.address_history_1.geo_blk);
		self.address_verification.address_history_2.county := if(isFCRA, '', le.address_verification.address_history_2.county);
		self.address_verification.address_history_2.geo_blk := if(isFCRA, '', le.address_verification.address_history_2.geo_blk);
		self.phone_verification.recent_disconnects := if(isFCRA, 0, le.phone_verification.recent_disconnects);
		self.velocity_counters.addrs_per_ssn := if(isFCRA, 0, le.velocity_counters.addrs_per_ssn ); 
		self.velocity_counters.addrs_per_ssn_created_6months := if(isFCRA, 0, le.velocity_counters.addrs_per_ssn_created_6months );			
		self.velocity_counters.phones_per_addr_created_6months := if(isFCRA, 0, le.velocity_counters.phones_per_addr_created_6months );
		self.velocity_counters.adls_per_phone_created_6months := if(isFCRA, 0, le.velocity_counters.adls_per_phone_created_6months );
		self.acc_logs.inq_peradl_count_day := if(isFCRA, 0, le.acc_logs.inq_peradl_count_day );
		self.acc_logs.inq_peradl_count_week := if(isFCRA, 0, le.acc_logs.inq_peradl_count_week );
		self.acc_logs.inq_ssnsperadl_count_day := if(isFCRA, 0, le.acc_logs.inq_ssnsperadl_count_day );
		self.acc_logs.inq_ssnsperadl_count_week := if(isFCRA, 0, le.acc_logs.inq_ssnsperadl_count_week );
		self.acc_logs.inq_addrsperadl_count_day := if(isFCRA, 0, le.acc_logs.inq_addrsperadl_count_day );
		self.acc_logs.inq_addrsperadl_count_week := if(isFCRA, 0, le.acc_logs.inq_addrsperadl_count_week );
		self.acc_logs.inq_lnamesperadl_count_day := if(isFCRA, 0, le.acc_logs.inq_lnamesperadl_count_day );
		self.acc_logs.inq_lnamesperadl_count_week  := if(isFCRA, 0, le.acc_logs.inq_lnamesperadl_count_week  );
		self.acc_logs.inq_fnamesperadl_count_day  := if(isFCRA, 0, le.acc_logs.inq_fnamesperadl_count_day  );
		self.acc_logs.inq_fnamesperadl_count_week  := if(isFCRA, 0, le.acc_logs.inq_fnamesperadl_count_week  );
		self.acc_logs.inq_phonesperadl_count_day  := if(isFCRA, 0, le.acc_logs.inq_phonesperadl_count_day  );
		self.acc_logs.inq_phonesperadl_count_week  := if(isFCRA, 0, le.acc_logs.inq_phonesperadl_count_week  );
		self.acc_logs.inq_dobsperadl_count_day  := if(isFCRA, 0, le.acc_logs.inq_dobsperadl_count_day  );
		self.acc_logs.inq_dobsperadl_count_week  := if(isFCRA, 0, le.acc_logs.inq_dobsperadl_count_week  );
		self.acc_logs.inquiryPerSSN := if(isFCRA, 0, le.acc_logs.inquiryPerSSN );
		self.acc_logs.inq_perssn_count_day := if(isFCRA, 0, le.acc_logs.inq_perssn_count_day );
		self.acc_logs.inq_perssn_count_week := if(isFCRA, 0, le.acc_logs.inq_perssn_count_week );
		self.acc_logs.inq_perssn_count01 := if(isFCRA, 0, le.acc_logs.inq_perssn_count01 );
		self.acc_logs.inq_perssn_count03 := if(isFCRA, 0, le.acc_logs.inq_perssn_count03 );
		self.acc_logs.inq_perssn_count06 := if(isFCRA, 0, le.acc_logs.inq_perssn_count06 );
		self.acc_logs.inquiryADLsPerSSN := if(isFCRA, 0, le.acc_logs.inquiryADLsPerSSN );
		self.acc_logs.inq_adlsperssn_count_day := if(isFCRA, 0, le.acc_logs.inq_adlsperssn_count_day );
		self.acc_logs.inq_adlsperssn_count_week := if(isFCRA, 0, le.acc_logs.inq_adlsperssn_count_week );
		self.acc_logs.inq_adlsperssn_count01 := if(isFCRA, 0, le.acc_logs.inq_adlsperssn_count01 );
		self.acc_logs.inq_adlsperssn_count03 := if(isFCRA, 0, le.acc_logs.inq_adlsperssn_count03 );
		self.acc_logs.inq_adlsperssn_count06 := if(isFCRA, 0, le.acc_logs.inq_adlsperssn_count06 );
		self.acc_logs.inquiryLNamesPerSSN := if(isFCRA, 0, le.acc_logs.inquiryLNamesPerSSN );
		self.acc_logs.inq_lnamesperssn_count_day := if(isFCRA, 0, le.acc_logs.inq_lnamesperssn_count_day );
		self.acc_logs.inq_lnamesperssn_count_week := if(isFCRA, 0, le.acc_logs.inq_lnamesperssn_count_week );
		self.acc_logs.inq_lnamesperssn_count01 := if(isFCRA, 0, le.acc_logs.inq_lnamesperssn_count01 );
		self.acc_logs.inq_lnamesperssn_count03 := if(isFCRA, 0, le.acc_logs.inq_lnamesperssn_count03 );
		self.acc_logs.inq_lnamesperssn_count06 := if(isFCRA, 0, le.acc_logs.inq_lnamesperssn_count06 );
		self.acc_logs.inquiryAddrsPerSSN := if(isFCRA, 0, le.acc_logs.inquiryAddrsPerSSN );
		self.acc_logs.inq_addrsperssn_count_day := if(isFCRA, 0, le.acc_logs.inq_addrsperssn_count_day );
		self.acc_logs.inq_addrsperssn_count_week := if(isFCRA, 0, le.acc_logs.inq_addrsperssn_count_week );
		self.acc_logs.inq_addrsperssn_count01 := if(isFCRA, 0, le.acc_logs.inq_addrsperssn_count01 );
		self.acc_logs.inq_addrsperssn_count03 := if(isFCRA, 0, le.acc_logs.inq_addrsperssn_count03 );
		self.acc_logs.inq_addrsperssn_count06 := if(isFCRA, 0, le.acc_logs.inq_addrsperssn_count06 );
		self.acc_logs.inquiryDOBsPerSSN := if(isFCRA, 0, le.acc_logs.inquiryDOBsPerSSN );
		self.acc_logs.inq_dobsperssn_count_day := if(isFCRA, 0, le.acc_logs.inq_dobsperssn_count_day );
		self.acc_logs.inq_dobsperssn_count_week := if(isFCRA, 0, le.acc_logs.inq_dobsperssn_count_week );
		self.acc_logs.inq_dobsperssn_count01 := if(isFCRA, 0, le.acc_logs.inq_dobsperssn_count01 );
		self.acc_logs.inq_dobsperssn_count03 := if(isFCRA, 0, le.acc_logs.inq_dobsperssn_count03 );
		self.acc_logs.inq_dobsperssn_count06 := if(isFCRA, 0, le.acc_logs.inq_dobsperssn_count06 );
		self.acc_logs.inquiryPerAddr := if(isFCRA, 0, le.acc_logs.inquiryPerAddr );
		self.acc_logs.inq_peraddr_count_day := if(isFCRA, 0, le.acc_logs.inq_peraddr_count_day );
		self.acc_logs.inq_peraddr_count_week := if(isFCRA, 0, le.acc_logs.inq_peraddr_count_week );
		self.acc_logs.inq_peraddr_count01 := if(isFCRA, 0, le.acc_logs.inq_peraddr_count01 );
		self.acc_logs.inq_peraddr_count03 := if(isFCRA, 0, le.acc_logs.inq_peraddr_count03 );
		self.acc_logs.inq_peraddr_count06 := if(isFCRA, 0, le.acc_logs.inq_peraddr_count06 );
		self.acc_logs.inquiryADLsPerAddr := if(isFCRA, 0, le.acc_logs.inquiryADLsPerAddr );
		self.acc_logs.inq_adlsperaddr_count_day := if(isFCRA, 0, le.acc_logs.inq_adlsperaddr_count_day );
		self.acc_logs.inq_adlsperaddr_count_week := if(isFCRA, 0, le.acc_logs.inq_adlsperaddr_count_week );
		self.acc_logs.inq_adlsperaddr_count01 := if(isFCRA, 0, le.acc_logs.inq_adlsperaddr_count01 );
		self.acc_logs.inq_adlsperaddr_count03 := if(isFCRA, 0, le.acc_logs.inq_adlsperaddr_count03 );
		self.acc_logs.inq_adlsperaddr_count06 := if(isFCRA, 0, le.acc_logs.inq_adlsperaddr_count06 );
		self.acc_logs.inquiryLNamesPerAddr := if(isFCRA, 0, le.acc_logs.inquiryLNamesPerAddr );
		self.acc_logs.inq_lnamesperaddr_count_day := if(isFCRA, 0, le.acc_logs.inq_lnamesperaddr_count_day );
		self.acc_logs.inq_lnamesperaddr_count_week := if(isFCRA, 0, le.acc_logs.inq_lnamesperaddr_count_week );
		self.acc_logs.inq_lnamesperaddr_count01 := if(isFCRA, 0, le.acc_logs.inq_lnamesperaddr_count01 );
		self.acc_logs.inq_lnamesperaddr_count03 := if(isFCRA, 0, le.acc_logs.inq_lnamesperaddr_count03 );
		self.acc_logs.inq_lnamesperaddr_count06 := if(isFCRA, 0, le.acc_logs.inq_lnamesperaddr_count06 );
		self.acc_logs.inquirySSNsPerAddr := if(isFCRA, 0, le.acc_logs.inquirySSNsPerAddr );
		self.acc_logs.inq_ssnsperaddr_count_day := if(isFCRA, 0, le.acc_logs.inq_ssnsperaddr_count_day );
		self.acc_logs.inq_ssnsperaddr_count_week := if(isFCRA, 0, le.acc_logs.inq_ssnsperaddr_count_week );
		self.acc_logs.inq_ssnsperaddr_count01 := if(isFCRA, 0, le.acc_logs.inq_ssnsperaddr_count01 );
		self.acc_logs.inq_ssnsperaddr_count03 := if(isFCRA, 0, le.acc_logs.inq_ssnsperaddr_count03 );
		self.acc_logs.inq_ssnsperaddr_count06 := if(isFCRA, 0, le.acc_logs.inq_ssnsperaddr_count06 );
		self.acc_logs.inquiryPerPhone := if(isFCRA, 0, le.acc_logs.inquiryPerPhone );
		self.acc_logs.inq_perphone_count_day := if(isFCRA, 0, le.acc_logs.inq_perphone_count_day );
		self.acc_logs.inq_perphone_count_week := if(isFCRA, 0, le.acc_logs.inq_perphone_count_week );
		self.acc_logs.inq_perphone_count01 := if(isFCRA, 0, le.acc_logs.inq_perphone_count01 );
		self.acc_logs.inq_perphone_count03 := if(isFCRA, 0, le.acc_logs.inq_perphone_count03 );
		self.acc_logs.inq_perphone_count06 := if(isFCRA, 0, le.acc_logs.inq_perphone_count06 );
		self.acc_logs.inquiryADLsPerPhone := if(isFCRA, 0, le.acc_logs.inquiryADLsPerPhone );	
		self.acc_logs.inq_adlsperphone_count_day := if(isFCRA, 0, le.acc_logs.inq_adlsperphone_count_day );	
		self.acc_logs.inq_adlsperphone_count_week := if(isFCRA, 0, le.acc_logs.inq_adlsperphone_count_week );	
		self.acc_logs.inq_adlsperphone_count01 := if(isFCRA, 0, le.acc_logs.inq_adlsperphone_count01 );	
		self.acc_logs.inq_adlsperphone_count03 := if(isFCRA, 0, le.acc_logs.inq_adlsperphone_count03 );	
		self.acc_logs.inq_adlsperphone_count06 := if(isFCRA, 0, le.acc_logs.inq_adlsperphone_count06 );	
		self.acc_logs.inq_emailsperadl_count_day := if(isFCRA, 0, le.acc_logs.inq_emailsperadl_count_day );	
		self.acc_logs.inq_emailsperadl_count_week := if(isFCRA, 0, le.acc_logs.inq_emailsperadl_count_week );	
		self.acc_logs.inquiryADLsPerEmail := if(isFCRA, 0, le.acc_logs.inquiryADLsPerEmail );	
		self.acc_logs.inquiries.countday:= if(isFCRA, 0, le.acc_logs.inquiries.countday);
		self.acc_logs.auto.countday:= if(isFCRA, 0, le.acc_logs.auto.countday);
		self.acc_logs.banking.countday:= if(isFCRA, 0, le.acc_logs.banking.countday);
		self.acc_logs.collection.countday:= if(isFCRA, 0, le.acc_logs.collection.countday);
		self.acc_logs.communications.countday:= if(isFCRA, 0, le.acc_logs.communications.countday);
		self.acc_logs.highriskcredit.countday:= if(isFCRA, 0, le.acc_logs.highriskcredit.countday);
		self.acc_logs.mortgage.countday:= if(isFCRA, 0, le.acc_logs.mortgage.countday);
		self.acc_logs.other.countday:= if(isFCRA, 0, le.acc_logs.other.countday);
		self.acc_logs.prepaidCards.countday:= if(isFCRA, 0, le.acc_logs.prepaidCards.countday);
		self.acc_logs.QuizProvider.countday:= if(isFCRA, 0, le.acc_logs.QuizProvider.countday);
		self.acc_logs.retail.countday:= if(isFCRA, 0, le.acc_logs.retail.countday);
		self.acc_logs.retailPayments.countday:= if(isFCRA, 0, le.acc_logs.retailPayments.countday);
		self.acc_logs.StudentLoans.countday:= if(isFCRA, 0, le.acc_logs.StudentLoans.countday);
		self.acc_logs.Utilities.countday:= if(isFCRA, 0, le.acc_logs.Utilities.countday);
		self.acc_logs.inquiries.countweek:= if(isFCRA, 0, le.acc_logs.inquiries.countweek);
		self.acc_logs.auto.countweek:= if(isFCRA, 0, le.acc_logs.auto.countweek);
		self.acc_logs.banking.countweek:= if(isFCRA, 0, le.acc_logs.banking.countweek);
		self.acc_logs.collection.countweek:= if(isFCRA, 0, le.acc_logs.collection.countweek);
		self.acc_logs.communications.countweek:= if(isFCRA, 0, le.acc_logs.communications.countweek);
		self.acc_logs.highriskcredit.countweek:= if(isFCRA, 0, le.acc_logs.highriskcredit.countweek);
		self.acc_logs.mortgage.countweek:= if(isFCRA, 0, le.acc_logs.mortgage.countweek);
		self.acc_logs.other.countweek:= if(isFCRA, 0, le.acc_logs.other.countweek);
		self.acc_logs.prepaidCards.countweek:= if(isFCRA, 0, le.acc_logs.prepaidCards.countweek);
		self.acc_logs.QuizProvider.countweek:= if(isFCRA, 0, le.acc_logs.QuizProvider.countweek);
		self.acc_logs.retail.countweek:= if(isFCRA, 0, le.acc_logs.retail.countweek);
		self.acc_logs.retailPayments.countweek:= if(isFCRA, 0, le.acc_logs.retailPayments.countweek);
		self.acc_logs.StudentLoans.countweek:= if(isFCRA, 0, le.acc_logs.StudentLoans.countweek);
		self.acc_logs.Utilities.countweek:= if(isFCRA, 0, le.acc_logs.Utilities.countweek);
		
		self.velocity_counters.lnames_per_adl := if(isFCRA, 0, le.velocity_counters.lnames_per_adl);
		self.velocity_counters.lnames_per_adl_created_6months := if(isFCRA, 0, le.velocity_counters.lnames_per_adl180);
		// self.iid.lastcount := if(isFCRA, 0, le.iid.lastcount);  // don't 0 this one out, this was incorrectly included in 5.0 requirements.  since it's just source counts, it can be included in FCRA
		self.iid.altlastPop := if(isFCRA, false, le.iid.altlastPop);
		self.iid.altlast2Pop := if(isFCRA, false, le.iid.altlast2Pop);
		self.name_verification.lname_change_date := if(isFCRA, 0, le.name_verification.lname_change_date);
		self.name_verification.lname_prev_change_date := if(isFCRA, 0, le.name_verification.lname_prev_change_date);
		self.acc_logs.inquirylnamesperadl := if(isFCRA, 0, le.acc_logs.inquirylnamesperadl);
		self.student.INCOME_LEVEL_CODE := if(isFCRA, '', le.student.income_level_code);
		//populate new FDN data for BS 5.1 (not really a BS version yet but in the interim)
		self.Test_Fraud         := le.Test_Fraud;  
		self.Contributory_Fraud := le.Contributory_Fraud; 
			
		// new for 5.2	
		purp := TRIM(STRINGLIB.STRINGTOUPPERCASE(Intended_Purpose));
		self.IntendedPurpose := CASE(purp,
																	'APPLICATION' => 'A',
																	'CHILD SUPPORT' => 'B',
																	'COLLECTIONS' => 'C',
																	'DEMAND DEPOSIT' => 'D',
																	'DISCLOSURE' => 'E',
																	'EMPLOYEE OR VOLUNTEER SCREENING' => 'F',
																	'GOVERNMENT' => 'G',
																	'HEALTHCARE CREDIT TRANSACTION' => 'H',
																	'HEALTHCARE LEGITIMATE BUSINESS NEED' => 'I',
																	'INSURANCE APPLICATION' => 'J',
																	'INSURANCE PORTFOLIO REVIEW' => 'K',
																	'PORTFOLIO REVIEW' => 'L',
																	'PRESCREENING' => 'M',
																	'RENTAL CAR' => 'N',
																	'RENTAL CAR LOSS DAMAGE WAIVER' => 'O',
																	'TENANT SCREENING' => 'P',
																	'WRITTEN CONSENT' => 'Q',
																	'WRITTEN CONSENT DIRECT TO CONSUMER' => 'R',
																	'WRITTEN CONSENT PREQUALIFICATION' => 'S',
																	'');
																	
																	
	self.DIDdeceased := le.iid.diddeceased;
	self.DIDdeceasedDate := le.iid.DIDdeceasedDate;
	self.bjl.liens := le.liens;
	// self.bjl.lnj_attributes := le.lnj_attributes;  // JuLi attributes, new for 5.2
		
	// best_flags in internal_shell was broken into different sections in edina layout, map those all manually
	self.best_pii_flags := le.best_flags;
	self.velocity_counters.adls_per_bestssn := le.best_flags.adls_per_bestssn;  
	self.velocity_counters.addrs_per_bestssn := le.best_flags.addrs_per_bestssn; 
	self.velocity_counters.adls_per_curraddr_current := le.best_flags.adls_per_curraddr_curr; 
	self.velocity_counters.ssns_per_curraddr_current := le.best_flags.ssns_per_curraddr_curr;  
	self.velocity_counters.phones_per_curraddr_current := le.best_flags.phones_per_curraddr_curr; 
	// self.velocity_counters.adls_per_bestphone_current := le.best_flags.adls_per_bestphone_curr; 
	self.velocity_counters.adls_per_bestssn_created_6months := le.best_flags.adls_per_bestssn_c6;	
	self.velocity_counters.addrs_per_bestssn_created_6months := le.best_flags.addrs_per_bestssn_c6; 
	self.velocity_counters.adls_per_curraddr_created_6months := le.best_flags.adls_per_curraddr_c6;
	self.velocity_counters.ssns_per_curraddr_created_6months := le.best_flags.ssns_per_curraddr_c6; 
	self.velocity_counters.phones_per_curraddr_created_6months := le.best_flags.phones_per_curraddr_c6;  
	// self.velocity_counters.adls_per_bestphone_created_6months := le.best_flags.adls_per_bestphone_c6;
	self.acc_logs := le.best_flags; // transfer the rest of the best_flags into the acc_logs section, everything in risk_indicators.layouts.layout_best_pii_inquiries

	//New for 5.3
	self.corr_risk_summary.corrssnname_sources := le.header_summary.corrssnname_sources;
	self.corr_risk_summary.corrssnname_firstseen := le.header_summary.corrssnname_firstseen;
	self.corr_risk_summary.corrssnname_lastseen := le.header_summary.corrssnname_lastseen;
	// self.corr_risk_summary.corrssnname_source_cnt := le.header_summary.corrssnname_source_cnt;
	self.corr_risk_summary.corrssnaddr_sources := le.header_summary.corrssnaddr_sources;
	self.corr_risk_summary.corrssnaddr_firstseen := le.header_summary.corrssnaddr_firstseen;
	self.corr_risk_summary.corrssnaddr_lastseen := le.header_summary.corrssnaddr_lastseen;
	// self.corr_risk_summary.corrssnaddr_source_cnt := le.header_summary.corrssnaddr_source_cnt;
	self.corr_risk_summary.corraddrname_sources := le.header_summary.corraddrname_sources;
	self.corr_risk_summary.corraddrname_firstseen := le.header_summary.corraddrname_firstseen;
	self.corr_risk_summary.corraddrname_lastseen := le.header_summary.corraddrname_lastseen;
	// self.corr_risk_summary.corraddrname_source_cnt := le.header_summary.corraddrname_source_cnt;
	self.corr_risk_summary.corraddrphone_sources := le.header_summary.corraddrphone_sources;
	self.corr_risk_summary.corraddrphone_firstseen := le.header_summary.corraddrphone_firstseen;
	self.corr_risk_summary.corraddrphone_lastseen := le.header_summary.corraddrphone_lastseen;
	// self.corr_risk_summary.corraddrphone_source_cnt := le.header_summary.corraddrphone_source_cnt;
	self.corr_risk_summary.corrphonelastname_sources := le.header_summary.corrphonelastname_sources;
	self.corr_risk_summary.corrphonelastname_firstseen := le.header_summary.corrphonelastname_firstseen;
	self.corr_risk_summary.corrphonelastname_lastseen := le.header_summary.corrphonelastname_lastseen;
	// self.corr_risk_summary.corrphonelastname_source_cnt := le.header_summary.corrphonelastname_source_cnt;
	self.corr_risk_summary.corrnamedob_sources := le.header_summary.corrnamedob_sources;
	self.corr_risk_summary.corrnamedob_firstseen := le.header_summary.corrnamedob_firstseen;
	self.corr_risk_summary.corrnamedob_lastseen := le.header_summary.corrnamedob_lastseen;
	// self.corr_risk_summary.corrnamedob_source_cnt := le.header_summary.corrnamedob_source_cnt;
	self.corr_risk_summary.corraddrdob_sources := le.header_summary.corraddrdob_sources;
	self.corr_risk_summary.corraddrdob_firstseen := le.header_summary.corraddrdob_firstseen;
	self.corr_risk_summary.corraddrdob_lastseen := le.header_summary.corraddrdob_lastseen;
	// self.corr_risk_summary.corraddrdob_source_cnt := le.header_summary.corraddrdob_source_cnt;
	self.corr_risk_summary.corrssndob_sources := le.header_summary.corrssndob_sources;
	self.corr_risk_summary.corrssndob_firstseen := le.header_summary.corrssndob_firstseen;
	self.corr_risk_summary.corrssndob_lastseen := le.header_summary.corrssndob_lastseen;
	// self.corr_risk_summary.corrssndob_source_cnt := le.header_summary.corrssndob_source_cnt;
	self.corr_risk_summary.corrssnphone_sources := le.header_summary.corrssnphone_sources;
	self.corr_risk_summary.corrssnphone_firstseen := le.header_summary.corrssnphone_firstseen;
	self.corr_risk_summary.corrssnphone_lastseen := le.header_summary.corrssnphone_lastseen;
	// self.corr_risk_summary.corrssnphone_source_cnt := le.header_summary.corrssnphone_source_cnt;
	self.corr_risk_summary.corrdobphone_sources := le.header_summary.corrdobphone_sources;
	self.corr_risk_summary.corrdobphone_firstseen := le.header_summary.corrdobphone_firstseen;
	self.corr_risk_summary.corrdobphone_lastseen := le.header_summary.corrdobphone_lastseen;
	// self.corr_risk_summary.corrdobphone_source_cnt := le.header_summary.corrdobphone_source_cnt;
	
	self.credit_derived_perf.acc_logs_collection_count12_6mos				:= le.acc_logs.collection.count12_6mos;
	self.credit_derived_perf.acc_logs_collection_count12_12mos			:= le.acc_logs.collection.count12_12mos; 
	self.credit_derived_perf.acc_logs_collection_count12_24mos			:= le.acc_logs.collection.count12_24mos; 
	self.credit_derived_perf.acc_logs_highriskcredit_count12_6mos		:= le.acc_logs.highriskcredit.count12_6mos;
	self.credit_derived_perf.acc_logs_highriskcredit_count12_12mos	:= le.acc_logs.highriskcredit.count12_12mos; 
	self.credit_derived_perf.acc_logs_highriskcredit_count12_24mos	:= le.acc_logs.highriskcredit.count12_24mos; 
	self.credit_derived_perf.impulse_count12_6mos 									:= le.impulse.count12_6mos;
	self.credit_derived_perf.impulse_count12_12mos									:= le.impulse.count12_12mos; 
	self.credit_derived_perf.impulse_count12_24mos									:= le.impulse.count12_24mos; 
	self.credit_derived_perf.bjl_criminal_count12_6mos							:= le.bjl.criminal_count12_6mos;
	self.credit_derived_perf.bjl_criminal_count12_12mos							:= le.bjl.criminal_count12_12mos; 
	self.credit_derived_perf.bjl_criminal_count12_24mos							:= le.bjl.criminal_count12_24mos; 
	self.credit_derived_perf.bjl_liens_unreleased_count12_6mos			:= le.bjl.liens_unreleased_count12_6mos;
	self.credit_derived_perf.bjl_liens_unreleased_count12_12mos			:= le.bjl.liens_unreleased_count12_12mos; 
	self.credit_derived_perf.bjl_liens_unreleased_count12_24mos			:= le.bjl.liens_unreleased_count12_24mos; 
	self.credit_derived_perf.bjl_bk_count12_6mos										:= le.bjl.bk_count12_6mos;
	self.credit_derived_perf.bjl_bk_count12_12mos										:= le.bjl.bk_count12_12mos; 
	self.credit_derived_perf.bjl_bk_count12_24mos										:= le.bjl.bk_count12_24mos; 
	self.credit_derived_perf.bjl_eviction_count12_6mos							:= le.bjl.eviction_count12_6mos;
	self.credit_derived_perf.bjl_eviction_count12_12mos							:= le.bjl.eviction_count12_12mos; 
	self.credit_derived_perf.bjl_eviction_count12_24mos							:= le.bjl.eviction_count12_24mos; 
	self.credit_derived_perf.archive_date_6mo												:= le.archive_date_6mo;	
	self.credit_derived_perf.archive_date_12mo											:= le.archive_date_12mo;	
	self.credit_derived_perf.archive_date_24mo											:= le.archive_date_24mo;

	self.swappedNames := le.iid.swappedNames;

	self.BJL.liens_unrel_total_amount84				:= le.liens.liens_unrel_total_amount84;
	self.BJL.liens_unrel_total_amount					:= le.liens.liens_unrel_total_amount;
	self.BJL.liens_rel_total_amount84					:= le.liens.liens_rel_total_amount84;
	self.BJL.liens_rel_total_amount						:= le.liens.liens_rel_total_amount;
	self.attributes.attr_eviction_count84			:= le.BJL.eviction_count84; 

	self.bus_addr_only_curr										:= le.Address_Verification.bus_addr_only_curr;
	self.bus_addr_only												:= le.Address_Verification.bus_addr_only;
	
	self.Address_Verification.bus_property_owned_total						:= le.Address_Verification.bus_owned.property_total;
	self.Address_Verification.bus_property_owned_assess_total			:= le.Address_Verification.bus_owned.property_owned_assessed_total;
	self.Address_Verification.bus_property_owned_assess_count			:= le.Address_Verification.bus_owned.property_owned_assessed_count;
	self.Address_Verification.bus_property_sold_total							:= le.Address_Verification.bus_sold.property_total;
	self.Address_Verification.bus_property_sold_assess_total			:= le.Address_Verification.bus_sold.property_owned_assessed_total;
	self.Address_Verification.bus_property_sold_assess_count			:= le.Address_Verification.bus_sold.property_owned_assessed_count;

  self.bus_SOS_filings_peradl                   := le.BIP_Header.bus_SOS_filings_peradl;
  self.bus_active_SOS_filings_peradl            := le.BIP_Header.bus_active_SOS_filings_peradl;
  self.bus_sos_filings_not_instate              := le.BIP_Header54.bus_sos_filings_not_instate;
  self.bus_ucc_count                            := le.BIP_Header54.bus_ucc_count;
  self.bus_ucc_active_count                     := le.BIP_Header54.bus_ucc_active_count;
  self.acc_logs.bus_inq_count12                 := le.BIP_Header54.bus_inq_count12;
  self.acc_logs.bus_inq_credit_count12          := le.BIP_Header54.bus_inq_credit_count12;
  self.acc_logs.bus_inq_highriskcredit_count12  := le.BIP_Header54.bus_inq_highriskcredit_count12;
  self.acc_logs.bus_inq_other_count12           := le.BIP_Header54.bus_inq_other_count12;
	self := le;

	end;

	edina_v54 := project( bs, convertToEdina_v54(left) );
	
	
	clam := project(bs, transform(risk_indicators.Layout_Boca_Shell, self := left));
	
	rv5_attributes := riskview.get_attributes_v5(group(clam,seq), false);
		
	with_riskview_attributes := join(edina_v54, rv5_attributes, left.seq=right.seq,
		transform(edina_plus_bob_v54, 
							self.AssetValueIndex := right.assetIndex;  
							self.AssetIndexPrimaryFactor := right.AssetIndexPrimaryFactor;  
							self.StabilityIndex := right.SubjectStabilityIndex;  
							self.StabilityPrimaryFactor := right.SubjectStabilityPrimaryFactor;  
							self.AbilityIndex := right.SubjectAbilityIndex;  
							self.AbilityIndexPrimaryFactor := right.SubjectAbilityPrimaryFactor;  
							self.WillingnessIndex := right.SubjectWillingnessIndex;  
							self.WillingnessIndexPrimaryFactor := right.SubjectWillingnessPrimaryFactor;  
							self := left));
	
	edina54_final := if(isFCRA, with_riskview_attributes, edina_v54);
	
	// output(bs, named('bs'));
	// output(edina_v51, named('edina_v51'));
	// output(rv5_attributes, named('rv5_attributes'));
	// output(with_riskview_attributes, named('with_riskview_attributes'));
		
	return edina54_final;
END;
