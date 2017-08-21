IMPORT Business_Header, ut;
export fAs_Business_Header_PA(dataset(layouts.base.PA) pInput) :=
function

	PA_base := pInput;

	//////////////////////////////////////////////////////////////////////////////////////////////
	// -- Add unique record id to PA file
	//////////////////////////////////////////////////////////////////////////////////////////////
	Layout_PA_Local := 
	record
		UNSIGNED6 record_id := 0;
		layouts.base.PA;
	end;

	Layout_PA_Local AddRecordID(layouts.base.PA L) := 
	transform
		self := L;
		self.record_id := 0;
	end;

	PA_Init := PROJECT(PA_base, AddRecordID(LEFT));

	ut.MAC_Sequence_Records(PA_Init, record_id, PA_Seq);

	//////////////////////////////////////////////////////////////////////////////////////////////
	// -- Map to BH format
	//////////////////////////////////////////////////////////////////////////////////////////////
	bh_layout := business_header.Layout_Business_Header_New;

	bh_layout Translate_PA_To_BHF(Layout_PA_Local L) := 
	transform
		company_name :=		if(l.clean_person_name1.lname = '',trim(l.rawfields.Licensee_NAME_1,left,right), '') + ' '
										+ if(l.clean_person_name2.lname = '',trim(l.rawfields.Licensee_NAME_2,left,right), '') + ' '
										+ if(l.clean_person_name3.lname = '',trim(l.rawfields.Licensee_NAME_3,left,right), '')
										;
									
	
	
		SELF.source										:= Source_Codes.PA								;
		SELF.source_group 						:= trim(l.rawfields.License_Identification_Number,left,right);
		SELF.group1_id 								:= L.record_id										;
		SELF.vl_id 								    := self.source_group							;
		SELF.vendor_id 								:= self.source_group							;
		SELF.dt_first_seen						:= l.dt_first_seen								;
		SELF.dt_last_seen							:= l.dt_last_seen									;
		SELF.dt_vendor_first_reported	:= L.dt_vendor_first_reported			;
		SELF.dt_vendor_last_reported	:= L.dt_vendor_last_reported			;
		SELF.company_name							:= trim(company_name,left,right)	;
		SELF.prim_range								:= L.Clean_Address.prim_range			;
		SELF.predir										:= L.Clean_Address.predir					;
		SELF.prim_name								:= L.Clean_Address.prim_name			;
		SELF.addr_suffix							:= L.Clean_Address.addr_suffix		;
		SELF.postdir									:= L.Clean_Address.postdir				;
		SELF.unit_desig								:= L.Clean_Address.unit_desig			;
		SELF.sec_range								:= L.Clean_Address.sec_range			;
		SELF.city											:= L.Clean_Address.v_city_name		;
		SELF.state										:= L.Clean_Address.st							;
		SELF.zip											:= (UNSIGNED3)L.Clean_Address.zip	;
		SELF.zip4											:= (UNSIGNED2)L.Clean_Address.zip4;
		SELF.county										:= L.Clean_Address.fips_county		;
		SELF.msa											:= L.Clean_Address.msa						;
		SELF.geo_lat									:= L.Clean_Address.geo_lat				;				
		SELF.geo_long									:= L.Clean_Address.geo_long				;
		SELF.phone										:= 0															;                                                       
		SELF.phone_score 							:= 0															;
		SELF.fein 										:= 0															;
		SELF.current									:= TRUE														;
		SELF.dppa 										:= FALSE													;
	end;

	from_PA_proj := project(PA_Seq, Translate_PA_To_BHF(LEFT));

	//////////////////////////////////////////////////////////////////////////////////////////////
	// -- Do standard BH rollup with no filter, group1_id rollup, or fixing the company name
	//////////////////////////////////////////////////////////////////////////////////////////////
//	PA_clean_rollup := Business_Header.As_Business_Header_Function(from_PA_proj, false, false, false);
	PA_clean_rollup := from_PA_proj(company_name != '');

	return PA_clean_rollup;

end;
