IMPORT Business_Header, ut;
export fAs_Business_Header_IN(
	
	dataset(layouts.base.IN) pInput = files().base.IN.qa

) :=
function

	IN_base := pInput;

	//////////////////////////////////////////////////////////////////////////////////////////////
	// -- Add unique record id to IN file
	//////////////////////////////////////////////////////////////////////////////////////////////
	Layout_IN_Local := 
	record
		UNSIGNED6 record_id := 0;
		layouts.base.IN;
	end;

	Layout_IN_Local AddRecordID(layouts.base.IN L) := 
	transform
		self := L;
		self.record_id := 0;
	end;

	IN_Init := PROJECT(IN_base, AddRecordID(LEFT));

	ut.MAC_Sequence_Records(IN_Init, record_id, IN_Seq);

	//////////////////////////////////////////////////////////////////////////////////////////////
	// -- Map to BH format
	//////////////////////////////////////////////////////////////////////////////////////////////
	bh_layout := business_header.Layout_Business_Header_New;

	bh_layout Translate_IN_To_BHF(Layout_IN_Local L, unsigned2 cnt) := 
	transform
		SELF.source										:= Source_Codes.IN;
		SELF.source_group 						:= (qstring34)trim(l.rawfields.PERMIT_NUMBER,left,right);
		SELF.group1_id 								:= L.record_id;
		SELF.vl_id 								    := (string34)trim(l.rawfields.PERMIT_NUMBER,left,right);
		SELF.vendor_id 								:= self.source_group;
		SELF.dt_first_seen						:= l.dt_first_seen;
		SELF.dt_last_seen							:= l.dt_last_seen;
		SELF.dt_vendor_first_reported	:= L.dt_vendor_first_reported;
		SELF.dt_vendor_last_reported	:= L.dt_vendor_last_reported;
		SELF.company_name							:= choose(cnt,l.rawfields.CORPORATION, l.rawfields.DOING_BUSINESS_AS);
		SELF.prim_range								:= L.Clean_address.prim_range			; 
		SELF.predir										:= L.Clean_address.predir					;
		SELF.prim_name								:= L.Clean_address.prim_name			;
		SELF.addr_suffix							:= L.Clean_address.addr_suffix		;
		SELF.postdir									:= L.Clean_address.postdir				;
		SELF.unit_desig								:= L.Clean_address.unit_desig			;
		SELF.sec_range								:= L.Clean_address.sec_range			;
		SELF.city											:= L.Clean_address.v_city_name		;
		SELF.state										:= L.Clean_address.st							;
		SELF.zip											:= (UNSIGNED3)L.Clean_address.zip	;
		SELF.zip4											:= (UNSIGNED2)L.Clean_address.zip4;
		SELF.county										:= L.Clean_address.fips_county		;
		SELF.msa											:= L.Clean_address.msa						;
		SELF.geo_lat									:= L.Clean_address.geo_lat				;			
		SELF.geo_long									:= L.Clean_address.geo_long				;
		SELF.phone										:= (unsigned6)0; 
		SELF.phone_score 							:= IF(self.Phone = 0, 0, 1);;
		SELF.fein 										:= 0;
		SELF.current									:= TRUE;
		SELF.dppa 										:= FALSE;
	end;

	from_IN_proj := normalize(IN_Seq, 2,Translate_IN_To_BHF(LEFT,counter));

	//////////////////////////////////////////////////////////////////////////////////////////////
	// -- Do standard BH rollup with no filter, group1_id rollup, or fixing the company name
	//////////////////////////////////////////////////////////////////////////////////////////////
//	IN_clean_rollup := Business_Header.As_Business_Header_Function(from_IN_proj, false, false, false);
	IN_clean_rollup := from_IN_proj(company_name != '');

	return IN_clean_rollup;

end;
