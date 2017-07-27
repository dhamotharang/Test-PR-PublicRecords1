IMPORT Business_Header, ut;
export fAs_Business_Header(

	dataset(layouts.base.Organizations) pInput	= files().base.Organizations.qa

) :=
function

	max_size := _Dataset().max_record_size;

	Organizations_base := pInput;

	//////////////////////////////////////////////////////////////////////////////////////////////
	// -- Add unique record id to Organizations file
	//////////////////////////////////////////////////////////////////////////////////////////////
	Layout_Organizations_Local := 
	record, maxlength(max_size)
		UNSIGNED6 record_id := 0;
		layouts.base.Organizations;
	end;

	Layout_Organizations_Local AddRecordID(layouts.base.Organizations L,unsigned8 cnt) := 
	transform
		self := L;
		self.record_id :=cnt;
	end;

	Organizations_Init := PROJECT(Organizations_base, AddRecordID(LEFT,counter));

	//////////////////////////////////////////////////////////////////////////////////////////////
	// -- Map to BH format
	//////////////////////////////////////////////////////////////////////////////////////////////
	bh_layout := business_header.Layout_Business_Header_New;

	bh_layout Translate_Organizations_To_BHF(Layout_Organizations_Local L, unsigned2 cnt) := 
	transform
		
		SELF.source										:= Source_Codes.Organizations;
		SELF.source_group 						:= trim(L.rawfields.ORG_AUDIT_FIRMNO,left,right);
		SELF.group1_id 								:= L.record_id;
		SELF.vl_id    								:= self.source_group;
		SELF.vendor_id 								:= self.source_group;
		SELF.dt_first_seen						:= l.dt_first_seen;
		SELF.dt_last_seen							:= l.dt_last_seen;
		SELF.dt_vendor_first_reported	:= L.dt_vendor_first_reported;
		SELF.dt_vendor_last_reported	:= L.dt_vendor_last_reported;
		SELF.company_name							:= l.rawfields.NAME_ORG_NAME;
		SELF.prim_range								:= choose(cnt	,L.Clean_location_address.prim_range			,L.Clean_mailing_address.prim_range				);
		SELF.predir										:= choose(cnt	,L.Clean_location_address.predir					,L.Clean_mailing_address.predir						);
		SELF.prim_name								:= choose(cnt	,L.Clean_location_address.prim_name				,L.Clean_mailing_address.prim_name				);
		SELF.addr_suffix							:= choose(cnt	,L.Clean_location_address.addr_suffix			,L.Clean_mailing_address.addr_suffix			);
		SELF.postdir									:= choose(cnt	,L.Clean_location_address.postdir					,L.Clean_mailing_address.postdir					);
		SELF.unit_desig								:= choose(cnt	,L.Clean_location_address.unit_desig			,L.Clean_mailing_address.unit_desig				);
		SELF.sec_range								:= choose(cnt	,L.Clean_location_address.sec_range				,L.Clean_mailing_address.sec_range				);
		SELF.city											:= choose(cnt	,L.Clean_location_address.v_city_name			,L.Clean_mailing_address.v_city_name			);
		SELF.state										:= choose(cnt	,L.Clean_location_address.st							,L.Clean_mailing_address.st								);
		SELF.zip											:= choose(cnt	,(UNSIGNED3)L.Clean_location_address.zip	,(UNSIGNED3)L.Clean_mailing_address.zip		);
		SELF.zip4											:= choose(cnt	,(UNSIGNED2)L.Clean_location_address.zip4	,(UNSIGNED2)L.Clean_mailing_address.zip4	);
		SELF.county										:= choose(cnt	,L.Clean_location_address.fips_county			,L.Clean_mailing_address.fips_county			);
		SELF.msa											:= choose(cnt	,L.Clean_location_address.msa							,L.Clean_mailing_address.msa							);
		SELF.geo_lat									:= choose(cnt	,L.Clean_location_address.geo_lat					,L.Clean_mailing_address.geo_lat					);				
		SELF.geo_long									:= choose(cnt	,L.Clean_location_address.geo_long				,L.Clean_mailing_address.geo_long					);
		SELF.phone										:= (UNSIGNED6)l.clean_phones.CONTACT_PHONES_PHONE_NUMBER;                                                                                        
		SELF.phone_score 							:= IF((UNSIGNED6)self.Phone = 0, 0, 1);
		SELF.fein 										:= 0;
		SELF.current									:= TRUE;
		SELF.dppa 										:= FALSE;
		self.rawaid										:= choose(cnt,L.RawAid_Location,L.RawAid_mailing);
	end;

	from_Organizations_proj := normalize(Organizations_Init, 2,Translate_Organizations_To_BHF(LEFT,counter));
	from_Organizations_dedup := dedup(
									sort(
										distribute(from_Organizations_proj
										,hash(vendor_id, company_name,prim_range, prim_name, city,state,zip, phone))
										,hash(vendor_id, company_name,prim_range, prim_name, city,state,zip, phone), local)
										,hash(vendor_id, company_name,prim_range, prim_name, city,state,zip, phone), local);

	//////////////////////////////////////////////////////////////////////////////////////////////
	// -- Do standard BH rollup with no filter, group1_id rollup, or fixing the company name
	//////////////////////////////////////////////////////////////////////////////////////////////
//	Organizations_clean_rollup := Business_Header.As_Business_Header_Function(from_Organizations_proj, false, false, false);
	Organizations_clean_rollup := from_Organizations_dedup(company_name != ''
																												,	(
																															 prim_name	!= ''
																														or city				!= ''
																														or state			!= ''
																														or zip				!= 0
																													)
																													or phone != 0);

	return Organizations_clean_rollup;

end;
