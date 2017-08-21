IMPORT Business_Header, ut,Gong_v2;
export fAs_Business_Header_Jigsaw(

	 dataset(Layouts.Base									) pInput							= Files().base.qa
	,dataset(Gong_v2.layout_gongMasterAid	) pGongMasterBase			= Gong_v2.Files().base.gongmaster.root
	,boolean																pShouldVerifyPhones = true

) :=
function


	layouts.Temporary.Jigsaw_UniqueId AddRecordID(Layouts.Base L) := 
	transform
		self := L;
		self.unique_id := 0;
	end;

	Jigsaw_Init := PROJECT(pInput, AddRecordID(LEFT));

	ut.MAC_Sequence_Records(Jigsaw_Init, unique_id, Jigsaw_Seq);

	//verify phones since they are unreliable
	Jigsaw_base := Verify_Phone(Jigsaw_Seq,pGongMasterBase,'B');

	djigsaw_should := if(pShouldVerifyPhones = true	,Jigsaw_base	,Jigsaw_Seq);

	//////////////////////////////////////////////////////////////////////////////////////////////
	// -- Map to BH format
	//////////////////////////////////////////////////////////////////////////////////////////////
	bh_layout := business_header.Layout_Business_Header_New;

	bh_layout Translate_Jigsaw_To_BHF(layouts.Temporary.Jigsaw_UniqueId L) := 
	transform
		SELF.source						 := Source_Codes.Jigsaw;
		SELF.source_group 				 := l.rawfields.CompanyId;
		SELF.group1_id 					 := (integer)L.unique_id;
		SELF.vendor_id 					 := l.rawfields.CompanyId;
		SELF.vl_id    					 := l.rawfields.CompanyId;
		SELF.dt_first_seen				 := l.dt_first_seen;
		SELF.dt_last_seen				 := l.dt_last_seen;
		SELF.dt_vendor_first_reported	 := L.dt_vendor_first_reported;
		SELF.dt_vendor_last_reported	 := L.dt_vendor_last_reported;
		SELF.company_name				 :=	l.rawfields.CompanyName;
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
		self.phone                := (unsigned6)l.rawfields.phone; 
		self := []; 
	 end;

	from_Jigsaw_proj := project(djigsaw_should,Translate_Jigsaw_To_BHF(LEFT));

	//////////////////////////////////////////////////////////////////////////////////////////////
	// -- Do standard BH rollup with no filter, group1_id rollup, or fixing the company name
	//////////////////////////////////////////////////////////////////////////////////////////////
//	Jigsaw_clean_rollup := Business_Header.As_Business_Header_Function(from_Jigsaw_proj, false, false, false);
	Jigsaw_clean_rollup := from_Jigsaw_proj(company_name != '', ut.IsCompany(company_name));

	return Jigsaw_clean_rollup;

end;
