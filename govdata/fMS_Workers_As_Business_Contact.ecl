import business_header, ut,mdr;

export fMS_Workers_As_Business_Contact(dataset(Layout_MS_Workers_Comp_base) pBasefile) :=
function

	f := pBasefile;

	Business_Header.Layout_Business_Contact_Full_New into(f L) := transform
		// Gen Data      
		SELF.did := 0;  
		self.bdid := L.bdid;
		SELF.vl_id := 'MS' + if(L.carrier_claim_no != '', L.carrier_claim_no, L.employer_fein + l.mwee_no);
		SELF.vendor_id := 'MS' + if(L.carrier_claim_no != '', L.carrier_claim_no, L.employer_fein + l.mwee_no);
		SELF.dt_first_seen := (integer)if((integer)l.date_claim_filed=20, l.date_of_injury, l.date_claim_filed);
		SELF.dt_last_seen := (integer)if((integer)l.date_claim_filed=20, l.date_of_injury, l.date_claim_filed);
		SELF.source := MDR.sourceTools.src_MS_Worker_Comp;
		SELF.record_type := 'C';
		
		// Person data
		SELF.company_title := '';   // Title of Contact at Company if available
		SELF.title := L.claim_name_prefix;
		SELF.fname := L.claim_name_first;
		SELF.mname := L.claim_name_middle;
		SELF.lname := L.claim_name_last;
		SELF.name_suffix := L.claim_name_suffix;
		SELF.name_score := L.claim_name_score;
		SELF.prim_range := L.claimant_prim_range;
		SELF.predir := L.claimant_predir;
		SELF.prim_name := L.claimant_prim_name;
		SELF.addr_suffix := L.claimant_addr_suffix;
		SELF.postdir := L.claimant_postdir;
		SELF.unit_desig := L.claimant_unit_desig;
		SELF.sec_range := L.claimant_sec_range;
		SELF.city := L.claimant_v_city_name;
		SELF.state := L.claimant_st;
		SELF.zip := (INTEGER)L.claimant_zip;
		SELF.zip4 := (INTEGER)L.claimant_zip4;
		SELF.county := L.claimant_fipscounty;
		SELF.msa := L.claimant_msa;
		SELF.geo_lat := L.claimant_geo_lat;
		SELF.geo_long := L.claimant_geo_long;
		SELF.phone := 0;
		SELF.email_address := '';
		SELF.ssn := (INTEGER)L.claimant_ssn;
			
		// Business Data
		SELF.company_source_group := '';
		SELF.company_name := L.employer_name;
		SELF.company_prim_range := L.emp_prim_range;
		SELF.company_predir := L.emp_predir;
		SELF.company_prim_name := L.emp_prim_name;
		SELF.company_addr_suffix := L.emp_addr_suffix;
		SELF.company_postdir := L.emp_postdir;
		SELF.company_unit_desig := L.emp_unit_desig;
		SELF.company_sec_range := L.emp_sec_range;
		SELF.company_city := L.emp_v_city_name;
		SELF.company_state := L.emp_st;
		SELF.company_zip := (INTEGER)L.emp_zip5;
		SELF.company_zip4 := (INTEGER)L.emp_zip4;
		SELF.company_phone := 0;	
		SELF.company_fein := (INTEGER)L.employer_fein;
	end;

	p := project(f, into(left));

	return project(f, into(left))(lname!='');

end;