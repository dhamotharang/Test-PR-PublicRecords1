IMPORT Business_Header, ut;
export fAs_Business_Header_CT(

	dataset(layouts.base.CT) pInput = files().base.CT.qa

) :=
function

	CT_base := pInput;

	//////////////////////////////////////////////////////////////////////////////////////////////
	// -- Add unique record id to CT file
	//////////////////////////////////////////////////////////////////////////////////////////////
	Layout_CT_Local := 
	record
		UNSIGNED6 record_id := 0;
		layouts.base.CT;
	end;

	Layout_CT_Local AddRecordID(layouts.base.CT L) := 
	transform
		self := L;
		self.record_id := 0;
	end;

	CT_Init := PROJECT(CT_base, AddRecordID(LEFT));

	ut.MAC_Sequence_Records(CT_Init, record_id, CT_Seq);

	//////////////////////////////////////////////////////////////////////////////////////////////
	// -- Map to BH format
	//////////////////////////////////////////////////////////////////////////////////////////////
	bh_layout := business_header.Layout_Business_Header_New;

	bh_layout Translate_CT_To_BHF(Layout_CT_Local L, unsigned2 cnt) := 
	transform
		SELF.source										:= Source_Codes.CT;
		SELF.source_group 						:= (qstring34)hash(
																	trim(l.rawfields.Business_Name,left,right)
																+	trim(l.rawfields.DBA_Name,left,right)
																+	trim(l.rawfields.Address,left,right)
																+	trim(l.rawfields.Number,left,right)
																+	trim(l.rawfields.Effective_Date,left,right)
															);
		SELF.group1_id 								:= L.record_id;
		SELF.vl_id 								    := '';
		SELF.vendor_id 								:= self.source_group;
		SELF.dt_first_seen						:= l.dt_first_seen;
		SELF.dt_last_seen							:= l.dt_last_seen;
		SELF.dt_vendor_first_reported	:= L.dt_vendor_first_reported;
		SELF.dt_vendor_last_reported	:= L.dt_vendor_last_reported;
		SELF.company_name							:= choose(cnt,l.rawfields.DBA_NAME, l.rawfields.Business_Name);
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
		SELF.phone										:= (unsigned6)0										; 
		SELF.phone_score 							:= IF(self.Phone = 0, 0, 1);;
		SELF.fein 										:= 0;
		SELF.current									:= TRUE;
		SELF.dppa 										:= FALSE;
	end;

	from_CT_proj := normalize(CT_Seq, 2,Translate_CT_To_BHF(LEFT,counter));

	//////////////////////////////////////////////////////////////////////////////////////////////
	// -- Do standard BH rollup with no filter, group1_id rollup, or fixing the company name
	//////////////////////////////////////////////////////////////////////////////////////////////
//	CT_clean_rollup := Business_Header.As_Business_Header_Function(from_CT_proj, false, false, false);
	CT_clean_rollup := from_CT_proj(company_name != '');

	return CT_clean_rollup;

end;
