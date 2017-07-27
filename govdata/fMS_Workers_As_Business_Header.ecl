import business_header, ut,mdr;

export fMS_Workers_As_Business_Header(dataset(Layout_MS_Workers_Comp_base) pBaseFile) :=
function

	f := pBaseFile;

	Business_Header.Layout_Business_Header_New into(f L) := transform
		// Gen Data
		SELF.rcid := 0;        
		SELF.bdid := L.bdid;
		SELF.vl_id := 'MS' + if(L.carrier_claim_no != '', L.carrier_claim_no, L.employer_fein + l.mwee_no);
		SELF.vendor_id := 'MS' + if(L.carrier_claim_no != '', L.carrier_claim_no, L.employer_fein + l.mwee_no);
		SELF.dt_first_seen := (integer)if((integer)l.date_claim_filed=20, l.date_of_injury, l.date_claim_filed);
		SELF.dt_last_seen := (integer)if((integer)l.date_claim_filed=20, l.date_of_injury, l.date_claim_filed);
		SELF.dt_vendor_first_reported := (integer)if((integer)l.date_claim_filed=20, l.date_of_injury, l.date_claim_filed);
		SELF.dt_vendor_last_reported := (integer)if((integer)l.date_claim_filed=20, l.date_of_injury, l.date_claim_filed);
		SELF.source := MDR.sourceTools.src_MS_Worker_Comp;
		SELF.source_group := ''; 
		SELF.pflag := '';   
		SELF.group1_id := 0;  

		// Business Data
		SELF.company_name := L.employer_name;
		SELF.prim_range := L.emp_prim_range;
		SELF.predir := L.emp_predir;
		SELF.prim_name := L.emp_prim_name;
		SELF.addr_suffix := L.emp_addr_suffix;
		SELF.postdir := L.emp_postdir;
		SELF.unit_desig := L.emp_unit_desig;
		SELF.sec_range := L.emp_sec_range;
		SELF.city := L.emp_v_city_name;
		SELF.state := L.emp_st;
		SELF.zip := (INTEGER)L.emp_zip5;
		SELF.zip4 := (INTEGER)L.emp_zip4;
		SELF.county := L.emp_fipscounty;
		SELF.msa := L.emp_msa;
		SELF.geo_lat := L.emp_geo_lat;
		SELF.geo_long := L.emp_geo_long;
		SELF.phone := 0;	
		SELF.phone_score := 0;
		SELF.fein := (INTEGER)L.employer_fein;
		SELF.current := TRUE;
	end;

	p := project(f, into(left));

	return project(f, into(left))(company_name != '');
end;
