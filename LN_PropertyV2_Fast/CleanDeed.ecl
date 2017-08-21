import ut,LN_PropertyV2; 

EXPORT CleanDeed(dataset(LN_PropertyV2.layout_deed_mortgage_common_model_base) deed, boolean isFast) := FUNCTION

keyPrefix := if (isFast, 'property_fast', 'ln_propertyv2');

ut.mac_suppress_by_phonetype(deed, phone_number,  state, deed_phone_suppressed,false);

ln_propertyv2.layout_deed_mortgage_common_model_base tRemoveGarbage(deed_phone_suppressed pInput)	:=
transform
	self.apnt_or_pin_number							:=	regexreplace('[^ -~]+', pInput.apnt_or_pin_number, '');
	self.name1													:=	regexreplace('[^ -~]+', pInput.name1, '');
	self.name2													:=	regexreplace('[^ -~]+', pInput.name2, '');
	self.mailing_care_of								:=	regexreplace('[^ -~]+', pInput.mailing_care_of, '');
	self.mailing_street									:=	regexreplace('[^ -~]+', pInput.mailing_street, '');
	self.mailing_csz										:=	regexreplace('[^ -~]+', pInput.mailing_csz, '');
	self.seller1												:=	regexreplace('[^ -~]+', pInput.seller1, '');
	self.property_full_street_address		:=	regexreplace('[^ -~]+', pInput.property_full_street_address, '');
	self.property_address_citystatezip	:=	regexreplace('[^ -~]+', pInput.property_address_citystatezip, '');
	self.legal_brief_description				:=	regexreplace('[^ -~]+', pInput.legal_brief_description, '');
	self.document_type_code							:=	regexreplace('[^ -~]+', pInput.document_type_code, '');
	self																:=	pInput;
end;

dFixDeeds	:=	project(deed_phone_suppressed, tRemoveGarbage(left));

file_deed_building := dFixDeeds(ln_fares_id not in LN_PropertyV2.Suppress_LNFaresID);// : persist('~thor_data400::persist::'+keyPrefix+'::deed_phone_suppression_');

RETURN file_deed_building;

END;