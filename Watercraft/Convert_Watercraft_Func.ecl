// Convert to Dcument record
// Needs to match BWR_Build_Segment_Metadata
import Text_Search;

export Convert_Watercraft_Func(DATASET(Layout_Watercraft_Full) ds) := FUNCTION

	

	Text_Search.Layout_Document cvt(Layout_Watercraft_Full l) := TRANSFORM
		SELF.docRef.src := TRANSFER(l.src, INTEGER2);
		SELF.docRef.doc := l.uid;
		SELF.segs := DATASET([
			{ 1, 0, l.orig_name + ' ' + l.orig_name_first + ' ' + l.orig_name_middle + ' ' + l.orig_name_last + '; '}, 
			{ 2, 0, l.dob + '; '}, 
			{ 3, 0, l.orig_ssn}, 
			{ 4, 0,	l.orig_fein}, 
			{ 5, 0, l.gender}, 
			{ 6, 0, l.orig_address_1 + ' ' + l.orig_address_2 + ' ' + l.orig_city + ' ' +
						l.orig_state + ' ' + l.orig_zip + '; '}, 
			//{ 7, 0,	l.orig_city}, 
			//{ 8, 0, l.orig_state}, 
			//{ 9, 0, l.orig_zip}, 
			{10, 0, l.phone_1 + '; ' + l.phone_2 + '; '}, 
			{11, 0, l.st_registration}, 
			{12, 0, l.registration_number}, 
			{13, 0, l.registration_date + '; '}, 
			{14, 0, l.registration_expiration_date + '; '},
			{15, 0,	l.registration_status_description}, 
			{16, 0, l.registration_status_date + '; '}, 
			{17, 0,	l.registration_renewal_date + '; '}, 
			{18, 0, l.decal_number}, 
			//{19, 0,	l.prev_plate_state}, 
			{20, 0, l.hull_number}, 
			{21, 0, l.vessel_id}, 
			{22, 0,	l.vessel_database_key}, 
			{23, 0, l.party_identification_number}, 
			{24, 0, l.imo_number}, 
			{25, 0, l.call_sign},
			{26, 0, l.propulsion_description}, 
			{27, 0, l.vehicle_type_description}, 
			{28, 0, l.fuel_description}, 
			{29, 0,	l.hull_type_description}, 
			{30, 0, l.use_description}, 
			{31, 0, l.model_year}, 
			{32, 0,	l.watercraft_name},
			{33, 0, l.watercraft_class_description}, 
			{34, 0,	l.watercraft_make_description}, 
			{35, 0, l.watercraft_model_description}, 
			{36, 0, l.watercraft_length},
			{37, 0, l.watercraft_width}, 
			{38, 0, l.watercraft_weight}, 
			{39, 0, l.watercraft_color_1_description + '; ' + l.watercraft_color_1_description}, 
			{40, 0, l.watercraft_toilet_description}, 
			{41, 0, l.coast_guard_number}, 
			{42, 0, l.state_purchased}, 
			{43, 0,	l.purchase_date}, 
			{44, 0, l.dealer}, 
			{45, 0, l.purchase_price}, 
			{46, 0,	l.registered_gross_tons}, 
			{47, 0, l.registered_net_tons}, 
			{48, 0, l.registered_breadth}, 
			{49, 0,	l.registered_depth}, 
			{50, 0, l.itc_gross_tons}, 
			{51, 0,	l.itc_net_tons}, 
			{52, 0, l.itc_length}, 
			{53, 0, l.itc_breadth}, 
			{54, 0, l.itc_depth}, 
			{55, 0, l.hailing_port + ' ' + l.hailing_port_state + ' ' + l.hailing_port_province},
			{56, 0, l.home_port_name + ' ' + l.home_port_state + ' ' + l.home_port_province},
			{57, 0, l.vessel_complete_build_city + ' ' + l.vessel_complete_build_state
									+ ' ' + l.vessel_complete_build_province + ' ' + l.vessel_complete_build_country},
			{58, 0, l.vessel_hull_build_city + ' ' + l.vessel_hull_build_state
									+ ' ' + l.vessel_hull_build_province + ' ' + l.vessel_hull_build_country},
			{59, 0, l.main_hp_astern},
			{60, 0, l.main_hp_ahead},
			// 61. No fleet-id
			{62, 0, l.watercraft_hp_1 + '; ' + l.watercraft_hp_2 + '; ' + l.watercraft_hp_3 + '; '},
			{63, 0, l.engine_number_1 + '; ' + l.engine_number_2 + '; ' + l.engine_number_3 + '; '}, 
			{64, 0, l.engine_make_1 + '; ' + l.engine_make_2 + '; ' + l.engine_make_3 + '; '}, 
			{65, 0, l.engine_model_1 + '; ' + l.engine_model_2 + '; ' + l.engine_model_3 + '; '}, 
			{66, 0, l.engine_year_1 + '; ' + l.engine_year_2 + '; ' + l.engine_year_3 + '; '}, 
			{67, 0, l.transaction_type_description}, 
			{68, 0,	l.title_state}, 
			{69, 0, l.title_status_description}, 
			{70, 0, l.title_number}, 
			{71, 0, l.title_issue_date + '; '}, 
			{72, 0, l.title_type_description}, 
			// dates 
			//{73, 0,	l.signatory}, 
			{74, 0, l.lien_1_name + '; ' + l.lien_2_name}, 
			{75, 0,	l.lien_1_date + '; ' + l.lien_2_date}, 
			{76, 0, l.lien_1_address_1 + ' ' + l.lien_1_address_2 + ' ' + l.lien_1_city + ' ' +
						l.lien_1_state + ' ' + l.lien_1_zip + '; ' +
					l.lien_2_address_1 + ' ' + l.lien_2_address_2 + ' ' + l.lien_2_city + ' ' +
						l.lien_2_state + ' ' + l.lien_2_zip} 
			//{77,0,l.lien_1_city + '; ' + l.lien_2_city},
			//{78,0,l.lien_1_state + '; ' + l.lien_2_state},
			//{79,0,l.lien_1_zip + '; ' + l.lien_2_zip}
		 ], Text_Search.Layout_Segment);
	END;

	proj_recs := PROJECT(ds, cvt(LEFT));
	
	Text_search.Layout_DocSeg flatten_records(Text_search.Layout_Document l, Text_Search.Layout_Segment r) 
	:= TRANSFORM
		SELF.docRef := l.docRef;
		SELF := r;
	END;
		
	reslt := NORMALIZE(proj_recs, LEFT.segs, flatten_records(LEFT,RIGHT));

	RETURN reslt;
END;