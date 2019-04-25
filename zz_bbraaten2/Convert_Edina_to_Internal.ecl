
import risk_indicators, Scoring_Project_Macros;

layout_edina := record
Risk_Indicators.Layout_Boca_Shell_Edina_v50;
end;


layout_internal := record
Scoring_Project_Macros.Global_Output_Layouts.BocaShell_Global_Layout;
end;




EXPORT Convert_Edina_to_Internal( dataset(layout_edina) bs ) := FUNCTION

	layout_internal Convert_Edina_to_Internal(bs le) := transform



self.accountnumber := le.accountnumber;
self.seq:= (integer)le.seq;
self.did:= (integer)le.did;
self.ssn_verification.validation.deceasedDate := le.iid.deceasedDate ;
 self.address_verification.inputaddr_dirty := le.address_verification.input_address_information.dirty_address ;
 self.address_verification.inputAddr_not_verified := le.address_verification.input_address_information.not_verified ;
 self.address_verification.inputaddr_owned_not_occupied := le.address_verification.input_address_information.owned_not_occupied ;
 self.address_verification.inputaddr_non_relative_did_count := le.address_verification.input_address_information.non_relative_ADLs ;
 self.address_verification.inputaddr_occupancy_index := le.address_verification.input_address_information.occupancy_index ;
 self.address_verification.currAddr_occupancy_index := le.address_verification.Address_History_1.occupancy_index ;

 self.addrsMilitaryEver := le.other_address_info.addrsMilitaryEver ;
 self.economic_trajectory := le.other_address_info.economic_trajectory ;
 self.economic_trajectory_index := le.other_address_info.economic_trajectory_index ;
 self.address_verification.unverified_addr_count := le.other_address_info.unverified_addr_count ;

 self.address_sources_summary.input_addr_sources := le.address_verification.input_address_information.addr_sources ;
 self.address_sources_summary.input_addr_sources_first_seen_date := le.address_verification.input_address_information.addr_sources_first_seen_date ;
 self.address_sources_summary.input_addr_sources_recordcount := le.address_verification.input_address_information.addr_sources_recordcount ;

 self.address_sources_summary.current_addr_sources := le.address_verification.Address_History_1.addr_sources ;
 self.address_sources_summary.current_addr_sources_first_seen_date := le.address_verification.Address_History_1.addr_sources_first_seen_date ;
 self.address_sources_summary.current_addr_sources_recordcount := le.address_verification.Address_History_1.addr_sources_recordcount ;

 self.address_sources_summary.previous_addr_sources := le.address_verification.Address_History_2.addr_sources ;
 self.address_sources_summary.previous_addr_sources_first_seen_date := le.address_verification.Address_History_2.addr_sources_first_seen_date ;
 self.address_sources_summary.previous_addr_sources_recordcount := le.address_verification.Address_History_2.addr_sources_recordcount ;


self.advo_addr_hist2.Throw_Back_Indicator	:=  le.Address_Verification.Address_History_2.Throw_Back_Indicator ;
 self.advo_addr_hist2.Seasonal_Delivery_Indicator := le.Address_Verification.Address_History_2.Seasonal_Delivery_Indicator ;
self.advo_addr_hist2.DND_Indicator :=  le.Address_Verification.Address_History_2.DND_Indicator ;
 self.advo_addr_hist2.College_Indicator := le.Address_Verification.Address_History_2.College_Indicator ;


 self.advo_addr_hist2.Mixed_Address_Usage := le.Address_Verification.Address_History_2.Mixed_Address_Usage ;

 self.avm.address_history_2.avm_land_use_code := le.address_verification.address_history_2.avm_land_use_code ;
 self.avm.address_history_2.avm_recording_date := le.address_verification.address_history_2.avm_recording_date ;
 self.avm.address_history_2.avm_assessed_value_year := le.address_verification.address_history_2.avm_assessed_value_year ;
 self.avm.address_history_2.avm_sales_price   :=  le.address_verification.address_history_2.avm_sales_price ;
 self.avm.address_history_2.avm_assessed_total_value := le.address_verification.address_history_2.avm_assessed_total_value ;
 self.avm.address_history_2.avm_market_total_value := le.address_verification.address_history_2.avm_market_total_value ;
 self.avm.address_history_2.avm_tax_assessment_valuation := le.address_verification.address_history_2.avm_tax_assessment_valuation ;
 self.avm.address_history_2.avm_price_index_valuation := le.address_verification.address_history_2.avm_price_index_valuation ;
 self.avm.address_history_2.avm_hedonic_valuation := le.address_verification.address_history_2.avm_hedonic_valuation ;
 self.avm.address_history_2.avm_automated_valuation := le.address_verification.address_history_2.avm_automated_valuation ;
 self.avm.address_history_2.avm_automated_valuation2 := le.address_verification.address_history_2.avm_automated_valuation2 ;
 self.avm.address_history_2.avm_automated_valuation3 := le.address_verification.address_history_2.avm_automated_valuation3 ;
 self.avm.address_history_2.avm_automated_valuation4 := le.address_verification.address_history_2.avm_automated_valuation4 ;
 self.avm.address_history_2.avm_automated_valuation5 := le.address_verification.address_history_2.avm_automated_valuation5 ;
 self.avm.address_history_2.avm_automated_valuation6 := le.address_verification.address_history_2.avm_automated_valuation6 ;
 self.avm.address_history_2.avm_confidence_score := le.address_verification.address_history_2.avm_confidence_score ;
 self.avm.address_history_2.avm_median_fips_level := le.address_verification.address_history_2.avm_median_fips_level ;
 self.avm.address_history_2.avm_median_geo11_level := le.address_verification.address_history_2.avm_median_geo11_level ;
 self.avm.address_history_2.avm_median_geo12_level := le.address_verification.address_history_2.avm_median_geo12_level ;

 self.addr_risk_summary3.occupants_1yr  := le.Address_Verification.address_history_2.occupants_1yr ;
 self.addr_risk_summary3.turnover_1yr_in  := le.Address_Verification.address_history_2.turnover_1yr_in ;
 self.addr_risk_summary3.turnover_1yr_out  := le.Address_Verification.address_history_2.turnover_1yr_out ;
 self.addr_risk_summary3.N_Vacant_Properties := le.Address_Verification.address_history_2.N_Vacant_Properties ;
 self.addr_risk_summary3.N_Business_Count  := le.Address_Verification.address_history_2.N_Business_Count ;
 self.addr_risk_summary3.N_SFD_Count  := le.Address_Verification.address_history_2.N_SFD_Count ;
 self.addr_risk_summary3.N_MFD_Count := le.Address_Verification.address_history_2.N_MFD_Count ;
 self.addr_risk_summary3.N_ave_building_age := le.Address_Verification.address_history_2.N_ave_building_age ;
 self.addr_risk_summary3.N_ave_purchase_amount  := le.Address_Verification.address_history_2.N_ave_purchase_amount ;
 self.addr_risk_summary3.N_ave_mortgage_amount  := le.Address_Verification.address_history_2.N_ave_mortgage_amount ;
 self.addr_risk_summary3.N_ave_assessed_amount  := le.Address_Verification.address_history_2.N_ave_assessed_amount ;
 self.addr_risk_summary3.N_ave_building_area  := le.Address_Verification.address_history_2.N_ave_building_area ;
 self.addr_risk_summary3.N_ave_price_per_sf  := le.Address_Verification.address_history_2.N_ave_price_per_sf ;
 self.addr_risk_summary3.N_ave_no_of_stories_count  := le.Address_Verification.address_history_2.N_ave_no_of_stories_count ;
 self.addr_risk_summary3.N_ave_no_of_rooms_count  := le.Address_Verification.address_history_2.N_ave_no_of_rooms_count ;
 self.addr_risk_summary3.N_ave_no_of_bedrooms_count  := le.Address_Verification.address_history_2.N_ave_no_of_bedrooms_count ;
 self.addr_risk_summary3.N_ave_no_of_baths_count  := le.Address_Verification.address_history_2.N_ave_no_of_baths_count ;

 self.insurance_phones_summary.Insurance_Phone_Verification := le.phone_verification.Insurance_Phone_Verification ;
 self.Experian_Phone_Verification := le.phone_verification.Experian_Phone_Verification ;
 self.attended_college := le.student.attended_college ;


 self.lres := le.address_verification.input_address_information.lres ;
 self.lres2 := le.address_verification.address_history_1.lres ;
 self.lres3 := le.address_verification.address_history_2.lres ;
 self.addrPop := le.address_verification.input_address_information.addrPop ;
 self.addrPop2 := le.address_verification.address_history_1.addrPop ;
 self.addrPop3 := le.address_verification.address_history_2.addrPop ;
 self.avm.input_address_information.avm_land_use_code := le.address_verification.input_address_information.avm_land_use_code ;
 self.avm.input_address_information.avm_recording_date := le.address_verification.input_address_information.avm_recording_date ;
 self.avm.input_address_information.avm_assessed_value_year := le.address_verification.input_address_information.avm_assessed_value_year ;
 self.avm.input_address_information.avm_sales_price   :=  le.address_verification.input_address_information.avm_sales_price ;
 self.avm.input_address_information.avm_assessed_total_value := le.address_verification.input_address_information.avm_assessed_total_value ;
 self.avm.input_address_information.avm_market_total_value := le.address_verification.input_address_information.avm_market_total_value ;
 self.avm.input_address_information.avm_tax_assessment_valuation := le.address_verification.input_address_information.avm_tax_assessment_valuation ;
 self.avm.input_address_information.avm_price_index_valuation := le.address_verification.input_address_information.avm_price_index_valuation ;
 self.avm.input_address_information.avm_hedonic_valuation := le.address_verification.input_address_information.avm_hedonic_valuation ;
 self.avm.input_address_information.avm_automated_valuation := le.address_verification.input_address_information.avm_automated_valuation ;
 self.avm.input_address_information.avm_confidence_score := le.address_verification.input_address_information.avm_confidence_score ;
 self.avm.input_address_information.avm_median_fips_level := le.address_verification.input_address_information.avm_median_fips_level ;
 self.avm.input_address_information.avm_median_geo11_level := le.address_verification.input_address_information.avm_median_geo11_level ;
 self.avm.input_address_information.avm_median_geo12_level := le.address_verification.input_address_information.avm_median_geo12_level ;

 self.avm.address_history_1.avm_land_use_code := le.address_verification.address_history_1.avm_land_use_code ;
 self.avm.address_history_1.avm_recording_date := le.address_verification.address_history_1.avm_recording_date ;;
 self.avm.address_history_1.avm_assessed_value_year := le.address_verification.address_history_1.avm_assessed_value_year ;
 self.avm.address_history_1.avm_sales_price   :=  le.address_verification.address_history_1.avm_sales_price ;
 self.avm.address_history_1.avm_assessed_total_value := le.address_verification.address_history_1.avm_assessed_total_value ;
 self.avm.address_history_1.avm_market_total_value := le.address_verification.address_history_1.avm_market_total_value ;
 self.avm.address_history_1.avm_tax_assessment_valuation := le.address_verification.address_history_1.avm_tax_assessment_valuation ;
 self.avm.address_history_1.avm_price_index_valuation := le.address_verification.address_history_1.avm_price_index_valuation ;
 self.avm.address_history_1.avm_hedonic_valuation := le.address_verification.address_history_1.avm_hedonic_valuation ;
 self.avm.address_history_1.avm_automated_valuation := le.address_verification.address_history_1.avm_automated_valuation ;
 self.avm.address_history_1.avm_confidence_score := le.address_verification.address_history_1.avm_confidence_score ;
 self.avm.address_history_1.avm_median_fips_level := le.address_verification.address_history_1.avm_median_fips_level ;
 self.avm.address_history_1.avm_median_geo11_level := le.address_verification.address_history_1.avm_median_geo11_level ;
 self.avm.address_history_1.avm_median_geo12_level := le.address_verification.address_history_1.avm_median_geo12_level ;

 self.SSN_Verification.adlPerSSN_count := le.Velocity_Counters.adlPerSSN_count ;

self.iid.socllowissue := (string)le.iid.socllowissue ;
self.iid.soclhighissue := (string)le.iid.soclhighissue ;
self.student.date_first_seen := (string)le.student.date_first_seen; 
self.student.date_last_seen := (string)le.student.date_last_seen ;
self.student.dob_formatted := (string)le.student.dob_formatted ;
 self.student.college_tier := (string)le.student.college_tier ;




self.rv_scores := le.rv_scores ;
self.fd_scores := le.fd_scores ;









self.ConsumerFlags := le.iid.ConsumerFlags ;

 self.ssn_verification.validation.inputsocscharflag := le.ssn_verification.inputsocscharflag ;

 self.Address_Verification.addr_type2 := le.Address_Verification.Address_History_1.addr_type ;
 self.Address_Verification.addr_type3 := le.Address_Verification.Address_History_2.addr_type ;
 self.shell_input.age := le.input_dob_age ;

 self.avm.input_address_information.avm_automated_valuation2 := le.Address_Verification.Input_Address_Information.avm_automated_valuation2 ;
 self.avm.input_address_information.avm_automated_valuation3 := le.Address_Verification.Input_Address_Information.avm_automated_valuation3 ;
 self.avm.input_address_information.avm_automated_valuation4 := le.Address_Verification.Input_Address_Information.avm_automated_valuation4 ;
 self.avm.input_address_information.avm_automated_valuation5 := le.Address_Verification.Input_Address_Information.avm_automated_valuation5 ;
 self.avm.input_address_information.avm_automated_valuation6 := le.Address_Verification.Input_Address_Information.avm_automated_valuation6 ;

 self.avm.address_history_1.avm_automated_valuation2 := le.Address_Verification.Address_History_1.avm_automated_valuation2 ;
 self.avm.address_history_1.avm_automated_valuation3 := le.Address_Verification.Address_History_1.avm_automated_valuation3 ;
 self.avm.address_history_1.avm_automated_valuation4 := le.Address_Verification.Address_History_1.avm_automated_valuation4 ;
 self.avm.address_history_1.avm_automated_valuation5 := le.Address_Verification.Address_History_1.avm_automated_valuation5 ;
 self.avm.address_history_1.avm_automated_valuation6 := le.Address_Verification.Address_History_1.avm_automated_valuation6 ;

 self.liens := le.bjl.liens ;


 self.other_address_info.addrs_last30 := le.attributes.addrs_last30 ;
 self.other_address_info.addrs_last90 := le.attributes.addrs_last90 ;
 self.other_address_info.addrs_last12 := le.attributes.addrs_last12 ;
 self.other_address_info.addrs_last24 := le.attributes.addrs_last24 ;
 self.other_address_info.addrs_last36 := le.attributes.addrs_last36 ;
 self.other_address_info.date_first_purchase := le.attributes.date_first_purchase ;
 self.other_address_info.date_most_recent_purchase := le.attributes.date_most_recent_purchase ;
 self.other_address_info.date_most_recent_sale := le.attributes.date_most_recent_sale ;
 self.other_address_info.num_purchase30 := le.attributes.num_purchase30 ;
 self.other_address_info.num_purchase90 := le.attributes.num_purchase90 ;
 self.other_address_info.num_purchase180 := le.attributes.num_purchase180 ;
 self.other_address_info.num_purchase12 := le.attributes.num_purchase12 ;
 self.other_address_info.num_purchase24 := le.attributes.num_purchase24 ;
 self.other_address_info.num_purchase36 := le.attributes.num_purchase36 ;
 self.other_address_info.num_purchase60 := le.attributes.num_purchase60 ;
 self.other_address_info.num_sold30 := le.attributes.num_sold30 ;
 self.other_address_info.num_sold90 := le.attributes.num_sold90 ;
 self.other_address_info.num_sold180 := le.attributes.num_sold180 ;
 self.other_address_info.num_sold12 := le.attributes.num_sold12 ;
 self.other_address_info.num_sold24 := le.attributes.num_sold24 ;
 self.other_address_info.num_sold36 := le.attributes.num_sold36 ;
 self.other_address_info.num_sold60 := le.attributes.num_sold60 ;
 self.watercraft.watercraft_count30 := le.attributes.num_watercraft30 ;
 self.watercraft.watercraft_count90 := le.attributes.num_watercraft90 ;
 self.watercraft.watercraft_count180 := le.attributes.num_watercraft180 ;
 self.watercraft.watercraft_count12 := le.attributes.num_watercraft12 ;
 self.watercraft.watercraft_count24 := le.attributes.num_watercraft24 ;
 self.watercraft.watercraft_count36 := le.attributes.num_watercraft36 ;
 self.watercraft.watercraft_count60 := le.attributes.num_watercraft60 ;
 self.aircraft.aircraft_count := le.attributes.num_aircraft ;
 self.aircraft.aircraft_count30 := le.attributes.num_aircraft30 ;
 self.aircraft.aircraft_count90 := le.attributes.num_aircraft90 ;
 self.aircraft.aircraft_count180 := le.attributes.num_aircraft180 ;
 self.aircraft.aircraft_count12 := le.attributes.num_aircraft12 ;
 self.aircraft.aircraft_count24 := le.attributes.num_aircraft24 ;
 self.aircraft.aircraft_count36 := le.attributes.num_aircraft36 ;
 self.aircraft.aircraft_count60 := le.attributes.num_aircraft60 ;
 self.total_number_derogs := le.attributes.total_number_derogs ;
 self.date_last_derog := le.attributes.date_last_derog ;
 self.bjl.criminal_count30 := le.attributes.felonies30 ;
 self.bjl.criminal_count90 := le.attributes.felonies90 ;
 self.bjl.criminal_count180 := le.attributes.felonies180 ;
 self.bjl.criminal_count12 := le.attributes.felonies12 ;
 self.bjl.criminal_count24 := le.attributes.felonies24 ;
 self.bjl.criminal_count36 := le.attributes.felonies36 ;
 self.bjl.criminal_count60 := le.attributes.felonies60 ;
 self.bjl.arrests_count := le.attributes.arrests ;
 self.bjl.date_last_arrest := le.attributes.date_last_arrest ;
 self.bjl.arrests_count30 := le.attributes.arrests30 ;
 self.bjl.arrests_count90 := le.attributes.arrests90 ;
 self.bjl.arrests_count180 := le.attributes.arrests180 ;
 self.bjl.arrests_count12 := le.attributes.arrests12 ;
 self.bjl.arrests_count24 := le.attributes.arrests24 ;
 self.bjl.arrests_count36 := le.attributes.arrests36 ;
 self.bjl.arrests_count60 := le.attributes.arrests60 ;
 self.bjl.liens_unreleased_count30 := le.attributes.num_unreleased_liens30 ;
 self.bjl.liens_unreleased_count90 := le.attributes.num_unreleased_liens90 ;
 self.bjl.liens_unreleased_count180 := le.attributes.num_unreleased_liens180 ;
 self.bjl.liens_unreleased_count12 := le.attributes.num_unreleased_liens12 ;
 self.bjl.liens_unreleased_count24 := le.attributes.num_unreleased_liens24 ;
 self.bjl.liens_unreleased_count36 := le.attributes.num_unreleased_liens36 ;
 self.bjl.liens_unreleased_count60 := le.attributes.num_unreleased_liens60 ;
 self.bjl.liens_released_count30 := le.attributes.num_released_liens30 ;
 self.bjl.liens_released_count90 := le.attributes.num_released_liens90 ;
 self.bjl.liens_released_count180 := le.attributes.num_released_liens180 ;
 self.bjl.liens_released_count12 := le.attributes.num_released_liens12 ;
 self.bjl.liens_released_count24 := le.attributes.num_released_liens24 ;
 self.bjl.liens_released_count36 := le.attributes.num_released_liens36 ;
 self.bjl.liens_released_count60 := le.attributes.num_released_liens60 ;
 self.bjl.bk_count30 := le.attributes.bankruptcy_count30 ;
 self.bjl.bk_count90 := le.attributes.bankruptcy_count90 ;
 self.bjl.bk_count180 := le.attributes.bankruptcy_count180 ;
 self.bjl.bk_count12 := le.attributes.bankruptcy_count12 ;
 self.bjl.bk_count24 := le.attributes.bankruptcy_count24 ;
 self.bjl.bk_count36 := le.attributes.bankruptcy_count36 ;
 self.bjl.bk_count60 := le.attributes.bankruptcy_count60 ;
 self.bjl.eviction_count := le.attributes.eviction_count ;
 self.bjl.last_eviction_date := le.attributes.date_last_eviction ;
 self.bjl.eviction_count30 := le.attributes.eviction_count30 ;
 self.bjl.eviction_count90 := le.attributes.eviction_count90 ;
 self.bjl.eviction_count180 := le.attributes.eviction_count180 ;
 self.bjl.eviction_count12 := le.attributes.eviction_count12 ;
 self.bjl.eviction_count24 := le.attributes.eviction_count24 ;
 self.bjl.eviction_count36 := le.attributes.eviction_count36 ;
 self.bjl.eviction_count60 := le.attributes.eviction_count60 ;
 self.source_verification.num_nonderogs := le.attributes.num_nonderogs ;
 self.source_verification.num_nonderogs30 := le.attributes.num_nonderogs30 ;
 self.source_verification.num_nonderogs90 := le.attributes.num_nonderogs90 ;
 self.source_verification.num_nonderogs180 := le.attributes.num_nonderogs180 ;
 self.source_verification.num_nonderogs12 := le.attributes.num_nonderogs12 ;
 self.source_verification.num_nonderogs24 := le.attributes.num_nonderogs24 ;
 self.source_verification.num_nonderogs36 := le.attributes.num_nonderogs36 ;
 self.source_verification.num_nonderogs60 := le.attributes.num_nonderogs60 ;
 self.professional_license.proflic_count30 := le.attributes.num_proflic30 ;
 self.professional_license.proflic_count90 := le.attributes.num_proflic90 ;
 self.professional_license.proflic_count180 := le.attributes.num_proflic180; 
 self.professional_license.proflic_count12 := le.attributes.num_proflic12 ;
 self.professional_license.proflic_count24 := le.attributes.num_proflic24 ;
 self.professional_license.proflic_count36 := le.attributes.num_proflic36 ;
 self.professional_license.proflic_count60 := le.attributes.num_proflic60 ;
 self.professional_license.expire_count30 := le.attributes.num_proflic_exp30; 
 self.professional_license.expire_count90 := le.attributes.num_proflic_exp90 ;
 self.professional_license.expire_count180 := le.attributes.num_proflic_exp180; 
 self.professional_license.expire_count12 := le.attributes.num_proflic_exp12 ;
 self.professional_license.expire_count24 := le.attributes.num_proflic_exp24 ;
 self.professional_license.expire_count36 := le.attributes.num_proflic_exp36 ;
 self.professional_license.expire_count60 := le.attributes.num_proflic_exp60 ;

 self.infutor_phone := le.infutor ;
	self.iid.correctlast := le.iid.correctlast;
 self.estimated_income := le.estimated_income ;


 self.student.college_major:=  le.student.college_major ;
 self.student.file_type2 := le.student.file_type ;

 self.address_verification.input_address_information.assessed_amount := le.address_verification.input_address_information.market_total_value ;
 self.address_verification.address_history_1.assessed_amount := le.address_verification.address_history_1.market_total_value ;
 self.address_verification.address_history_2.assessed_amount := le.address_verification.address_history_2.market_total_value ;

 self.address_history_summary.address_history_advo_college_hit := le.Other_Address_Info.address_history_advo_college_hit ;


self.advo_input_addr.Throw_Back_Indicator :=  le.Address_Verification.Input_Address_Information.Throw_Back_Indicator ;
 self.advo_input_addr.Seasonal_Delivery_Indicator := le.Address_Verification.Input_Address_Information.Seasonal_Delivery_Indicator ;
self.advo_input_addr.DND_Indicator :=  le.Address_Verification.Input_Address_Information.DND_Indicator ;
 self.advo_input_addr.College_Indicator := le.Address_Verification.Input_Address_Information.College_Indicator ;


 self.advo_input_addr.Mixed_Address_Usage := le.Address_Verification.Input_Address_Information.Mixed_Address_Usage ;

 self.addr_risk_summary.occupants_1yr  := le.Address_Verification.Input_Address_Information.occupants_1yr ;
 self.addr_risk_summary.turnover_1yr_in  := le.Address_Verification.Input_Address_Information.turnover_1yr_in ;
 self.addr_risk_summary.turnover_1yr_out  := le.Address_Verification.Input_Address_Information.turnover_1yr_out ;
 self.addr_risk_summary.N_Vacant_Properties := le.Address_Verification.Input_Address_Information.N_Vacant_Properties ;
 self.addr_risk_summary.N_Business_Count  := le.Address_Verification.Input_Address_Information.N_Business_Count ;
 self.addr_risk_summary.N_SFD_Count  := le.Address_Verification.Input_Address_Information.N_SFD_Count ;
 self.addr_risk_summary.N_MFD_Count := le.Address_Verification.Input_Address_Information.N_MFD_Count ;
 self.addr_risk_summary.N_ave_building_age := le.Address_Verification.Input_Address_Information.N_ave_building_age ;
 self.addr_risk_summary.N_ave_purchase_amount  := le.Address_Verification.Input_Address_Information.N_ave_purchase_amount ;
 self.addr_risk_summary.N_ave_mortgage_amount  := le.Address_Verification.Input_Address_Information.N_ave_mortgage_amount ;
 self.addr_risk_summary.N_ave_assessed_amount  := le.Address_Verification.Input_Address_Information.N_ave_assessed_amount ;
 self.addr_risk_summary.N_ave_building_area  := le.Address_Verification.Input_Address_Information.N_ave_building_area ;
 self.addr_risk_summary.N_ave_price_per_sf  := le.Address_Verification.Input_Address_Information.N_ave_price_per_sf ;
 self.addr_risk_summary.N_ave_no_of_stories_count  := le.Address_Verification.Input_Address_Information.N_ave_no_of_stories_count ;
 self.addr_risk_summary.N_ave_no_of_rooms_count  := le.Address_Verification.Input_Address_Information.N_ave_no_of_rooms_count ;
 self.addr_risk_summary.N_ave_no_of_bedrooms_count  := le.Address_Verification.Input_Address_Information.N_ave_no_of_bedrooms_count;
 self.addr_risk_summary.N_ave_no_of_baths_count  := le.Address_Verification.Input_Address_Information.N_ave_no_of_baths_count ;

self.advo_addr_hist1.Throw_Back_Indicator :=  le.Address_Verification.Address_History_1.Throw_Back_Indicator ;
 self.advo_addr_hist1.Seasonal_Delivery_Indicator := le.Address_Verification.Address_History_1.Seasonal_Delivery_Indicator ;
self.advo_addr_hist1.DND_Indicator :=  le.Address_Verification.Address_History_1.DND_Indicator ;
 self.advo_addr_hist1.College_Indicator := le.Address_Verification.Address_History_1.College_Indicator ;


 self.advo_addr_hist1.Mixed_Address_Usage := le.Address_Verification.Address_History_1.Mixed_Address_Usage ;

 self.addr_risk_summary2.occupants_1yr  := le.Address_Verification.Address_History_1.occupants_1yr ;
 self.addr_risk_summary2.turnover_1yr_in  := le.Address_Verification.Address_History_1.turnover_1yr_in ;
 self.addr_risk_summary2.turnover_1yr_out  := le.Address_Verification.Address_History_1.turnover_1yr_out ;
 self.addr_risk_summary2.N_Vacant_Properties := le.Address_Verification.Address_History_1.N_Vacant_Properties ;
 self.addr_risk_summary2.N_Business_Count  := le.Address_Verification.Address_History_1.N_Business_Count ;
 self.addr_risk_summary2.N_SFD_Count  := le.Address_Verification.Address_History_1.N_SFD_Count ;
 self.addr_risk_summary2.N_MFD_Count := le.Address_Verification.Address_History_1.N_MFD_Count ;
 self.addr_risk_summary2.N_ave_building_age := le.Address_Verification.Address_History_1.N_ave_building_age ;
 self.addr_risk_summary2.N_ave_purchase_amount  := le.Address_Verification.Address_History_1.N_ave_purchase_amount ;
 self.addr_risk_summary2.N_ave_mortgage_amount  := le.Address_Verification.Address_History_1.N_ave_mortgage_amount ;
 self.addr_risk_summary2.N_ave_assessed_amount  := le.Address_Verification.Address_History_1.N_ave_assessed_amount ;
 self.addr_risk_summary2.N_ave_building_area  := le.Address_Verification.Address_History_1.N_ave_building_area ;
 self.addr_risk_summary2.N_ave_price_per_sf  := le.Address_Verification.Address_History_1.N_ave_price_per_sf ;
 self.addr_risk_summary2.N_ave_no_of_stories_count  := le.Address_Verification.Address_History_1.N_ave_no_of_stories_count ;
 self.addr_risk_summary2.N_ave_no_of_rooms_count  := le.Address_Verification.Address_History_1.N_ave_no_of_rooms_count ;
 self.addr_risk_summary2.N_ave_no_of_bedrooms_count  := le.Address_Verification.Address_History_1.N_ave_no_of_bedrooms_count ;
 self.addr_risk_summary2.N_ave_no_of_baths_count  := le.Address_Verification.Address_History_1.N_ave_no_of_baths_count ;



 // self.ADL_Shell_Flags.in_addrpop   :=  SELF.in_addrpop 
 // self.ADL_Shell_Flags.in_hphnpop := le.in_hphnpop ;
 // self.ADL_Shell_Flags.in_ssnpop := le.in_ssnpop ;
 // self.ADL_Shell_Flags.in_dobpop := le.in_dobpop ;
 // self.ADL_Shell_Flags.adl_addr := le.adl_addr ;
 // self.ADL_Shell_Flags.adl_hphn := le.adl_hphn ;
 // self.ADL_Shell_Flags.adl_ssn := le.adl_ssn ;
 // self.ADL_Shell_Flags.adl_dob := le.adl_dob ;
 // self.ADL_Shell_Flags.in_addrpop_found := le.in_addrpop_found ;



 self.iid.areacodesplitdate := (string)le.iid.areacodesplitdate ;
 self.iid.areacodesplitflag := le.iid.areacodesplitflag ;
 self.iid.drlcvalflag := le.iid.drlcvalflag ;
 self.iid.name_addr_phone := le.iid.name_addr_phone ;
 self.iid.didcount := le.iid.DIDCount ;
 self.iid.did2 := le.iid.DID2 ;
 self.iid.did3 := le.iid.DID3 ;
 self.address_verification.input_address_information.county := le.address_verification.input_address_information.county ;
 self.address_verification.input_address_information.geo_blk := le.address_verification.input_address_information.geo_blk ;
 self.address_verification.address_history_1.county := le.address_verification.address_history_1.county ;
 self.address_verification.address_history_1.geo_blk := le.address_verification.address_history_1.geo_blk ;
 self.address_verification.address_history_2.county := le.address_verification.address_history_2.county ;
 self.address_verification.address_history_2.geo_blk := le.address_verification.address_history_2.geo_blk ;
 self.phone_verification.recent_disconnects := le.phone_verification.recent_disconnects ;
 self.velocity_counters.addrs_per_ssn  := le.velocity_counters.addrs_per_ssn ;
 self.velocity_counters.addrs_per_ssn_created_6months  := le.velocity_counters.addrs_per_ssn_created_6months ;
 self.velocity_counters.phones_per_addr_created_6months  := le.velocity_counters.phones_per_addr_created_6months ;
 self.velocity_counters.adls_per_phone_created_6months  := le.velocity_counters.adls_per_phone_created_6months ;
 self.acc_logs.inquiryPerSSN  := le.acc_logs.inquiryPerSSN ;
 self.acc_logs.inquiryADLsPerSSN  := le.acc_logs.inquiryADLsPerSSN ;;
 self.acc_logs.inquiryLNamesPerSSN  := le.acc_logs.inquiryLNamesPerSSN ;
 self.acc_logs.inquiryAddrsPerSSN  := le.acc_logs.inquiryAddrsPerSSN ;
 self.acc_logs.inquiryDOBsPerSSN  := le.acc_logs.inquiryDOBsPerSSN ;
 self.acc_logs.inquiryPerAddr  := le.acc_logs.inquiryPerAddr ;
 self.acc_logs.inquiryADLsPerAddr  := le.acc_logs.inquiryADLsPerAddr ;
 self.acc_logs.inquiryLNamesPerAddr  := le.acc_logs.inquiryLNamesPerAddr ;
 self.acc_logs.inquirySSNsPerAddr  := le.acc_logs.inquirySSNsPerAddr ;
 self.acc_logs.inquiryPerPhone  := le.acc_logs.inquiryPerPhone ;
 self.acc_logs.inquiryADLsPerPhone  := le.acc_logs.inquiryADLsPerPhone ;
 self.acc_logs.inquiryADLsPerEmail  := le.acc_logs.inquiryADLsPerEmail ;
 self.acc_logs.inquiries.countday := le.acc_logs.inquiries.countday;
 self.acc_logs.auto.countday := le.acc_logs.auto.countday;
 self.acc_logs.banking.countday := le.acc_logs.banking.countday;
 self.acc_logs.collection.countday := le.acc_logs.collection.countday;
 self.acc_logs.communications.countday := le.acc_logs.communications.countday;
 self.acc_logs.highriskcredit.countday := le.acc_logs.highriskcredit.countday;
 self.acc_logs.mortgage.countday := le.acc_logs.mortgage.countday;
 self.acc_logs.other.countday := le.acc_logs.other.countday;
 self.acc_logs.prepaidCards.countday := le.acc_logs.prepaidCards.countday;
 self.acc_logs.QuizProvider.countday := le.acc_logs.QuizProvider.countday;
 self.acc_logs.retail.countday := le.acc_logs.retail.countday;
 self.acc_logs.retailPayments.countday := le.acc_logs.retailPayments.countday;
 self.acc_logs.StudentLoans.countday := le.acc_logs.StudentLoans.countday;
 self.acc_logs.Utilities.countday := le.acc_logs.Utilities.countday;
 self.acc_logs.inquiries.countweek := le.acc_logs.inquiries.countweek;
 self.acc_logs.auto.countweek := le.acc_logs.auto.countweek;
 self.acc_logs.banking.countweek := le.acc_logs.banking.countweek;
 self.acc_logs.collection.countweek := le.acc_logs.collection.countweek;
 self.acc_logs.communications.countweek := le.acc_logs.communications.countweek;
 self.acc_logs.highriskcredit.countweek := le.acc_logs.highriskcredit.countweek;
 self.acc_logs.mortgage.countweek := le.acc_logs.mortgage.countweek;
 self.acc_logs.other.countweek := le.acc_logs.other.countweek;
 self.acc_logs.prepaidCards.countweek := le.acc_logs.prepaidCards.countweek;
 self.acc_logs.QuizProvider.countweek := le.acc_logs.QuizProvider.countweek;
 self.acc_logs.retail.countweek := le.acc_logs.retail.countweek;
 self.acc_logs.retailPayments.countweek := le.acc_logs.retailPayments.countweek;
 self.acc_logs.StudentLoans.countweek := le.acc_logs.StudentLoans.countweek;
 self.acc_logs.Utilities.countweek := le.acc_logs.Utilities.countweek;

 self.velocity_counters.lnames_per_adl := le.velocity_counters.lnames_per_adl ;
 self.velocity_counters.lnames_per_adl180 := le.velocity_counters.lnames_per_adl_created_6months ;
 self.iid.lastcount:=  le.iid.lastcount ;
self.iid.altlastPop := le.iid.altlastPop ;
self.iid.altlast2Pop := le.iid.altlast2Pop ;
 self.name_verification.lname_change_date := le.name_verification.lname_change_date ;
 self.name_verification.lname_prev_change_date := le.name_verification.lname_prev_change_date ;
 self.acc_logs.inquirylnamesperadl := le.acc_logs.inquirylnamesperadl ;
 self.student.income_level_code := le.student.INCOME_LEVEL_CODE ;
 
 self.advo_addr_hist1.Drop_Indicator := le.Address_Verification.Address_History_1.Drop_Indicator;

 self.advo_addr_hist1.Address_Vacancy_Indicator	 := le.Address_Verification.Address_History_1.Address_Vacancy_Indicator;

 self.advo_addr_hist1.Residential_or_Business_Ind	 := le.Address_Verification.Address_History_1.Residential_or_Business_Ind;

 self.advo_input_addr.Residential_or_Business_Ind	 := le.Address_Verification.Input_Address_Information.Residential_or_Business_Ind;

 self.advo_input_addr.Drop_Indicator := le.Address_Verification.Input_Address_Information.Drop_Indicator;

 self.advo_input_addr.Address_Vacancy_Indicator	 := le.Address_Verification.Input_Address_Information.Address_Vacancy_Indicator;


 
// self.assetIndex := le.AssetValueIndex;
// self.AssetIndexPrimaryFactor:= le.AssetIndexPrimaryFactor  ;
// self.SubjectStabilityIndex :=le.StabilityIndex ;
// self.SubjectStabilityPrimaryFactor:= le.StabilityPrimaryFactor ;
 // self.SubjectAbilityIndex :=le.AbilityIndex ;
// self.SubjectAbilityPrimaryFactor :=le.AbilityIndexPrimaryFactor ;
// self.SubjectWillingnessIndex := le.WillingnessIndex ;
// self.SubjectWillingnessPrimaryFactor :=le.WillingnessIndexPrimaryFactor ;
self := le;
self := [];
end;

	edina_to_internal := project( bs, Convert_Edina_to_Internal(left) );
	
	return edina_to_internal;
END;

