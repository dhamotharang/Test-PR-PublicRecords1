IMPORT Business_Header, ut;
export fAs_Business_Header_NJ(dataset(layouts.base.NJ) pInput) :=
function

	NJ_base := pInput;

	//////////////////////////////////////////////////////////////////////////////////////////////
	// -- Add unique record id to NJ file
	//////////////////////////////////////////////////////////////////////////////////////////////
	Layout_NJ_Local := 
	record
		UNSIGNED6 record_id := 0;
		layouts.base.NJ;
	end;

	Layout_NJ_Local AddRecordID(layouts.base.NJ L) := 
	transform
		self := L;
		self.record_id := 0;
	end;

	NJ_Init := PROJECT(NJ_base, AddRecordID(LEFT));

	ut.MAC_Sequence_Records(NJ_Init, record_id, NJ_Seq);

	//////////////////////////////////////////////////////////////////////////////////////////////
	// -- Map to BH format
	//////////////////////////////////////////////////////////////////////////////////////////////
	bh_layout := business_header.Layout_Business_Header_New;

	bh_layout Translate_NJ_To_BHF(Layout_NJ_Local L) := 
	transform
		SELF.source						 := Source_Codes.NJ;
		SELF.source_group 				 := l.rawfields.RegistrationNumber;
		SELF.group1_id 					 := L.record_id;
		SELF.vl_id 					     := l.rawfields.RegistrationNumber; 
		SELF.vendor_id 					 := l.rawfields.RegistrationNumber; 
		SELF.dt_first_seen				 := l.dt_first_seen;
		SELF.dt_last_seen				 := l.dt_last_seen;
		SELF.dt_vendor_first_reported	 := L.dt_vendor_first_reported;
		SELF.dt_vendor_last_reported	 := L.dt_vendor_last_reported;
		SELF.company_name				 :=	l.rawfields.name;
		SELF.prim_range					 := L.Clean_address.prim_range;
		SELF.predir						 := L.Clean_address.predir;
		SELF.prim_name					 := L.Clean_address.prim_name;
		SELF.addr_suffix				 := L.Clean_address.addr_suffix;
		SELF.postdir					 := L.Clean_address.postdir;
		SELF.unit_desig					 := L.Clean_address.unit_desig;
		SELF.sec_range					 := L.Clean_address.sec_range;
		SELF.city						 := L.Clean_address.v_city_name;
		SELF.state						 := L.Clean_address.st;
		SELF.zip						 := (UNSIGNED3)L.Clean_address.zip;
		SELF.zip4						 := (UNSIGNED2)L.Clean_address.zip4;
		SELF.county						 := L.Clean_address.fips_county;
		SELF.msa						 := L.Clean_address.msa;
		SELF.geo_lat					 := L.Clean_address.geo_lat;				
		SELF.geo_long					 := L.Clean_address.geo_long;
		SELF.fein 						 := 0;
		SELF.current 						:= if(l.record_type = 'C', TRUE, false);
		SELF.dppa 						 := FALSE; 
		self := []; 
	 end;

	from_NJ_proj := project(NJ_Seq,Translate_NJ_To_BHF(LEFT));

	//////////////////////////////////////////////////////////////////////////////////////////////
	// -- Do standard BH rollup with no filter, group1_id rollup, or fixing the company name
	//////////////////////////////////////////////////////////////////////////////////////////////
//	NJ_clean_rollup := Business_Header.As_Business_Header_Function(from_NJ_proj, false, false, false);
	NJ_clean_rollup := from_NJ_proj(company_name != '', ut.IsCompany(company_name));

	return NJ_clean_rollup;

end;
