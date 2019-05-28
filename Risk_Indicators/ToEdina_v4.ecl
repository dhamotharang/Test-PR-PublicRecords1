includeADLFields := FALSE; // If you set this to TRUE, make sure you set it to TRUE in Risk_Indicators.Layout_Boca_Shell_Edina_v4!

import risk_indicators;

layout_final := record
	STRING AccountNumber;
	risk_indicators.Layout_Boca_Shell;
	string errorcode;
end;

export ToEdina_v4( dataset(layout_final) bs, boolean isFCRA=false, string dataRestrictionMask = Risk_Indicators.iid_constants.default_DataRestriction ) := FUNCTION
	// convert from layout_boca_shell to the flat layout minneapolis expects
	risk_indicators.Layout_Boca_Shell_Edina_v4 convertToEdina_v4(bs le) := transform
		self.address_verification.input_address_information.lres := le.lres;
		self.address_verification.address_history_1.lres := le.lres2;
		self.address_verification.address_history_2.lres := le.lres3;
		self.address_verification.input_address_information.addrPop := le.addrPop;
		self.address_verification.address_history_1.addrPop := le.addrPop2;
		self.address_verification.address_history_2.addrPop := le.addrPop3;
		self.address_verification.input_address_information.avm_land_use_code := le.avm.input_address_information.avm_land_use_code;
		self.address_verification.input_address_information.avm_recording_date := le.avm.input_address_information.avm_recording_date;
		self.address_verification.input_address_information.avm_assessed_value_year := le.avm.input_address_information.avm_assessed_value_year;
		self.address_verification.input_address_information.avm_sales_price := le.avm.input_address_information.avm_sales_price;  
		self.address_verification.input_address_information.avm_assessed_total_value := le.avm.input_address_information.avm_assessed_total_value;
		self.address_verification.input_address_information.avm_market_total_value := le.avm.input_address_information.avm_market_total_value;
		self.address_verification.input_address_information.avm_tax_assessment_valuation := le.avm.input_address_information.avm_tax_assessment_valuation;
		self.address_verification.input_address_information.avm_price_index_valuation := le.avm.input_address_information.avm_price_index_valuation;
		self.address_verification.input_address_information.avm_hedonic_valuation := le.avm.input_address_information.avm_hedonic_valuation;
		self.address_verification.input_address_information.avm_automated_valuation := le.avm.input_address_information.avm_automated_valuation;
		self.address_verification.input_address_information.avm_confidence_score := le.avm.input_address_information.avm_confidence_score;
		self.address_verification.input_address_information.avm_median_fips_level := le.avm.input_address_information.avm_median_fips_level;
		self.address_verification.input_address_information.avm_median_geo11_level := le.avm.input_address_information.avm_median_geo11_level;
		self.address_verification.input_address_information.avm_median_geo12_level := le.avm.input_address_information.avm_median_geo12_level;
		
		self.address_verification.address_history_1.avm_land_use_code := le.avm.address_history_1.avm_land_use_code;
		self.address_verification.address_history_1.avm_recording_date := le.avm.address_history_1.avm_recording_date;
		self.address_verification.address_history_1.avm_assessed_value_year := le.avm.address_history_1.avm_assessed_value_year;
		self.address_verification.address_history_1.avm_sales_price := le.avm.address_history_1.avm_sales_price;  
		self.address_verification.address_history_1.avm_assessed_total_value := le.avm.address_history_1.avm_assessed_total_value;
		self.address_verification.address_history_1.avm_market_total_value := le.avm.address_history_1.avm_market_total_value;
		self.address_verification.address_history_1.avm_tax_assessment_valuation := le.avm.address_history_1.avm_tax_assessment_valuation;
		self.address_verification.address_history_1.avm_price_index_valuation := le.avm.address_history_1.avm_price_index_valuation;
		self.address_verification.address_history_1.avm_hedonic_valuation := le.avm.address_history_1.avm_hedonic_valuation;
		self.address_verification.address_history_1.avm_automated_valuation := le.avm.address_history_1.avm_automated_valuation;
		self.address_verification.address_history_1.avm_confidence_score := le.avm.address_history_1.avm_confidence_score;
		self.address_verification.address_history_1.avm_median_fips_level := le.avm.address_history_1.avm_median_fips_level;
		self.address_verification.address_history_1.avm_median_geo11_level := le.avm.address_history_1.avm_median_geo11_level;
		self.address_verification.address_history_1.avm_median_geo12_level := le.avm.address_history_1.avm_median_geo12_level;
		
		SELF.Velocity_Counters.adlPerSSN_count := le.SSN_Verification.adlPerSSN_count;
		
		self.iid.socllowissue := (unsigned)le.iid.socllowissue;
		self.iid.soclhighissue := (unsigned)le.iid.soclhighissue;
		self.iid.areacodesplitdate := (unsigned)le.iid.areacodesplitdate;
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
		
		self.Address_Verification.Input_Address_Information.building_area := (string)le.address_verification.input_address_information.building_area ;
		self.Address_Verification.Input_Address_Information.no_of_buildings := (string)le.address_verification.input_address_information.no_of_buildings ;
		self.Address_Verification.Input_Address_Information.no_of_stories := (string)le.address_verification.input_address_information.no_of_stories ;
		self.Address_Verification.Input_Address_Information.no_of_rooms := (string)le.address_verification.input_address_information.no_of_rooms ;
		self.Address_Verification.Input_Address_Information.no_of_bedrooms := (string)le.address_verification.input_address_information.no_of_bedrooms ;
		self.Address_Verification.Input_Address_Information.no_of_baths := (string)le.address_verification.input_address_information.no_of_baths;
		self.Address_Verification.Input_Address_Information.no_of_partial_baths := (string)le.address_verification.input_address_information.no_of_partial_baths ;
		self.Address_Verification.Input_Address_Information.parking_no_of_cars := (string)le.address_verification.input_address_information.parking_no_of_cars;
		self.Address_Verification.Input_Address_Information.avm_automated_valuation2 := le.avm.input_address_information.avm_automated_valuation2;
		self.Address_Verification.Input_Address_Information.avm_automated_valuation3 := le.avm.input_address_information.avm_automated_valuation3;
		self.Address_Verification.Input_Address_Information.avm_automated_valuation4 := le.avm.input_address_information.avm_automated_valuation4;
		self.Address_Verification.Input_Address_Information.avm_automated_valuation5 := le.avm.input_address_information.avm_automated_valuation5;
		self.Address_Verification.Input_Address_Information.avm_automated_valuation6 := le.avm.input_address_information.avm_automated_valuation6;
		
		self.address_verification.address_history_1.building_area := (string)le.address_verification.address_history_1.building_area ;
		self.address_verification.address_history_1.no_of_buildings := (string)le.address_verification.address_history_1.no_of_buildings ;
		self.address_verification.address_history_1.no_of_stories := (string)le.address_verification.address_history_1.no_of_stories ;
		self.address_verification.address_history_1.no_of_rooms := (string)le.address_verification.address_history_1.no_of_rooms ;
		self.address_verification.address_history_1.no_of_bedrooms := (string)le.address_verification.address_history_1.no_of_bedrooms ;
		self.address_verification.address_history_1.no_of_baths := (string)le.address_verification.address_history_1.no_of_baths;
		self.address_verification.address_history_1.no_of_partial_baths := (string)le.address_verification.address_history_1.no_of_partial_baths ;
		self.address_verification.address_history_1.parking_no_of_cars := (string)le.address_verification.address_history_1.parking_no_of_cars;
		self.Address_Verification.Address_History_1.avm_automated_valuation2 := le.avm.address_history_1.avm_automated_valuation2;
		self.Address_Verification.Address_History_1.avm_automated_valuation3 := le.avm.address_history_1.avm_automated_valuation3;
		self.Address_Verification.Address_History_1.avm_automated_valuation4 := le.avm.address_history_1.avm_automated_valuation4;
		self.Address_Verification.Address_History_1.avm_automated_valuation5 := le.avm.address_history_1.avm_automated_valuation5;
		self.Address_Verification.Address_History_1.avm_automated_valuation6 := le.avm.address_history_1.avm_automated_valuation6;
		
		self.bjl.liens := le.liens;
		
		// attribute fields added
		self.attributes.addrs_last30 := le.other_address_info.addrs_last30;
		self.attributes.addrs_last90 := le.other_address_info.addrs_last90;
		self.attributes.addrs_last12 := le.other_address_info.addrs_last12;
		self.attributes.addrs_last24 := le.other_address_info.addrs_last24;
		self.attributes.addrs_last36 := le.other_address_info.addrs_last36;
		self.attributes.date_first_purchase := le.other_address_info.date_first_purchase;	
		self.attributes.date_most_recent_purchase := le.other_address_info.date_most_recent_purchase;	
		self.attributes.date_most_recent_sale := le.other_address_info.date_most_recent_sale;	
		self.attributes.num_purchase30 := le.other_address_info.num_purchase30;
		self.attributes.num_purchase90 := le.other_address_info.num_purchase90;
		self.attributes.num_purchase180 := le.other_address_info.num_purchase180;
		self.attributes.num_purchase12 := le.other_address_info.num_purchase12;
		self.attributes.num_purchase24 := le.other_address_info.num_purchase24;
		self.attributes.num_purchase36 := le.other_address_info.num_purchase36;
		self.attributes.num_purchase60 := le.other_address_info.num_purchase60;
		self.attributes.num_sold30 := le.other_address_info.num_sold30;
		self.attributes.num_sold90 := le.other_address_info.num_sold90;
		self.attributes.num_sold180 := le.other_address_info.num_sold180;
		self.attributes.num_sold12 := le.other_address_info.num_sold12;
		self.attributes.num_sold24 := le.other_address_info.num_sold24;
		self.attributes.num_sold36 := le.other_address_info.num_sold36;
		self.attributes.num_sold60 := le.other_address_info.num_sold60;
		self.attributes.num_watercraft30 := le.watercraft.watercraft_count30;
		self.attributes.num_watercraft90 := le.watercraft.watercraft_count90;
		self.attributes.num_watercraft180 := le.watercraft.watercraft_count180;
		self.attributes.num_watercraft12 := le.watercraft.watercraft_count12;
		self.attributes.num_watercraft24 := le.watercraft.watercraft_count24;
		self.attributes.num_watercraft36 := le.watercraft.watercraft_count36;
		self.attributes.num_watercraft60 := le.watercraft.watercraft_count60;
		self.attributes.num_aircraft := le.aircraft.aircraft_count;
		self.attributes.num_aircraft30 := le.aircraft.aircraft_count30;
		self.attributes.num_aircraft90 := le.aircraft.aircraft_count90;
		self.attributes.num_aircraft180 := le.aircraft.aircraft_count180;
		self.attributes.num_aircraft12 := le.aircraft.aircraft_count12;
		self.attributes.num_aircraft24 := le.aircraft.aircraft_count24;
		self.attributes.num_aircraft36 := le.aircraft.aircraft_count36;
		self.attributes.num_aircraft60 := le.aircraft.aircraft_count60;
		self.attributes.total_number_derogs := le.total_number_derogs;
		self.attributes.date_last_derog := le.date_last_derog;
		self.attributes.felonies30 := le.bjl.criminal_count30;
		self.attributes.felonies90 := le.bjl.criminal_count90;
		self.attributes.felonies180 := le.bjl.criminal_count180;
		self.attributes.felonies12 := le.bjl.criminal_count12;
		self.attributes.felonies24 := le.bjl.criminal_count24;
		self.attributes.felonies36 := le.bjl.criminal_count36;
		self.attributes.felonies60 := le.bjl.criminal_count60;
		self.attributes.arrests := le.bjl.arrests_count;
		self.attributes.date_last_arrest := le.bjl.date_last_arrest;	
		self.attributes.arrests30 := le.bjl.arrests_count30;
		self.attributes.arrests90 := le.bjl.arrests_count90;
		self.attributes.arrests180 := le.bjl.arrests_count180;
		self.attributes.arrests12 := le.bjl.arrests_count12;
		self.attributes.arrests24 := le.bjl.arrests_count24;
		self.attributes.arrests36 := le.bjl.arrests_count36;
		self.attributes.arrests60 := le.bjl.arrests_count60;
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
		self.attributes.num_proflic30 := le.professional_license.proflic_count30;
		self.attributes.num_proflic90 := le.professional_license.proflic_count90;
		self.attributes.num_proflic180 := le.professional_license.proflic_count180;
		self.attributes.num_proflic12 := le.professional_license.proflic_count12;
		self.attributes.num_proflic24 := le.professional_license.proflic_count24;
		self.attributes.num_proflic36 := le.professional_license.proflic_count36;
		self.attributes.num_proflic60 := le.professional_license.proflic_count60;
		self.attributes.num_proflic_exp30 := le.professional_license.expire_count30;
		self.attributes.num_proflic_exp90 := le.professional_license.expire_count90;
		self.attributes.num_proflic_exp180 := le.professional_license.expire_count180;
		self.attributes.num_proflic_exp12 := le.professional_license.expire_count12;
		self.attributes.num_proflic_exp24 := le.professional_license.expire_count24;
		self.attributes.num_proflic_exp36 := le.professional_license.expire_count36;
		self.attributes.num_proflic_exp60 := le.professional_license.expire_count60;
		
		self.infutor := le.infutor_phone;	// puts the infutor phone results into the infutor spot to match previous output
		self.iid.correctlast := if(le.iid.correctlast<>'', '1','0');	// brent doesn't want to see lastnames, so populate with a 1 or 0
		self.estimated_income := le.estimated_income;
		
		// new mappings for shell 4.0
	self.student.college_major := le.student.college_major;  // won't need this when college major put into the student section correctly
	self.student.file_type := le.student.file_type2;

	self.velocity_counters.lnames_per_adl_created_6months := le.velocity_counters.lnames_per_adl180;
	self.address_verification.address_history_2.avm_automated_valuation := le.avm.address_history_2.avm_automated_valuation;
	
	self.address_verification.input_address_information.market_total_value := le.address_verification.input_address_information.assessed_amount;
	self.address_verification.address_history_1.market_total_value := le.address_verification.address_history_1.assessed_amount;
	self.address_verification.address_history_2.market_total_value := le.address_verification.address_history_2.assessed_amount;
	
	self.Other_Address_Info.unique_addr_cnt := le.address_history_summary.unique_addr_cnt;
	self.Other_Address_Info.avg_mo_per_addr := le.address_history_summary.avg_mo_per_addr;
	self.Other_Address_Info.addr_count2 := le.address_history_summary.addr_count2;
	self.Other_Address_Info.addr_count3 := le.address_history_summary.addr_count3;
	self.Other_Address_Info.addr_count6 := le.address_history_summary.addr_count6;
	self.Other_Address_Info.addr_count10 := le.address_history_summary.addr_count10;
	self.Other_Address_Info.lres_2mo_count := le.address_history_summary.lres_2mo_count;
	self.Other_Address_Info.lres_6mo_count := le.address_history_summary.lres_6mo_count ;
	self.Other_Address_Info.lres_12mo_count := le.address_history_summary.lres_12mo_count;
	self.Other_Address_Info.hist_addr_match := le.address_history_summary.hist_addr_match;	
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
	
	#if(includeADLFields)
	SELF.in_addrpop := le.ADL_Shell_Flags.in_addrpop;  // was address populated on input from consumer
	SELF.in_hphnpop := le.ADL_Shell_Flags.in_hphnpop;	// was hphone populated on input from consumer
	SELF.in_ssnpop := le.ADL_Shell_Flags.in_ssnpop;		// was ssn populated on input from consumer
	SELF.in_dobpop := le.ADL_Shell_Flags.in_dobpop;		// was dob populated on input from consumer
	SELF.adl_addr := le.ADL_Shell_Flags.adl_addr;  	// what do we know from the ADL search
	SELF.adl_hphn := le.ADL_Shell_Flags.adl_hphn;		// what do we know from the ADL search
	SELF.adl_ssn := le.ADL_Shell_Flags.adl_ssn;			// what do we know from the ADL search
	SELF.adl_dob := le.ADL_Shell_Flags.adl_dob;			// what do we know from the ADL search
	SELF.in_addrpop_found := le.ADL_Shell_Flags.in_addrpop_found;	// was ssn populated on input from consumer and matched one of our database addresses
	SELF.in_hphnpop_found := le.ADL_Shell_Flags.in_hphnpop_found; // was hphone populated on input from consumer and matched one of our database phones
	#end
	
		// need to map these fields manually as they longer exist in the bocashell per bug 109182 (they were removed to accommodate the new named fields, which are accurate)
		SELF.fd_scores.fraudpointv4 := '';
		SELF.fd_scores.reason1fpv4 := '';
		SELF.fd_scores.reason2fpv4 := '';
		SELF.fd_scores.reason3fpv4 := '';
		SELF.fd_scores.reason4fpv4 := '';
		SELF.fd_scores.reason5fpv4 := '';
		SELF.fd_scores.reason6fpv4 := '';
	
		self := le;
	end;




	edina_v4 := project( bs, convertToEdina_v4(left) );
	
	return edina_v4;
END;
