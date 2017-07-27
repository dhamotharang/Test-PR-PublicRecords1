import Watercraft_UMF, Ut,Business_Header_SS,Business_Header,watercraft;

dSearchDist	:= distribute(Watercraft.Persist_Search_Joined,hash(state_origin,source_code,watercraft_key));
dSearchSort	:= sort(dSearchDist,state_origin,source_code,watercraft_key,sequence_key,local);
dMainDist	:= distribute(Watercraft.Persist_Main_Joined,hash(state_origin,source_code,watercraft_key));
dMainSort	:= sort(dMainDist,state_origin,source_code,watercraft_key,sequence_key,local);

dSearchMainJoined	:= join(dSearchSort,dMainSort,
							left.state_origin   = right.state_origin
					    and left.source_code    = right.source_code
						and	left.watercraft_key = right.watercraft_key
						and	left.sequence_key   = right.sequence_key,
							left outer,
							keep(1),		// shouldn't be necessary, but...
							local
						   );

dSearchMainSort		:= sort(dSearchMainJoined,
							watercraft_key,
							state_origin,
							source_code,
							dppa_flag,
							orig_name,
							orig_name_type_code,
							orig_name_type_description,
							orig_name_first,
							orig_name_middle,
							orig_name_last,
							orig_name_suffix,
							orig_address_1,
							orig_address_2,
							orig_city,
							orig_state,
							orig_zip,
							orig_fips,
							dob,
							orig_ssn,
							orig_fein,
							gender,
							phone_1,
							phone_2,
							st_registration,
							county_registration,
							registration_number,
							hull_number,
							propulsion_code,
							propulsion_description,
							vehicle_type_code,
							vehicle_type_description,
							fuel_code,
							fuel_description,
							hull_type_code,
							hull_type_description,
							use_code,
							use_description,
							model_year,
							watercraft_name,
							watercraft_class_code,
							watercraft_class_description,
							watercraft_make_code,
							watercraft_make_description,
							watercraft_model_code,
							watercraft_model_description,
							watercraft_length,
							watercraft_width,
							watercraft_weight,
							watercraft_color_1_code,
							watercraft_color_1_description,
							watercraft_color_2_code,
							watercraft_color_2_description,
							watercraft_toilet_code,
							watercraft_toilet_description,
							watercraft_number_of_engines,
							watercraft_hp_1,
							watercraft_hp_2,
							watercraft_hp_3,
							engine_number_1,
							engine_number_2,
							engine_number_3,
							engine_make_1,
							engine_make_2,
							engine_make_3,
							engine_model_1,
							engine_model_2,
							engine_model_3,
							engine_year_1,
							engine_year_2,
							engine_year_3,
							coast_guard_documented_flag,
							coast_guard_number,
							registration_date,
							registration_expiration_date,
							registration_status_code,
							registration_status_description,
							registration_status_date,
							registration_renewal_date,
							decal_number,
							transaction_type_code,
							transaction_type_description,
							title_state,
							title_status_code,
							title_status_description,
							title_number,
							title_issue_date,
							title_type_code,
							title_type_description,
							additional_owner_count,
							lien_1_indicator,
							lien_1_name,
							lien_1_date,
							lien_1_address_1,
							lien_1_address_2,
							lien_1_city,
							lien_1_state,
							lien_1_zip,
							lien_2_indicator,
							lien_2_name,
							lien_2_date,
							lien_2_address_1,
							lien_2_address_2,
							lien_2_city,
							lien_2_state,
							lien_2_zip,
							state_purchased,
							purchase_date,
							dealer,
							purchase_price,
							new_used_flag,
							watercraft_status_code,
							watercraft_status_description,
							date_first_seen,				
							local
						   );

dSearchMainDedup	:= dedup(dSearchMainJoined,
							 watercraft_key,
							 state_origin,
							 source_code,
							 dppa_flag,
							 orig_name,
							 orig_name_type_code,
							 orig_name_type_description,
							 orig_name_first,
							 orig_name_middle,
							 orig_name_last,
							 orig_name_suffix,
							 orig_address_1,
							 orig_address_2,
							 orig_city,
							 orig_state,
							 orig_zip,
							 orig_fips,
							 dob,
							 orig_ssn,
							 orig_fein,
							 gender,
							 phone_1,
							 phone_2,
							 st_registration,
							 county_registration,
							 registration_number,
							 hull_number,
							 propulsion_code,
							 propulsion_description,
							 vehicle_type_code,
							 vehicle_type_description,
							 fuel_code,
							 fuel_description,
							 hull_type_code,
							 hull_type_description,
							 use_code,
							 use_description,
							 model_year,
							 watercraft_name,
							 watercraft_class_code,
							 watercraft_class_description,
							 watercraft_make_code,
							 watercraft_make_description,
							 watercraft_model_code,
							 watercraft_model_description,
							 watercraft_length,
							 watercraft_width,
							 watercraft_weight,
							 watercraft_color_1_code,
							 watercraft_color_1_description,
							 watercraft_color_2_code,
							 watercraft_color_2_description,
							 watercraft_toilet_code,
							 watercraft_toilet_description,
							 watercraft_number_of_engines,
							 watercraft_hp_1,
							 watercraft_hp_2,
							 watercraft_hp_3,
							 engine_number_1,
							 engine_number_2,
							 engine_number_3,
							 engine_make_1,
							 engine_make_2,
							 engine_make_3,
							 engine_model_1,
							 engine_model_2,
							 engine_model_3,
							 engine_year_1,
							 engine_year_2,
							 engine_year_3,
							 coast_guard_documented_flag,
							 coast_guard_number,
							 registration_date,
							 registration_expiration_date,
							 registration_status_code,
							 registration_status_description,
							 registration_status_date,
							 registration_renewal_date,
							 decal_number,
							 transaction_type_code,
							 transaction_type_description,
							 title_state,
							 title_status_code,
							 title_status_description,
							 title_number,
							 title_issue_date,
							 title_type_code,
							 title_type_description,
							 additional_owner_count,
							 lien_1_indicator,
							 lien_1_name,
							 lien_1_date,
							 lien_1_address_1,
							 lien_1_address_2,
							 lien_1_city,
							 lien_1_state,
							 lien_1_zip,
							 lien_2_indicator,
							 lien_2_name,
							 lien_2_date,
							 lien_2_address_1,
							 lien_2_address_2,
							 lien_2_city,
							 lien_2_state,
							 lien_2_zip,
							 state_purchased,
							 purchase_date,
							 dealer,
							 purchase_price,
							 new_used_flag,
							 watercraft_status_code,
							 watercraft_status_description,
							 //date_first_seen,			
							 right,local // keep last
							);

Watercraft.Layout_Watercraft_Search_Base	tAsSearchAgain(dSearchMainDedup pInput)
 :=
  transform
	self	:= pInput;
  end
 ;

dAllAsSearchAgain			:=	project(dSearchMainDedup,tAsSearchAgain(left));

Watercraft.Layout_Watercraft_Search_Base	tGetMainHistoryFlag(dAllAsSearchAgain pSearch, dMainSort pMain)
 :=
  transform
	self.history_flag	:=	pMain.history_flag;
	self				:=	pSearch;
  end
 ;

dSearchMainJoinedHistory	:=	join(dAllAsSearchAgain,dMainSort,
									 left.state_origin   = right.state_origin
								 and left.source_code    = right.source_code
								 and left.watercraft_key = right.watercraft_key
								 and left.sequence_key   = right.sequence_key,
									 tGetMainHistoryFlag(left,right),
									 left outer,
									 keep(1),		// shouldn't be necessary, but...
									 local
									);


file_party := dSearchMainJoinedHistory ;

rec_temp := record

Watercraft.Layout_Watercraft_Search_Base ;
integer8  temp_BDID;

end;

rec_temp tappendfein(watercraft.Layout_Watercraft_Search_Base L) := transform

self := L;
self.temp_bdid := (unsigned6)L.bdid;

end;

file_party_fein_temp := project(file_party,tappendfein(left)); 

//Append fein

Business_Header_SS.MAC_Add_FEIN_By_BDID(file_party_fein_temp, temp_bdid, fein, file_party_fein)

Watercraft.Layout_Watercraft_Search_Base tremovetempbDID(rec_temp L) := transform

self := L;

end;

out_search := project(file_party_fein,tremovetempbDID(left)) ; 
 
// Add persistent record id. 

 search_dedup := dedup(sort(project(out_search, transform(Watercraft.Layout_Watercraft_Search_Base, 
		
		self.watercraft_key := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.watercraft_key)); 
		self.sequence_key:= stringlib.stringcleanspaces(stringlib.stringtouppercase(left.sequence_key)); 
		self.state_origin:= stringlib.stringcleanspaces(stringlib.stringtouppercase(left.state_origin)); 
		self.source_code:= stringlib.stringcleanspaces(stringlib.stringtouppercase(left.source_code)); 
		self.dppa_flag:= stringlib.stringcleanspaces(stringlib.stringtouppercase(left.dppa_flag)); 
		self.orig_name:= stringlib.stringcleanspaces(stringlib.stringtouppercase(left.orig_name)); 
		self.orig_name_type_code:= stringlib.stringcleanspaces(stringlib.stringtouppercase(left.orig_name_type_code)); 
		self.orig_name_type_description:= stringlib.stringcleanspaces(stringlib.stringtouppercase(left.orig_name_type_description)); 
		self.orig_name_first:= stringlib.stringcleanspaces(stringlib.stringtouppercase(left.orig_name_first)); 
		self.orig_name_middle:= stringlib.stringcleanspaces(stringlib.stringtouppercase(left.orig_name_middle)); 
		self.orig_name_last:= stringlib.stringcleanspaces(stringlib.stringtouppercase(left.orig_name_last)); 
		self.orig_name_suffix:= stringlib.stringcleanspaces(stringlib.stringtouppercase(left.orig_name_suffix)); 
		self.orig_address_1:= stringlib.stringcleanspaces(stringlib.stringtouppercase(left.orig_address_1)); 
		self.orig_address_2:= stringlib.stringcleanspaces(stringlib.stringtouppercase(left.orig_address_2)); 
		self.orig_city:= stringlib.stringcleanspaces(stringlib.stringtouppercase(left.orig_city)); 
		self.orig_state:= stringlib.stringcleanspaces(stringlib.stringtouppercase(left.orig_state)); 
		self.orig_zip:= stringlib.stringcleanspaces(stringlib.stringtouppercase(left.orig_zip)); 
		self.orig_fips:= stringlib.stringcleanspaces(stringlib.stringtouppercase(left.orig_fips)); 
	  self.orig_province:= stringlib.stringcleanspaces(stringlib.stringtouppercase(left.orig_province )); 
	  self.orig_country:= stringlib.stringcleanspaces(stringlib.stringtouppercase(left.orig_country  )); 
		self.dob := stringlib.stringcleanspaces(stringlib.stringtouppercase(left.dob)); 
		self.orig_ssn:= stringlib.stringcleanspaces(stringlib.stringtouppercase(left.orig_ssn)); 
		self.orig_fein:= stringlib.stringcleanspaces(stringlib.stringtouppercase(left.orig_fein)); 
		self.gender:= stringlib.stringcleanspaces(stringlib.stringtouppercase(left.gender)); 
		self.phone_1:= stringlib.stringcleanspaces(stringlib.stringtouppercase(left.phone_1)); 
		self.phone_2:= stringlib.stringcleanspaces(stringlib.stringtouppercase(left.phone_2)); 
		
		self := left)),watercraft_key,
                   sequence_key,
                   state_origin,source_code,dppa_flag,orig_name,orig_name_type_code,
                   orig_name_type_description,orig_name_first,orig_name_middle,orig_name_last,
                   orig_name_suffix,orig_address_1,orig_address_2,orig_city,orig_state,
                   orig_zip,orig_fips,orig_province,orig_country,dob,orig_ssn,orig_fein,
                   gender,phone_1,phone_2,-date_last_seen,local ), except  date_first_seen, date_last_seen,date_vendor_first_reported,
                   date_vendor_last_reported,lot,name_cleaning_score,title,local); 
		
Add_puid := project(search_dedup , transform(Watercraft.Layout_Watercraft_Search_Base, 
		
		self.persistent_record_id := hash64(trim(left.watercraft_key,left,right) + ','+
																		trim(left.sequence_key,left,right)+ ','+
																		trim(left.state_origin,left,right)+ ','+
																		trim(left.source_code,left,right)+ ','+
																		trim(left.dppa_flag,left,right)+ ','+
																		trim(left.orig_name,left,right)+ ','+
																		trim(left.orig_name_type_code,left,right)+ ','+
																		trim(left.orig_name_type_description,left,right)+ ','+
																		trim(left.orig_name_first,left,right)+ ','+
																		trim(left.orig_name_middle,left,right)+ ','+
																		trim(left.orig_name_last,left,right)+ ','+
																		trim(left.orig_name_suffix,left,right)+ ','+
																		trim(left.orig_address_1,left,right)+ ','+
																		trim(left.orig_address_2,left,right)+ ','+
																		trim(left.orig_city,left,right)+ ','+
																		trim(left.orig_state,left,right)+ ','+
																		trim(left.orig_zip,left,right)+ ','+
																		trim(left.orig_fips,left,right)+ ','+
																		trim(left.orig_province,left,right )+ ','+
																		trim(left.orig_country,left,right  )+ ','+
																		trim(left.dob,left,right)+ ','+
																		trim(left.orig_ssn,left,right)+ ','+
																		trim(left.orig_fein,left,right)+ ','+
																		trim(left.gender,left,right)+ ','+
																		trim(left.phone_1,left,right)+ ','+
																		trim(left.phone_2,left,right)); 

			self := left)); 

									
export Out_Search_Base_Dev := Add_puid;