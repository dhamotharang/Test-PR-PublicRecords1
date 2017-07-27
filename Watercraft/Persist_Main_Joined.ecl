import Watercraft_UMF, ut, AK_Comm_Fish_Vessels;

dJoined		:=	Watercraft.Mapping_AK_as_Main
			+	Watercraft.Mapping_AL_as_Main
			+	Watercraft.Mapping_AR_as_Main
			+	Watercraft.Mapping_AZ_as_Main
			+	Watercraft.Mapping_CO_as_Main
			+	Watercraft.Mapping_CT_as_Main
			+	Watercraft.Mapping_GA_as_Main
			+	Watercraft.Mapping_IA_as_Main_pre20071011
			+	Watercraft.Mapping_IA_as_Main
			+	Watercraft.Mapping_IL_as_Main
			+	Watercraft.Mapping_KS_as_Main
			+	Watercraft.Mapping_MD_as_Main
			+	Watercraft.Mapping_MI_as_Main
			+	Watercraft.Mapping_NV_as_Main
			+	Watercraft.Mapping_WI_as_Main
			+	Watercraft.Mapping_WV_as_Main
			+	Watercraft.Mapping_MA_as_Main
			+	Watercraft.Mapping_ME_as_Main
			+	Watercraft.Mapping_ME_as_Main_pre20060330
			+	Watercraft.Mapping_ME_as_Main_pre20080415
			+	Watercraft.Mapping_MS_as_Main
			+	Watercraft.Mapping_MT_as_Main
			+	Watercraft.Mapping_NC_as_Main
			+	Watercraft.Mapping_ND_as_Main
			+	Watercraft.Mapping_NE_as_Main
			+	Watercraft.Mapping_OH_as_Main
			+	Watercraft.Mapping_VA_as_Main
			+	Watercraft.Mapping_WY_as_Main
			+	Watercraft.Mapping_MN_as_Main
			+	Watercraft.Mapping_TX_as_Main
			+	Watercraft.Mapping_TX_as_Main_pre20060330
			+	Watercraft.Mapping_NY_as_Main
			+	Watercraft.Mapping_NH_as_Main
			+	Watercraft.Mapping_TN_as_Main
			+	Watercraft.Mapping_SC_as_Main
			+	Watercraft.Mapping_UT_as_Main
			+	Watercraft.Mapping_CG_as_Main_pre20080415
			+	Watercraft.Mapping_CG_as_Main
			+	Watercraft.Mapping_FL_as_Main
			+	Watercraft.Mapping_MO_as_Main
			+	Watercraft.Mapping_KY_as_Main
			+   Watercraft.Mapping_KY_infolink_main
			+	Watercraft.Mapping_OR_as_Main_pre20080415
			+	Watercraft.Mapping_OR_as_Main
			+   AK_Comm_Fish_Vessels.Mapping_Watercraft_Main_Base_AK_Comm_Fishing_Vessels
			+	Watercraft.Mapping_WY_new_as_Main
			+Watercraft.Mapping_WA_as_Main
			;

dJoinedDist		:=	distribute(dJoined,hash(state_origin,watercraft_key));
dJoinedSort		:=	sort(dJoinedDist,state_origin,
                                     source_code,
									 watercraft_key,
									 -sequence_key,
									 st_registration,
									 -county_registration,
									 hull_number,
									 watercraft_name,
									 model_year,
									 -registration_date,
									 registration_status_code,
									 -registration_expiration_date,
									 -registration_status_date,
									 -registration_renewal_date,
									 -title_issue_date,
									 -lien_1_name,
									 watercraft_length,
									 local
						);

dJoinedDedup	:=	dedup(dJoinedSort,state_origin,
                                      source_code,
									  watercraft_key,
									  sequence_key,
									  st_registration,
									  county_registration,
									  hull_number,
									  watercraft_name,
									  model_year,
									  //registration_date,
									  registration_status_code,
									  registration_expiration_date,
									  registration_status_date,
									  registration_renewal_date,
									  title_issue_date,
									  lien_1_name,
									  local
						 );
						 
dJoinedGrouped	:=	group(dJoinedDedup,state_origin,source_code,watercraft_key,local);

Watercraft.Layout_Watercraft_Main_Base	tSetHistoryFlag(dJoinedGrouped pLeft, dJoinedGrouped pRight)
 :=
  transform
	self.history_flag	:=	if((unsigned8)pRight.registration_expiration_date=0,
							   'U',
							   if((unsigned8)pRight.registration_expiration_date <> 0 and pRight.registration_expiration_date[1..6] < ut.GetDate[1..6],
								  'E',
								  if(pLeft.state_origin='',
									 ' ',
									 'H'
									)
								 )
							  );
	self				:=	pRight;
  end
 ;

dJoinedHistory	:=	iterate(dJoinedGrouped,tSetHistoryFlag(left,right));
dJoinedUnGrouped:=	group(dJoinedHistory);

dJoined_desc_clean := watercraft.fn_patch_main_file(dJoinedUnGrouped);

// Add persistent record id

Out_main:= project(dedup(dJoined_desc_clean,all) , transform(watercraft.Layout_Watercraft_Main_Base, 

self.persistent_record_id := hash64(trim(left.watercraft_key,left,right)+','+
trim(left.sequence_key,left,right)+','+
trim(left.watercraft_id,left,right)+','+
trim(left.state_origin,left,right)+','+
trim(left.source_code,left,right)+','+
trim(left.st_registration,left,right)+','+
trim(left.county_registration,left,right)+','+
trim(left.registration_number,left,right)+','+
trim(left.hull_number,left,right)+','+
trim(left.propulsion_code,left,right)+','+
trim(left.propulsion_description,left,right)+','+
trim(left.vehicle_type_code,left,right)+','+
trim(left.vehicle_type_description,left,right)+','+
trim(left.fuel_code,left,right)+','+
trim(left.fuel_description,left,right)+','+
trim(left.hull_type_code,left,right)+','+
trim(left.hull_type_description,left,right)+','+
trim(left.use_code,left,right)+','+
trim(left.use_description,left,right)+','+
trim(left.model_year,left,right)+','+
trim(left.watercraft_name,left,right)+','+
trim(left.watercraft_class_code,left,right)+','+
trim(left.watercraft_class_description,left,right)+','+
trim(left.watercraft_make_code,left,right)+','+
trim(left.watercraft_make_description,left,right)+','+
trim(left.watercraft_model_code,left,right)+','+
trim(left.watercraft_model_description,left,right)+','+
trim(left.watercraft_length,left,right)+','+
trim(left.watercraft_width,left,right)+','+
trim(left.watercraft_weight,left,right)+','+
trim(left.watercraft_color_1_code,left,right)+','+
trim(left.watercraft_color_1_description,left,right)+','+
trim(left.watercraft_color_2_code,left,right)+','+
trim(left.watercraft_color_2_description,left,right)+','+
trim(left.watercraft_toilet_code,left,right)+','+
trim(left.watercraft_toilet_description,left,right)+','+
trim(left.watercraft_number_of_engines,left,right)+','+
trim(left.watercraft_hp_1,left,right)+','+
trim(left.watercraft_hp_2,left,right)+','+
trim(left.watercraft_hp_3,left,right)+','+
		trim(left.engine_number_1,left,right)+','+
		trim(left.engine_number_2,left,right)+','+
		trim(left.engine_number_3,left,right)+','+
		trim(left.engine_make_1,left,right)+','+
		trim(left.engine_make_2,left,right)+','+
		trim(left.engine_make_3,left,right)+','+
		trim(left.engine_model_1,left,right)+','+
		trim(left.engine_model_2,left,right)+','+
		trim(left.engine_model_3,left,right)+','+
	trim(left.engine_year_1,left,right)+','+
	trim(left.engine_year_2,left,right)+','+
	trim(left.engine_year_3,left,right)+','+
	trim(left.coast_guard_documented_flag,left,right)+','+
	trim(left.coast_guard_number,left,right)+','+
	trim(left.registration_date,left,right)+','+
	trim(left.registration_expiration_date,left,right)+','+
	trim(left.registration_status_code,left,right)+','+
	trim(left.registration_status_description,left,right)+','+
	trim(left.registration_status_date,left,right)+','+
	trim(left.registration_renewal_date,left,right)+','+
		trim(left.decal_number,left,right)+','+
	trim(left.transaction_type_code,left,right)+','+
	trim(left.transaction_type_description,left,right)+','+
	trim(left.title_state,left,right)+','+
	trim(left.title_status_code,left,right)+','+
	trim(left.title_status_description,left,right)+','+
	trim(left.title_number,left,right)+','+
	trim(left.title_issue_date,left,right)+','+
	trim(left.title_type_code,left,right)+','+
	trim(left.title_type_description,left,right)+','+
	trim(left.additional_owner_count,left,right)+','+
	trim(left.lien_1_indicator,left,right)+','+
	trim(left.lien_1_name,left,right)+','+
	trim(left.lien_1_date,left,right)+','+
	trim(left.lien_1_address_1,left,right)+','+
	trim(left.lien_1_address_2,left,right)+','+
	trim(left.lien_1_city,left,right)+','+
	trim(left.lien_1_state,left,right)+','+
	trim(left.lien_1_zip,left,right)+','+
	trim(left.lien_2_indicator,left,right)+','+
	trim(left.lien_2_name,left,right)+','+
	trim(left.lien_2_date,left,right)+','+
	trim(left.lien_2_address_1,left,right)+','+
	trim(left.lien_2_address_2,left,right)+','+
	trim(left.lien_2_city,left,right)+','+
	trim(left.lien_2_state,left,right)+','+
	trim(left.lien_2_zip,left,right)+','+
	trim(left.state_purchased,left,right)+','+
	trim(left.purchase_date,left,right)+','+
	trim(left.dealer,left,right)+','+
	trim(left.purchase_price,left,right)+','+
	trim(left.new_used_flag,left,right)+','+
	trim(left.watercraft_status_code,left,right)+','+
	trim(left.watercraft_status_description,left,right)+','+
	trim(left.history_flag,left,right)+','+
	trim(left.coastguard_flag,left,right)+','+
	trim(left.signatory ,left,right));
	
	self:= left));
	
export Persist_Main_Joined
 :=	Out_main
 :	persist('persist::Watercraft_Main_Joined')
 ;