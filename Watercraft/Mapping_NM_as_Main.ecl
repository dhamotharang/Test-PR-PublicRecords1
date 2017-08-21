import watercraft;
Watercraft.Macro_Clean_Hull_ID(watercraft.file_NM_clean_in, watercraft.Layout_NM_clean_in,hull_clean_in)
watercraft.Macro_Is_hull_id_in_MIC(hull_clean_in, watercraft.Layout_NM_clean_in, wDatasetwithflag)


watercraft.Layout_Watercraft_Main_Base main_mapping_format(wDatasetwithflag L) := transform


    self.watercraft_key				        :=	if(trim(L.YEAR, left, right) >= '1972' and length(trim(L.HULL_ID,left, right)) = 12 and L.is_hull_id_in_MIC, 
	                                            trim(L.HULL_ID, left, right), 
																							
																					if(trim(L.HULL_ID, left, right) <> '' ,
	                                            (trim(L.HULL_ID, left, right) + trim(L.MAKE, left, right) + trim(L.YEAR, left, right))[1..30],
																							
																					IF(trim(L.HULL_ID,left,right)='' and trim(L.NAME,left,right)='',
																					     trim(L.MAKE,left, right) + trim(L.YEAR, left, right) + trim(L.REG_NUM, left, right)[1..30],
 
	                                            (trim(L.MAKE, left, right) + trim(L.YEAR, left, right) + trim(L.NAME, left, right))[1..30])));
	self.sequence_key				                :=	trim(L.REG_DATE, left, right);
	self.watercraft_id						          :=	'';
	self.state_origin						            :=	'NM';
	self.source_code						            :=	'AW';
	self.st_registration					          :=	trim(L.STATE, left, right);
	self.county_registration				        :=	L.COUNTY;
	self.registration_number				        :=	trim(L.REG_NUM, left, right);
	self.hull_number						            :=	L.hull_id;
	self.propulsion_code					          :=	'';
	self.propulsion_description				      :=	L.PROP;
	self.vehicle_type_Code					        :=	'';
	self.vehicle_type_Description			      :=	L.VEH_TYPE;
	self.fuel_code							            :=	'';
	self.fuel_description					          :=	L.FUEL;
	self.hull_type_code						          :=	'';
	self.hull_type_description				      :=	L.HULL;
	self.use_code							              :=	'';
	self.use_description					          :=	L.USE_1;
	self.watercraft_length					        :=	L.TOTAL_INCH;
	self.model_year							            :=	if(L.YEAR <> '0', L.YEAR, '');
	self.watercraft_name					          :=	L.NAME;
	self.watercraft_class_code				      :=	'';
	self.watercraft_class_description		    :=	'';
	self.watercraft_make_code				        :=	'';
	self.watercraft_make_description		    :=	L.MAKE;
	self.watercraft_model_code				      :=	'';
	self.watercraft_model_description		    :=	L.MODEL;
	self.watercraft_width					          :=	L.BEAM_WIDTH;
	self.watercraft_weight					        :=	'';
	self.watercraft_color_1_code			      :=	'';
	self.watercraft_color_1_description		  :=	'';
	self.watercraft_color_2_code			      :=	'';
	self.watercraft_color_2_description		  :=	'';
	self.watercraft_toilet_code				      :=	'';
	self.watercraft_toilet_description		  :=	'';
	self.watercraft_number_of_engines		    :=	'';
	self.watercraft_hp_1					          :=	L.HORSE_POWER;
	self.watercraft_hp_2					          :=	'';
	self.watercraft_hp_3					          :=	'';
	self.engine_number_1					          :=	L.ENGINE_NUMBER;
	self.engine_number_2					          :=	'';
	self.engine_number_3					          :=	'';
	self.engine_make_1						          :=	'';
	self.engine_make_2						          :=	'';
	self.engine_make_3						          :=	'';
	self.engine_model_1						          :=	'';
	self.engine_model_2						          :=	'';
	self.engine_model_3						          :=	'';
	self.engine_year_1						          :=	L.FIRST_YEAR_REG;
	self.engine_year_2						          :=	'';
	self.engine_year_3						          :=	'';
	self.coast_guard_documented_flag		    :=	'';
	self.coast_guard_number					        :=	'';
	self.registration_date					        :=	L.REG_DATE;
	self.registration_expiration_date		    :=	'';
	self.registration_status_code			      :=	l.REG_STATUS;
	self.registration_status_description	  :=	'';
	self.registration_status_date			      :=	'';
	self.registration_renewal_date			    :=	'';
	self.decal_number						            :=	'';
	self.transaction_type_code				      :=	L.LAST_TRANS_CODE;
	self.transaction_type_description		    :=	'';
	self.title_state						            :=	'';
	self.title_status_code					        :=	L.TITLE_STATUS;
	self.title_status_description			      :=	'';
	self.title_number						            :=	intformat((integer) L.TITLE_NUMBER,15,0);
	self.title_issue_date					          :=	L.ISSUE_DATE;
	self.title_type_code					          :=	'';
	self.title_type_description				      :=	'';
	self.additional_owner_count				      :=	'';
	self.lien_1_indicator					          :=	'';
	self.lien_1_name						            :=	L.LIEN_NAME;
	self.lien_1_date						            :=	L.LIEN_MATURITY_DATE;
	self.lien_1_address_1					          :=	L.LIEN_ADDRESS;
	self.lien_1_address_2					          :=	'';
	self.lien_1_city						            :=	L.LIEN_CITY;
	self.lien_1_state						            :=	L.LIEN_STATE;
	self.lien_1_zip							            :=	L.LIEN_ZIP;
	self.lien_2_indicator					          :=	'';
	self.lien_2_name						            :=	L.LIEN_NAME2 ;
	self.lien_2_date						            :=	L.LIEN_MATURITY_DATE2;
	self.lien_2_address_1					          :=	L.LIEN_ADDRESS2;
	self.lien_2_address_2					          :=	'';
	self.lien_2_city						            :=	L.LIEN_CITY2;
	self.lien_2_state						            :=	L.LIEN_STATE2;
	self.lien_2_zip							            :=	L.LIEN_ZIP2;
	self.state_purchased					          :=	'';
	self.purchase_date						          :=	L.PURCHASE_DATE;
	self.dealer								              :=	L.DEALER_NUMBER;
	self.purchase_price						          :=	L.PURCHASE_PRICE;
	self.new_used_flag						          :=	'';
	self.watercraft_status_code				      :=	'';
	self.watercraft_status_description		  :=	'';
	self.history_flag						            :=	'';
	self.coastguard_flag					          :=	'';
  
  end;



export Mapping_NM_as_Main := project(wDatasetwithflag, main_mapping_format(left));

























