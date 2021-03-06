IMPORT Business_Header, ut,mdr;
export fAs_Business_Header_Combined(

	dataset(layouts.Base.Layout_Combined) pInput = files().base.Combined.qa

) :=
function

	All_base := pInput( (rawfields.corporate_address.uszip <> '' OR 
	                     rawfields.corporate_address.state <> '' OR 
	                     StringLib.StringToUpperCase(rawfields.corporate_address.country) = ''),
						(rawfields.mailing_address.uszip <> '' OR 
	                     rawfields.mailing_address.state <> '' OR 
	                     StringLib.StringToUpperCase(rawfields.mailing_address.country) = ''));

	//////////////////////////////////////////////////////////////////////////////////////////////
	// -- Add unique record id 
	//////////////////////////////////////////////////////////////////////////////////////////////
	Layout_All_Local := 
	record
		UNSIGNED6 record_id := 0;
		layouts.base.Layout_Combined;
	end;

	Layout_All_Local AddRecordID(layouts.base.Layout_Combined L) := 
	transform
		self := L;
		self.record_id := 0;
	end;

	All_Init := PROJECT(All_base, AddRecordID(LEFT));

	ut.MAC_Sequence_Records(All_Init, record_id, All_Seq);

	//////////////////////////////////////////////////////////////////////////////////////////////
	// -- Map to BH format
	//////////////////////////////////////////////////////////////////////////////////////////////
	bh_layout := business_header.Layout_Business_Header_New;

	bh_layout Translate_All_To_BHF(Layout_All_Local L) := 
	transform
		SELF.vl_id              := '';
		SELF.source						 := MDR.sourceTools.src_Redbooks; 
		SELF.source_group 			:= (qstring34)L.Rawfields.Key_Fields.DocId; 
		SELF.group1_id 					 := L.record_id;
		SELF.vendor_id 					 :=  SELF.source_group;
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
		SELF.phone             := (unsigned6)L.clean_phone;
		self := []; 
	 end;

	from_All_proj := project(All_Seq,Translate_All_To_BHF(LEFT));

	//////////////////////////////////////////////////////////////////////////////////////////////
	// -- Do standard BH rollup with no filter, group1_id rollup, or fixing the company name
	//////////////////////////////////////////////////////////////////////////////////////////////
//	NJ_clean_rollup := Business_Header.As_Business_Header_Function(from_NJ_proj, false, false, false);
	All_clean_rollup := from_All_proj(company_name != '', ut.IsCompany(company_name));

	return All_clean_rollup;

end;
