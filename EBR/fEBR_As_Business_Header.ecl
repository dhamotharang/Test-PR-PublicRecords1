IMPORT Business_Header, ut,mdr;

export fEBR_As_Business_Header(dataset(layout_0010_header_base) pInput, boolean IsPRCT = false) :=
function
	//*** Removed the filters that had in place to filert out the quartely unload records - as per Jira DF-23116.
	EBR_base := pInput;

	//////////////////////////////////////////////////////////////////////////////////////////////
	// -- Add unique record id to EBR file
	//////////////////////////////////////////////////////////////////////////////////////////////
	Layout_EBR_Local := 
	record
		UNSIGNED6 record_id := 0;
		layout_0010_header_base;
	end;

	Layout_EBR_Local AddRecordID(layout_0010_header_base L) := 
	transform
		self := L;
	end;

	EBR_Init := PROJECT(EBR_base, AddRecordID(LEFT));

	ut.MAC_Sequence_Records(EBR_Init, record_id, EBR_Seq);

	//////////////////////////////////////////////////////////////////////////////////////////////
	// -- Map to BH format
	//////////////////////////////////////////////////////////////////////////////////////////////
	bh_layout := business_header.Layout_Business_Header_New;

	bh_layout Translate_EBR_To_BHF(Layout_EBR_Local L) := 
	transform
		SELF.bdid							:= if(isPRCT, L.bdid, 0);
	  SELF.group1_id 				:= L.record_id;
		SELF.vl_id 				    := L.FILE_NUMBER;
	  SELF.vendor_id 				:= L.FILE_NUMBER;
		SELF.phone 						:= (UNSIGNED6)((UNSIGNED8)L.PHONE_NUMBER);
	  SELF.phone_score 			:= IF((UNSIGNED8)L.PHONE_NUMBER = 0, 0, 1);
	  SELF.source 					:= MDR.sourceTools.src_EBR;
	  SELF.source_group 		:= L.FILE_NUMBER;
	  SELF.company_name 		:= L.COMPANY_NAME;
	  SELF.dt_first_seen 		:= map(Business_Header.validatedate(L.file_estab_date,1) <> '' => 
																			(UNSIGNED4)Business_Header.validatedate(L.file_estab_date,1) * 100,
																 Business_Header.validatedate(L.extract_date)    <> '' => 
																			(UNSIGNED4)Business_Header.validatedate(L.extract_date),0);
	  SELF.dt_last_seen 			:= self.dt_first_seen;
	  SELF.dt_vendor_first_reported	:= if(Business_Header.validatedate(L.extract_date) <> '', 
																				(UNSIGNED4)Business_Header.validatedate(L.extract_date),0);
	  SELF.dt_vendor_last_reported	:= self.dt_vendor_first_reported;
	  SELF.fein 						:= 0;
	  SELF.current 					:= TRUE;
	  SELF.prim_range 			:= L.prim_range;
	  SELF.predir 					:= L.predir;
	  SELF.prim_name 				:= L.prim_name;
	  SELF.addr_suffix 			:= L.addr_suffix;
	  SELF.postdir 					:= L.postdir;
	  SELF.unit_desig 			:= L.unit_desig;
	  SELF.sec_range 				:= L.sec_range;
	  SELF.city 						:= L.v_city_name;
	  SELF.state 						:= L.st;
	  SELF.zip 							:= (UNSIGNED3)L.zip;
	  SELF.zip4 						:= (UNSIGNED2)L.zip4;
	  SELF.county 					:= L.county[3..5];
	  SELF.msa 							:= L.msa;
	  SELF.geo_lat 					:= L.geo_lat;
	  SELF.geo_long 				:= L.geo_long;
	end;

	from_EBR_proj := project(EBR_Seq, Translate_EBR_To_BHF(LEFT));

	//////////////////////////////////////////////////////////////////////////////////////////////
	// -- Do standard BH rollup with no filter, group1_id rollup, or fixing the company name
	//////////////////////////////////////////////////////////////////////////////////////////////
	EBR_clean_rollup := Business_Header.As_Business_Header_Function(from_EBR_proj, false, false, false);

	return if(isPRCT, from_EBR_proj, EBR_clean_rollup);

end;