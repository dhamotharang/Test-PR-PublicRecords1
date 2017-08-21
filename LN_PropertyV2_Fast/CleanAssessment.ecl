import ut,LN_PropertyV2;

EXPORT CleanAssessment(dataset(LN_PropertyV2.layout_property_common_model_base) assessment,boolean isFast = false) := FUNCTION

keyPrefix := if (isFast,'property_fast','ln_propertyv2');

ut.mac_suppress_by_phonetype(assessment,assessee_phone_number,state_code,assesor_phone_suppressed,false);

ln_propertyv2.layout_property_common_model_base	tRemoveGarbageChars(assesor_phone_suppressed pInput)	:=
transform
	self.apna_or_pin_number								:=	regexreplace('[^ -~]+', pInput.apna_or_pin_number, '');
	self.assessee_name										:=	regexreplace('[^ -~]+', pInput.assessee_name, '');
	self.second_assessee_name							:=	regexreplace('[^ -~]+', pInput.second_assessee_name, '');
	self.mailing_care_of_name							:=	regexreplace('[^ -~]+', pInput.mailing_care_of_name, '');
	self.mailing_full_street_address			:=	regexreplace('[^ -~]+', pInput.mailing_full_street_address, '');
	self.mailing_city_state_zip						:=	regexreplace('[^ -~]+', pInput.mailing_city_state_zip, '');
	self.property_full_street_address			:=	regexreplace('[^ -~]+', pInput.property_full_street_address, '');
	self.property_unit_number							:=	regexreplace('[^ -~]+', pInput.property_unit_number, '');
	self.legal_lot_number									:=	regexreplace('[^ -~]+', pInput.legal_lot_number, '');
	self.legal_block											:=	regexreplace('[^ -~]+', pInput.legal_block, '');
	self.legal_city_municipality_township	:=	regexreplace('[^ -~]+', pInput.legal_city_municipality_township, '');
	self.legal_subdivision_name						:=	regexreplace('[^ -~]+', pInput.legal_subdivision_name, '');
	self.legal_brief_description					:=	regexreplace('[^ -~]+', pInput.legal_brief_description, '');
	self.legal_assessor_map_ref						:=	regexreplace('[^ -~]+', pInput.legal_assessor_map_ref, '');
	self.county_land_use_description			:=	regexreplace('[^ -~]+', pInput.county_land_use_description, '');
	self.zoning														:=	regexreplace('[^ -~]+', pInput.zoning, '');
	self.document_type										:=	regexreplace('[^ -~]+', pInput.document_type, '');
	self.mortgage_lender_name							:=	regexreplace('[^ -~]+', pInput.mortgage_lender_name, '');
	self.air_conditioning_type_code				:=	regexreplace('[^ -~]+', pInput.air_conditioning_type_code, '');
	self.comments													:=	regexreplace('[^ -~]+', pInput.comments, '');
	self.condo_project_or_building_name		:=	regexreplace('^[;]|[;]$',trim(pInput.condo_project_or_building_name,left,right),'');
	self.record_type_code						      :=	regexreplace('[^ -~]+', pInput.record_type_code, '');
  self.owner_occupied							      :=	regexreplace('[^ -~]+', pInput.owner_occupied, '');
  self.tax_exemption1_code				      :=	regexreplace('[^ -~]+', pInput.tax_exemption1_code, '');
  self.lot_size								          :=	regexreplace('[^ -~]+', pInput.lot_size, '');
  self.lot_size_acres							      :=	regexreplace('[^ -~]+', pInput.lot_size_acres, '');
  self.land_dimensions						      :=	regexreplace('[^ -~]+', pInput.land_dimensions, '');
  self.building_area                    :=  regexreplace('[^ -~]+', pInput.building_area, '');            
  self.building_area_indicator          :=  regexreplace('[^ -~]+', pInput.building_area_indicator, '');  
  self.building_area1                   :=  regexreplace('[^ -~]+', pInput.building_area1, '');           
  self.building_area1_indicator         :=  regexreplace('[^ -~]+', pInput.building_area1_indicator, ''); 
  self.building_area2                   :=  regexreplace('[^ -~]+', pInput.building_area2, '');           
  self.building_area2_indicator         :=  regexreplace('[^ -~]+', pInput.building_area2_indicator, ''); 
  self.building_area3                   :=  regexreplace('[^ -~]+', pInput.building_area3, '');           
  self.building_area3_indicator         :=  regexreplace('[^ -~]+', pInput.building_area3_indicator, ''); 
  self.building_area4                   :=  regexreplace('[^ -~]+', pInput.building_area4, '');           
  self.building_area4_indicator         :=  regexreplace('[^ -~]+', pInput.building_area4_indicator, ''); 
  self.building_area5                   :=  regexreplace('[^ -~]+', pInput.building_area5, '');           
  self.building_area5_indicator         :=  regexreplace('[^ -~]+', pInput.building_area5_indicator, ''); 
  self.building_area6                   :=  regexreplace('[^ -~]+', pInput.building_area6, '');           
  self.building_area6_indicator         :=  regexreplace('[^ -~]+', pInput.building_area6_indicator, ''); 
  self.building_area7                   :=  regexreplace('[^ -~]+', pInput.building_area7, '');           
  self.year_built                       :=  regexreplace('[^ -~]+', pInput.year_built, ''); 
  self.building_area7_indicator         :=  regexreplace('[^ -~]+', pInput.building_area7_indicator, ''); 
  self.garage_type_code					        :=	regexreplace('[^ -~]+', pInput.garage_type_code, '');
  self.parking_no_of_cars               :=  regexreplace('[^ -~]+', pInput.parking_no_of_cars, ''); 
  self.second_assessee_name_indicator   :=  regexreplace('[^ -~]+', pInput.second_assessee_name_indicator, ''); 
  self.mail_care_of_name_indicator      :=  regexreplace('[^ -~]+', pInput.mail_care_of_name_indicator, ''); 

	self																	:=	pInput;
end;

dFixAsses	:=	project(assesor_phone_suppressed, tRemoveGarbageChars(left));

file_assessment_building := dFixAsses(ln_fares_id not in LN_PropertyV2.Suppress_LNFaresID);// : persist('~thor_data400::persist::'+keyPrefix+'::assessor_phone_suppression_');

return file_assessment_building ;

END;